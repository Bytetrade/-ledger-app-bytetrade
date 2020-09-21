#include "context.h"

char *sign_tx;
cx_ecfp_private_key_t private_key;
cx_ecfp_public_key_t public_key;

unsigned char hash_tainted; 
cx_sha256_t hash;
int selected_account;
int confirm_account;

unsigned char private_component[32];

unsigned int key_path[5];

union {
    cx_sha512_t shasha;
    cx_ripemd160_t riprip;
} u;

int get_address(int num, char *output){
    
    key_path[0] = 44 | 0x80000000;
    key_path[1] = 34952 | 0x80000000;
    key_path[2] = 0 | 0x80000000;
    key_path[3] = 0;
    key_path[4] = num;

    os_perso_derive_node_bip32(CX_CURVE_256K1, key_path, 5,
                               private_component, NULL);
    cx_ecdsa_init_private_key(CX_CURVE_256K1, private_component, 32, &private_key);
    
    cx_ecfp_generate_pair(CX_CURVE_256K1, &public_key, &private_key, 1);

    return public_key_hash160(public_key.W, 65, output);
}

int set_key(int num){

    key_path[0] = 44 | 0x80000000;
    key_path[1] = 34952 | 0x80000000;
    key_path[2] = 0 | 0x80000000;
    key_path[3] = 0;
    key_path[4] = num;

    os_perso_derive_node_bip32(CX_CURVE_256K1, key_path, 5,
                               private_component, NULL);    
    cx_ecdsa_init_private_key(CX_CURVE_256K1, private_component, 32, &private_key);
    
    cx_ecfp_generate_pair(CX_CURVE_256K1, &public_key, &private_key, 1);

    public_key_hash160(public_key.W, 65, (char *) ui_address);
    return 0;
}

int init_key() {
    set_key(0);
    return 0;
}

static int public_key_hash160(unsigned char *in, unsigned short inlen,
                               unsigned char *out) {

    unsigned char *buffer1 = &(all_data[0]);
    unsigned char *buffer2 = &(all_data[40]);
    unsigned char *buffer3 = &(all_data[70]);
    unsigned char *buffer4 = &(all_data[100]);
    unsigned char *address = &(all_data[130]);
    unsigned char *buffer_58 = &(all_data[170]);

    cx_sha512_init(&u.shasha);
    cx_hash(&u.shasha.header, CX_LAST, in, inlen, buffer1);

    cx_ripemd160_init(&u.riprip);
    cx_hash(&u.riprip.header, CX_LAST, buffer1, 32, buffer2);

    cx_ripemd160_init(&u.riprip);
    cx_hash(&u.riprip.header, CX_LAST, buffer2, 20, buffer3);

    for (size_t i = 0; i < 20; ++i) {
        buffer4[i] = buffer2[i];
    }
    buffer4[20] = buffer3[0];
    buffer4[21] = buffer3[1];
    buffer4[22] = buffer3[2];
    buffer4[23] = buffer3[3];

    
    int respon = btchip_encode_base58(buffer4, 24, address, 34, buffer_58);
            
    if (respon < 0) {
        return 1;
    }

    out[0] = 'B';
    out[1] = 'T';
    out[2] = 'T';
    size_t j;
    for (j = 0; j < 34; j++) {
        out[j + 3] = address[j];
    }
    out[j + 3] = '\0';

    return 1;
}

