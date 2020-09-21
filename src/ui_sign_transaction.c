#include "context.h"


transaction tx = {NULL,NULL,NULL,{NULL,NULL},NULL,NULL,NULL,NULL,NULL,NULL};
unsigned int current_text_pos; // parsing cursor in the text to display
static unsigned int text_y;           // current location of the displayed text

void clean_tx(){
    current_text_pos = 0;
    text_y = 60;
    for(int i = 0; i < all_data_size; i++){
        all_data[i] = 0;
    }
}

const bagl_element_t *tx_pre_data_got() {
    
    G_io_apdu_buffer[0] = 0x90;
    G_io_apdu_buffer[1] = 0x00;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
}

unsigned char display_tx_pre_part(){

    unsigned int i = 0;
    WIDE char *text = (char*) G_io_apdu_buffer + 5;
    if (text[i] == '\0') {
        return 0;
    }
    i = 0;
    while ((text[i] != 0) && (text[i] != '\n') && i < MAX_CHARS_PER_LINE && current_text_pos < 512) {
        sign_tx[current_text_pos++] = text[i];
        i++;
    }

    tx_pre_data_got(current_text_pos);
    return 1;
}

// Pick the text elements to display
unsigned char display_tx_part() {
    unsigned int i = 0;
    WIDE char *text = (char*) G_io_apdu_buffer + 5;
    if (text[i] == '\0') {
        return 0;
    }
    i = 0;
    while ((text[i] != 0) && (text[i] != '\n') && i < MAX_CHARS_PER_LINE && current_text_pos < 512) {
        sign_tx[current_text_pos++] = text[i];
        i++;
    }

    int ml = cache_data_p - current_text_pos;
    for(int m = current_text_pos; m >= 0; m--){
        all_data[m + ml] = all_data[m];
    }

    ui_sign_message[0] = 'n';
    ui_sign_message[1] = 'o';
    ui_sign_message[2] = 'd';
    ui_sign_message[3] = 'a';
    ui_sign_message[4] = 't';
    ui_sign_message[5] = 'a';
    ui_sign_message[6] = '\0';

    tx.operation.data = &ui_sign_message;

    build_transaction(&(all_data[ml]), current_text_pos, &tx);

#ifdef TARGET_BLUE
    os_memset(bagl_ui_text, 0, sizeof(bagl_ui_text));
    bagl_ui_text[0].component.type = BAGL_LABEL;
    bagl_ui_text[0].component.x = 4;
    bagl_ui_text[0].component.y = text_y;
    bagl_ui_text[0].component.width = 320;
    bagl_ui_text[0].component.height = TEXT_HEIGHT;
    // element.component.fill = BAGL_FILL;
    bagl_ui_text[0].component.fgcolor = 0x000000;
    bagl_ui_text[0].component.bgcolor = 0xf9f9f9;
    bagl_ui_text[0].component.font_id = DEFAULT_FONT;
    bagl_ui_text[0].text = ui_sign_message;
    text_y += TEXT_HEIGHT + TEXT_SPACE;
#endif
    return 1;
}

unsigned int
ui_sign_tx_nanos_button(unsigned int button_mask,
                                 unsigned int button_mask_counter) {
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        // if (!display_tx_part()) {
            show(UI_APPROVAL_TX);
        // } else {
        //     UX_REDISPLAY();
        // }
        break;

    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        io_seproxyhal_touch_deny(NULL);
        break;
    }
    return 0;
}

void format_signature_out(const uint8_t* signature) {
  os_memset(G_io_apdu_buffer + 1, 0x00, 64);
  uint8_t offset = 1;
  uint8_t xoffset = 4; //point to r value
  //copy r
  uint8_t xlength = signature[xoffset-1];
  if (xlength == 33) {
    xlength = 32;
    xoffset ++;
  }
  memmove(G_io_apdu_buffer+offset+32-xlength,  signature+xoffset, xlength);
  offset += 32;
  xoffset += xlength +2; //move over rvalue and TagLEn
  //copy s value
  xlength = signature[xoffset-1];
  if (xlength == 33) {
    xlength = 32;
    xoffset ++;
  }
  memmove(G_io_apdu_buffer+offset+32-xlength, signature+xoffset, xlength);
}

const bagl_element_t*
io_seproxyhal_touch_approve_tx(const bagl_element_t *e) {
    unsigned int tx_p = 0;
    
    unsigned int info = 0;
    // unsigned char result[32];
    // unsigned char result2[100];
    for(int c = 0; c < 256; c++){
        all_data[cache_data_p + c] = 0;
    }
    unsigned char *result = &(all_data[cache_data_p]);
    unsigned char *result2 = &(all_data[*(tx.encode_p) + 1]);

    cx_sha256_init(&hash);
    hash_tainted = 0;
    
    cx_hash(&hash.header, CX_LAST, tx.encode, *(tx.encode_p), result);
    tx_p = cx_ecdsa_sign((void*) &private_key, CX_RND_RFC6979 | CX_LAST,
                           CX_SHA256, result, sizeof(result), result2, &info);

    // G_io_apdu_buffer[0] &= 0xF0;
    hash_tainted = 1;

    G_io_apdu_buffer[0] = 27;

    if (info & CX_ECCINFO_PARITY_ODD) {
      G_io_apdu_buffer[0]++;
    }
    if (info & CX_ECCINFO_xGTn) {
      G_io_apdu_buffer[0] += 2;
    }

    format_signature_out(result2);
    tx_p = 65;

    G_io_apdu_buffer[tx_p++] = 0x90;
    G_io_apdu_buffer[tx_p++] = 0x00;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx_p);
    // Display back the original UX
    show(UI_MAIN);
    return 0; // do not redraw the widget
}

unsigned int
ui_approval_tx_nanos_button(unsigned int button_mask,
                              unsigned int button_mask_counter) {
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        io_seproxyhal_touch_approve_tx(NULL);
        break;

    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        io_seproxyhal_touch_deny(NULL);
        break;
    }
    return 0;
}

const bagl_element_t*
ui_sign_tx_nanos_prepro(const bagl_element_t *element) {
    switch (element->component.userid) {
    case 2:
        io_seproxyhal_setup_ticker(
            MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
        break;
    }
    return element;
}
