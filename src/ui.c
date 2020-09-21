#include "context.h"

enum ui_state_e ui_state_now;

void show(enum ui_state_e state){

    ui_state_now = state;

#ifdef TARGET_BLUE
    switch(state){
        case UI_MAIN:
            
            UX_DISPLAY(ui_main_blue, NULL);
            break;
        case UI_SIGN_TX:
            display_tx_part();
            UX_DISPLAY(ui_sign_tx_blue, NULL);
            break;
        case UI_APPROVAL_TX:
            UX_DISPLAY(ui_approval_tx_blue, NULL);
            break;
        default:
            break;
    }
    
#else
    switch(state){
        case UI_MAIN:
            UX_DISPLAY(ui_main_nanos, ui_main_nanos_prepro);
            break;
        case UI_MAIN_CHOOSE_ACCOUNT:
            UX_DISPLAY(ui_main_choose_account_nanos, ui_main_nanos_prepro);
            break;
        case UI_MAIN_CREATE_ACCOUNT:
            UX_DISPLAY(ui_main_create_account_nanos, ui_main_nanos_prepro);
            break;
        case UI_CHOOSE_ACCOUNT:

            if(selected_account == 0){
                UX_DISPLAY(ui_choose_account_zero_nanos, ui_main_nanos_prepro);
            } else {
                UX_DISPLAY(ui_choose_account_nanos, ui_main_nanos_prepro);
            }

            break;
        case UI_CREATE_ACCOUNT:
            UX_DISPLAY(ui_create_account_nanos, ui_main_nanos_prepro);
            break;
        case UI_ACCOUNT_BACK:
            UX_DISPLAY(ui_account_back_nanos, ui_main_nanos_prepro);
            break;
        case UI_CONFIRM_ACCOUNT:

            
            UX_DISPLAY(ui_confirm_account_nanos, ui_main_nanos_prepro);
            break;
        case UI_MAIN_EXIT:
            UX_DISPLAY(ui_main_exit_nanos, ui_main_nanos_prepro);
            break;
        case UI_SIGN_TX:
            display_tx_part();
            UX_DISPLAY(ui_sign_tx_nanos, ui_sign_tx_nanos_prepro);
            break;
        case UI_APPROVAL_TX:
            UX_DISPLAY(ui_approval_tx_nanos, ui_sign_tx_nanos_prepro);
            break;
        default:
            break;
    }
    
#endif
    
}

enum ui_state_e get_ui_state_now(){
    return ui_state_now;
};