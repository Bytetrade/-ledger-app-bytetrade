#include "apdu_constants.h"

typedef enum ui_state_e {
	UI_MAIN,
    UI_MAIN_CHOOSE_ACCOUNT,
    UI_MAIN_CREATE_ACCOUNT,
    UI_MAIN_EXIT,
    UI_CHOOSE_ACCOUNT,
    UI_CREATE_ACCOUNT,
    UI_ACCOUNT_BACK,
    UI_CONFIRM_ACCOUNT,
    UI_SIGN_TX,
    UI_APPROVAL_TX
} ui_state;

void show(enum ui_state_e state);

enum ui_state_e get_ui_state_now();