void handle_business(void){
    volatile unsigned int rx = 0;
    volatile unsigned int txi = 0;
    volatile unsigned int flags = 0;

    
    UX_CALLBACK_SET_INTERVAL(500);

    for (;;) {

        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = txi;
                txi = 0; 
                rx = io_exchange(CHANNEL_APDU | flags, rx);
                flags = 0;

                if (rx == 0) {
                    THROW(0x6982);
                }

                if (G_io_apdu_buffer[0] == 0xF0) {
                    THROW(0x6D00);
                    CLOSE_TRY;
                    return; 
                }

                if (G_io_apdu_buffer[0] != CLA) {
                    THROW(0x6E00);
                }

                int account_number;

                switch (G_io_apdu_buffer[1]){

                    case GET_ADDRESS:{

                        account_number = G_io_apdu_buffer[5];

                        if(account_number < N_storage.account_number && account_number < 5){
                            
                            get_address(account_number, &(G_io_apdu_buffer[0]));

                            txi = 38;
                            THROW(0x9000);

                        } else {
                            THROW(0x9020);
                        }
                    }break;

                    case TX_SIGN_START:{
                        if ((G_io_apdu_buffer[2] != P1_MORE) &&
                            (G_io_apdu_buffer[2] != P1_LAST)) {
                            THROW(0x6A86);
                        }
                        if (hash_tainted) {
                            cx_sha256_init(&hash);
                            hash_tainted = 0;
                        }
                        clean_tx();

                        THROW(0x9000);
                    }break;

                    case TX_SIGN_PRE_MESSAGE:{

                        G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';

                        display_tx_pre_part();

                    }break;

                    case TX_SIGN:{
                        
                        G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';

                        show(UI_SIGN_TX);

                        flags |= IO_ASYNCH_REPLY;
                    }break;

                    case TX_SIGN_TEST:{

                        G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';

                        display_tx_part();

                        if(*(tx.encode_p) < 128){
                            for(int i = 0; i < 128 && i < *(tx.encode_p); i++){
                                G_io_apdu_buffer[i] = (char)(tx.encode[i]);
                            }
                        } else {
                            for(int i = 0; i < 128 && i < *(tx.encode_p); i++){
                                G_io_apdu_buffer[i] = (char)(tx.encode[*(tx.encode_p) - 128 + i]);
                            }
                        }
                        
                        
                        if(*(tx.encode_p) < 128){
                            txi = *(tx.encode_p);
                        } else {
                            txi = 128;
                        }
                        
                        THROW(0x9000);
                        
                    }

                    case CHOOSE_ADDRESS:{
                        
                        account_number = G_io_apdu_buffer[5];

                        if(account_number < N_storage.account_number){
                            confirm_account = account_number;
                            set_key(confirm_account);
                            show(UI_CONFIRM_ACCOUNT);
                            flags |= IO_ASYNCH_REPLY;
                        } else {
                            THROW(0x9020);
                        }
                        
                    }break;

                    case 0xFF: 
                        goto return_to_dashboard;

                    default:
                        THROW(0x6D00);
                        break;
                }
            }
            CATCH_OTHER(e) {
                switch (e & 0xF000) {
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                
                G_io_apdu_buffer[txi] = sw >> 8;
                G_io_apdu_buffer[txi + 1] = sw;
                txi += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
    }

return_to_dashboard:
    return;
}

const bagl_element_t *io_seproxyhal_touch_deny(const bagl_element_t *e) {
    hash_tainted = 1;
    G_io_apdu_buffer[0] = 0x69;
    G_io_apdu_buffer[1] = 0x85;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
    // Display back the original UX
    show(UI_MAIN);
    return 0; // do not redraw the widget
}

const bagl_element_t*
io_seproxyhal_touch_approve(const bagl_element_t *e) {
    unsigned int tx = 0;
    // Update the hash
    cx_hash(&hash.header, 0, G_io_apdu_buffer + 5, G_io_apdu_buffer[4], NULL);
    if (G_io_apdu_buffer[2] == P1_LAST) {
        // Hash is finalized, send back the signature
        unsigned char result[32];
        cx_hash(&hash.header, CX_LAST, G_io_apdu_buffer, 0, result);
        tx = cx_ecdsa_sign((void*) &private_key, CX_RND_RFC6979 | CX_LAST,
                           CX_SHA256, result, sizeof(result), G_io_apdu_buffer, NULL);
        G_io_apdu_buffer[0] &= 0xF0; // discard the parity information
        hash_tainted = 1;
    }
    G_io_apdu_buffer[tx++] = 0x90;
    G_io_apdu_buffer[tx++] = 0x00;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
    // Display back the original UX
    show(UI_MAIN);
    return 0; // do not redraw the widget
}
