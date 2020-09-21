#include "btchip_base58.h"
#include "apdu_constants.h"

#define CLA 0xE0

#define GET_ADDRESS 0x02
#define TX_SIGN_START 0x06
#define TX_SIGN_PRE_MESSAGE 0x08
#define TX_SIGN 0x0A
#define TX_SIGN_TEST 0x0E
#define CHOOSE_ADDRESS 0x14

#define P1_LAST 0x80
#define P1_MORE 0x00

#define MAX_CHARS_PER_LINE 100
#define MAX_CHARS_SHOW_LINE 128

extern unsigned char hash_tainted;

extern int selected_account;

extern int confirm_account;

extern char *sign_tx;

extern cx_ecfp_private_key_t private_key;

extern cx_sha256_t hash;

int get_address(int num, char *output);

int set_key(int num);

int init_key();

void handle_business(void);

const bagl_element_t *io_seproxyhal_touch_deny(const bagl_element_t *e);

const bagl_element_t*
io_seproxyhal_touch_approve(const bagl_element_t *e);

static int public_key_hash160(unsigned char *in, unsigned short inlen,
                               unsigned char *out); 