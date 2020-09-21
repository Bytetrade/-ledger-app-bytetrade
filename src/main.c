
#include "context.h"

#define CHAINID_COINNAME "BTT"
#define CHAIN_ID 0
#define CHAINID_UPCASE "ByteTrade"

const internalStorage_t N_storage_real;

unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];

ux_state_t ux;

typedef enum chain_kind_e {
	CHAIN_KIND_BYTETRADE
} chain_kind_t;

typedef struct chain_config_s {
	const char* coinName; // ticker
	uint32_t chainId;
	chain_kind_t kind;
#ifdef TARGET_BLUE
    const char* header_text;
    unsigned int color_header;
    unsigned int color_dashboard;
#endif // TARGET_BLUE

} chain_config_t;

chain_config_t const C_chain_config = {
  .coinName = CHAINID_COINNAME " ",
  .chainId = CHAIN_ID,
  .kind = CHAIN_KIND_BYTETRADE,
#ifdef TARGET_BLUE
  .color_header = COLOR_APP,
  .color_dashboard = COLOR_APP_LIGHT,
  .header_text = CHAINID_UPCASE,
#endif // TARGET_BLUE
};

chain_config_t *chainConfig;

void app_exit(void) {

    BEGIN_TRY_L(exit) {
        TRY_L(exit) {
            os_sched_exit(-1);
        }
        FINALLY_L(exit) {

        }
    }
    END_TRY_L(exit);
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
};

unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
    switch (channel & ~(IO_FLAGS)) {
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);

            if (channel & IO_RESET_AFTER_REPLIED) {
                reset();
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}

unsigned char io_event(unsigned char channel) {
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_STATUS_EVENT:
        if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID &&
            !(U4BE(G_io_seproxyhal_spi_buffer, 3) &
              SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
            THROW(EXCEPTION_IO_RESET);
        }
        // no break is intentional
    default:
        UX_DEFAULT_EVENT();
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:

            UX_DISPLAYED_EVENT();
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
            // don't redisplay if UX not allowed (pin locked in the common bolos
            // ux ?)
        });
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
        io_seproxyhal_general_status();
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}

void app_show(enum ui_state_e state){
    show(state);
}

void app_handle_business(){
    handle_business();
}

int app_init_key(){
    init_key();
    return 0;
}

__attribute__((section(".boot"))) int main(int arg0) {
#ifdef USE_LIB_BYTETRADE
    chain_config_t local_chainConfig;
    os_memmove(&local_chainConfig, &C_chain_config, sizeof(chain_config_t));
    unsigned int libcall_params[3];
    unsigned char coinName[sizeof(CHAINID_COINNAME)];
    strcpy(coinName, CHAINID_COINNAME);
#ifdef TARGET_BLUE
    unsigned char coinNameUP[sizeof(CHAINID_UPCASE)];
    strcpy(coinNameUP, CHAINID_UPCASE);
    local_chainConfig.header_text = coinNameUP;
#endif // TARGET_BLUE
    local_chainConfig.coinName = coinName;
    BEGIN_TRY {
        TRY {
            // ensure syscall will accept us
            check_api_level(CX_COMPAT_APILEVEL);
            // delegate to ByteTrade app/lib
            libcall_params[0] = "ByteTrade";
            libcall_params[1] = 0x100; // use the Init call, as we won't exit
            libcall_params[2] = &local_chainConfig;
            os_lib_call(&libcall_params);
        }
        FINALLY {
            app_exit();
        }
    }
    END_TRY;

#else
    // exit critical section
    __asm volatile("cpsie i");

    if (arg0) {
        // is ID 1 ?
        if (((unsigned int *)arg0)[0] != 0x100) {
            os_lib_throw(INVALID_PARAMETER);
        }
        // grab the coin config structure from the first parameter
        chainConfig = (chain_config_t *)((unsigned int *)arg0)[1];
    } else {
        chainConfig = (chain_config_t *)PIC(&C_chain_config);
    }
    // init data
    selected_account = 0;
    hash_tainted = 1;
    sign_tx = &(all_data[sign_data_p]);
    
    // ensure exception will work as planned
    os_boot();

    for(;;){

        UX_INIT();

        BEGIN_TRY{
            TRY {
                io_seproxyhal_init();

                app_init_key();

                if (N_storage.initialized != 0x01) {
                    int x;
                    x = 1;
                    nvm_write(&N_storage.account_number, (void*)&x, sizeof(int));
                    x = 1;
                    nvm_write(&N_storage.initialized, (void*)&x, sizeof(int));
                }
                
    #ifdef TARGET_NANOX
                // grab the current plane mode setting
                G_io_app.plane_mode = os_setting_get(OS_SETTING_PLANEMODE, NULL, 0);
    #endif // TARGET_NANOX

    #ifdef LISTEN_BLE
                if (os_seph_features() &
                    SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_BLE) {
                    BLE_power(0, NULL);
                    // restart IOs
                    BLE_power(1, NULL);
                }
    #endif

                USB_power(0);
                USB_power(1);

                app_show(UI_MAIN);
                
                app_handle_business();
            }
            CATCH(EXCEPTION_IO_RESET) {
              // reset IO and UX before continuing
              CLOSE_TRY;
              continue;
            }
            CATCH_ALL {
              CLOSE_TRY;             
              break;
            }
            FINALLY {
            }
        }

        END_TRY;
    }
    app_exit();
#endif
    return 0;
};
