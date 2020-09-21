#include "apdu_constants.h"

char all_data[all_data_size];

char ui_address[38];

char ui_sign_message[128];

char *get_cache_buffer(){
    return (char *)&(all_data[cache_data_p]);
};