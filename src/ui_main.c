#include "context.h"

unsigned int
ui_main_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter) {
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        show(UI_MAIN_CHOOSE_ACCOUNT);
        break;
    }

    return 0;
};

const bagl_element_t*
ui_main_nanos_prepro(const bagl_element_t *element) {
    switch (element->component.userid) {
    case 2:
        io_seproxyhal_setup_ticker(
            MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
        break;
    }
    return element;
}

unsigned int
ui_main_choose_account_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter) {
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        show(UI_MAIN);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        show(UI_MAIN_CREATE_ACCOUNT);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
        show(UI_CHOOSE_ACCOUNT);
        break;
    }
    return 0;
};

const bagl_element_t*
ui_main_choose_account_prepro(const bagl_element_t *element){
    return element;
};

unsigned int
ui_main_create_account_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter) {
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        show(UI_MAIN_CHOOSE_ACCOUNT);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        show(UI_MAIN_EXIT);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
        show(UI_CREATE_ACCOUNT);
        break;
    }
    return 0;
};

const bagl_element_t*
ui_main_create_account_prepro(const bagl_element_t *element){
    return element;
};

unsigned int
ui_main_exit_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter) {
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        show(UI_MAIN_CREATE_ACCOUNT);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
};

const bagl_element_t*
ui_main_exit_prepro(const bagl_element_t *element){
    return element;
};

const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
    return NULL; // do not redraw the widget
}
