#include "context.h"

const bagl_element_t *sync_finished() {
    
    G_io_apdu_buffer[0] = 0x90;
    G_io_apdu_buffer[1] = 0x00;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
}

const bagl_element_t *sync_cancel() {
    
    G_io_apdu_buffer[0] = 0x90;
    G_io_apdu_buffer[1] = 0x20;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
}

unsigned int
ui_choose_account_zero_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter){

    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:

        if(selected_account > 0){
            // show(UI_MAIN);
            selected_account--;
            set_key(selected_account);
            show(UI_CHOOSE_ACCOUNT);
        }
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        // show(UI_MAIN_CREATE_ACCOUNT);

        if(selected_account < N_storage.account_number - 1){
            selected_account++;
            set_key(selected_account);
            show(UI_CHOOSE_ACCOUNT);
        } else {
            show(UI_CREATE_ACCOUNT);
        }

        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
            show(UI_MAIN);
            break;
    }
    return 0;
};

unsigned int
ui_choose_account_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter){

    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        if(selected_account > 0){
            // show(UI_MAIN);
            selected_account--;
            set_key(selected_account);
            show(UI_CHOOSE_ACCOUNT);
        }
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        // show(UI_MAIN_CREATE_ACCOUNT);

        if(selected_account < N_storage.account_number - 1){
            selected_account++;
            set_key(selected_account);
            show(UI_CHOOSE_ACCOUNT);
        } else {
            show(UI_CREATE_ACCOUNT);
        }

        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
            show(UI_MAIN);
            break;
    }
    return 0;
};

unsigned int
ui_create_account_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter){

    int x;
    switch (button_mask) {
        case BUTTON_EVT_RELEASED | BUTTON_LEFT:
            selected_account = N_storage.account_number - 1;
            set_key(selected_account);
            show(UI_CHOOSE_ACCOUNT);
            break;
        
        case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
            show(UI_ACCOUNT_BACK);
            break;
        case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
            
            x = N_storage.account_number + 1;
            nvm_write(&N_storage.account_number, (void*)&x, sizeof(int));
            selected_account++;
            set_key(selected_account);

            show(UI_CHOOSE_ACCOUNT);

            break;
    }

    return 0;
};


unsigned int
ui_account_back_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter){

    switch (button_mask) {
        case BUTTON_EVT_RELEASED | BUTTON_LEFT:
            show(UI_CREATE_ACCOUNT);
            break;
        
        case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
            show(UI_MAIN);
            break;
    }

    return 0;
};

unsigned int
ui_confirm_account_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter){
    switch (button_mask) {
        case BUTTON_EVT_RELEASED | BUTTON_LEFT:
            set_key(selected_account);
            sync_cancel();
            show(UI_MAIN);
            break;
        
        case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
            selected_account = confirm_account;
            sync_finished();
            show(UI_MAIN);
            break;
    }

    return 0;

}
