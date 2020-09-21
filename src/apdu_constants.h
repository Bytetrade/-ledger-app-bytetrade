#ifndef _DATA_CONFIG_
#define _DATA_CONFIG_

#include "os.h"
#include "cx.h"
#include "ux.h"

#include <string.h>

#ifndef TARGET_BLUE
  #include "os_io_seproxyhal.h"
#else
  void io_seproxyhal_io_heartbeat(void) {}
#endif

#define all_data_size 856

extern char all_data[all_data_size];

extern char ui_address[38];

extern char ui_sign_message[128];

const static short encode_data_p = 0;
const static short sign_data_p = 0;
const static short message_data_p = 0;
const static short cache_data_p = 600;


#define N_storage (*(volatile internalStorage_t*) PIC(&N_storage_real))

typedef struct internalStorage_t {
  int initialized;
  int account_number;
} internalStorage_t;

extern const internalStorage_t N_storage_real;

extern unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];

char *get_cache_buffer();

#endif /* _DATA_CONFIG_ */