#include "context.h"

static char *flag;
static char *cache;

// static char log[100];
// static short log_p;

int find_value_length;
int find_i;
int find_info_start;
int find_info_delimiter;
bool internal_structure_type_1;
bool internal_structure_type_2;
bool internal_structure;
int proposed_ops_array_size;

uint128_t uint128_t_cache1 = {0,0};
uint128_t uint128_t_cache2 = {0,0};
uint128_t uint128_t_cache3 = {0,0};

void clean_cache(char *cache, int size){
    int i = 0;
    while(i < size){
        cache[i++] = 0;
    }
}

int get_id(char *value, int length){
    int id = 0;
    for(int z = 0; z < length; z++){
        id = id * 10;
        id += (value[z] - 48);
    }
    return id;
}

int find_data_processor(char *value, char *flag, char *input, int length, short key_length, operation_data *operation, bool copy_to_cache){

    // log[log_p++] = 'f';
    // log[log_p++] = '-';
    // log[log_p++] = flag[0];
    // log[log_p++] = flag[1];
    // log[log_p++] = '-';

    find_value_length = 0;

    while(find_i < length){

        if(internal_structure == false){
            if(input[find_i] == '['){
                internal_structure_type_1 = true;
            }

            if(input[find_i] == '{'){
                internal_structure_type_2 = true;
            }

            if(input[find_i] == ']'){
                internal_structure_type_1 = false;
            }

            if(input[find_i] == '}'){
                internal_structure_type_2 = false;
            }
        }
        
        if(input[find_i] == '=' && internal_structure_type_1 == false && internal_structure_type_2 == false){
            find_info_delimiter = find_i;
            // log[log_p++] = '=';
            // log[log_p++] = (char)(i + 48);
            // log[log_p++] = '-';
        }

        if(input[find_i] == ',' && internal_structure_type_1 == false && internal_structure_type_2 == false){

            // log[log_p++] = ',';
            // log[log_p++] = (char)(i+48);
            // log[log_p++] = '-';

            if(strncmp(&(input[find_info_start]), flag, key_length) == 0){

                find_value_length = find_i - find_info_delimiter - 1;
                
                // log[log_p++] = 'c';
                // log[log_p++] = (char)(info_delimiter + 1 + 48);
                // log[log_p++] = '-';
                // log[log_p++] = (char)(value_length + 48);
                // log[log_p++] = '-';

                if(copy_to_cache){
                    os_memcpy(value, &(input[find_info_delimiter + 1]), find_value_length);
                }
                
                // os_memcpy(&(log[log_p]), &(input[find_info_delimiter + 1]), find_value_length);
                // log_p += find_value_length;
                // log[log_p++] = '-';

                // os_memcpy(&(log[log_p]), value, value_length);
                // log_p += value_length;
                // log[log_p++] = '-';

                return find_value_length;
            }
            find_info_start = find_i + 1;
        }

        find_i++;
    }

    // os_memcpy(&(operation->data[0]), (unsigned char *)log, logp);

    
    find_i = 0;
    find_info_start = 0;
    find_info_delimiter = 0;

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
}

void read_message(cache_holder ch){

    os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
    *(ch.data_p) += *(ch.value_length);
    ch.operation->data[(*(ch.data_p))++] = ',';
    // clean_cache(ch.cache, ch.cache_length);
}

get_uint_128(uint128_t *value, cache_holder ch){

    // log[log_p++] = 't';
    // log[log_p++] = *(ch.value_length);

    uint128_t *ten = &uint128_t_cache2;
    clear128(ten);
    UPPER_P(ten) = 0;
    LOWER_P(ten) = 10;

    uint128_t *read = &uint128_t_cache3;

    for(int i = 0; i < *(ch.value_length); i++){
        mul128(value, ten, value);

        clear128(read);
        UPPER_P(read) = 0;
        LOWER_P(read) = (ch.cache[i] - 48);
        add128(value, read, value);

        // log[log_p++] = ch.cache[i];
    }
}

void find_fee(cache_holder ch, bool *go_next){
    ch.flag = "fee";
    int pre_str_size = 3;
    (*(ch.value_length)) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint128_t *fee = &uint128_t_cache1;
    clear128(fee);
    UPPER_P(fee) = 0;
    LOWER_P(fee) = 0;
    get_uint_128(fee, ch);

    int p = get_uint_128_bytes(fee, &(ch.encode[(*(ch.encode_p))]));
    (*(ch.encode_p)) += p;

    // log[log_p++] = 'd';
    // log[log_p++] = (*(ch.encode_p));
    // get_uint_128_bytes(&fee, &(log[log_p]));
    // log_p += 16;
    // log[log_p++] = 'd';
    
#ifdef UI_SHOW_FEE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"fee=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        // operation->data[data_p++] = (char)(value_length + 48);
        read_message(ch);
    }
#endif 
    
    while(p < 16){};

    (*go_next) = true;
}

short find_creator(cache_holder ch, bool *go_next){
    ch.flag = "creator";
    int pre_str_size = 7;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    // log[log_p++] = 'd';
    // log[log_p++] = *(ch.encode_p);
    // log[log_p++] = 'd';

    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
    *(ch.encode_p) += *(ch.value_length);

    // log[log_p++] = (*(ch.value_length) + 48);

#ifdef UI_SHOW_CREATOR
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"creator=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 

    *go_next = true;
}

short find_proposaler(cache_holder ch, bool *go_next){
    ch.flag = "proposaler";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    // log[log_p++] = 'd';
    // log[log_p++] = *(ch.encode_p);
    // log[log_p++] = 'd';

    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
    *(ch.encode_p) += *(ch.value_length);

    // log[log_p++] = (*(ch.value_length) + 48);

#ifdef UI_PROPOSALER
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"proposaler=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 

    *go_next = true;
}

short find_pledger(cache_holder ch, bool *go_next){
    ch.flag = "pledger";
    int pre_str_size = 7;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);

    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
    *(ch.encode_p) += *(ch.value_length);

#ifdef UI_SHOW_PLEDGER
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"pledger=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 

    *go_next = true;
}

void find_side(cache_holder ch){
    ch.flag = "side";
    int pre_str_size = 4;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    ch.encode[(*(ch.encode_p))++] = (char) (ch.cache[0] - 48);

#ifdef UI_SHOW_SIDE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"side=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_order_type(cache_holder ch){
    ch.flag = "order_type";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);

    ch.encode[(*(ch.encode_p))++] = (char) (ch.cache[0] - 48);

#ifdef UI_SHOW_ORDER_TYPE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"order_type=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_market_name(cache_holder ch){
    ch.flag = "market_name";
    int pre_str_size = 11;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
    *(ch.encode_p) += *(ch.value_length);

#ifdef UI_SHOW_MARKET_NAME
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"market_name=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_from(cache_holder ch){
    ch.flag = "from";
    int pre_str_size = 4;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
    *(ch.encode_p) += *(ch.value_length);

#ifdef UI_SHOW_FROM
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"from=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_to(cache_holder ch){
    ch.flag = "to";
    int pre_str_size = 2;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
    *(ch.encode_p) += *(ch.value_length);

#ifdef UI_SHOW_TO
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"to=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_to_external_address(cache_holder ch){
    ch.flag = "to_external_address";
    int pre_str_size = 19;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
    *(ch.encode_p) += *(ch.value_length);

#ifdef UI_SHOW_TO_EXTERNAL_ADDRESS
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"to_external_address=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_message(cache_holder ch){
    ch.flag = "message";
    int pre_str_size = 7;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    if(*(ch.value_length) > 0){
        ch.encode[(*(ch.encode_p))++] = 1;

        ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
        os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
        *(ch.encode_p) += *(ch.value_length);
    } else {
        ch.encode[(*(ch.encode_p))++] = 0;
    }

#ifdef UI_SHOW_MESSAGE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"message=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_amount(cache_holder ch, bool *go_next){
    ch.flag = "amount";
    int pre_str_size = 6;
    (*(ch.value_length)) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint128_t *amount = &uint128_t_cache1;
    clear128(amount);
    UPPER_P(amount) = 0;
    LOWER_P(amount) = 0;
    get_uint_128(amount, ch);

    int p = get_uint_128_bytes(amount, &(ch.encode[(*(ch.encode_p))]));
    (*(ch.encode_p)) += p;


#ifdef UI_SHOW_AMOUNT
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"amount=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 

    // while(p < 16){};

    (*go_next) = true;
}

void find_price(cache_holder ch){
    ch.flag = "price";
    int pre_str_size = 5;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint128_t *price = &uint128_t_cache1;
    clear128(price);
    UPPER_P(price) = 0;
    LOWER_P(price) = 0;
    get_uint_128(price, ch);

    int p = get_uint_128_bytes(price, &(ch.encode[(*(ch.encode_p))]));
    (*(ch.encode_p)) += p;

#ifdef UI_SHOW_PRICE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"price=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_use_btt_as_fee(cache_holder ch){
    ch.flag = "use_btt_as_fee";
    int pre_str_size = 14;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    if(strncmp((unsigned char *)(ch.cache), (unsigned char *)"true", *(ch.value_length)) == 0){
        ch.encode[(*(ch.encode_p))++] = 1;
    } else {
        ch.encode[(*(ch.encode_p))++] = 0;
    }

#ifdef UI_SHOW_USE_BTT_AS_FEE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"use_btt_as_fee=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_freeze_btt_fee(cache_holder ch){
    ch.flag = "freeze_btt_fee";
    int pre_str_size = 14;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    if(*(ch.value_length) > 0){

        ch.encode[(*(ch.encode_p))++] = 1;

        uint128_t *freeze_btt_fee = &uint128_t_cache1;
        clear128(freeze_btt_fee);
        UPPER_P(freeze_btt_fee) = 0;
        LOWER_P(freeze_btt_fee) = 0;
        get_uint_128(freeze_btt_fee, ch);

        int p = get_uint_128_bytes(freeze_btt_fee, &(ch.encode[(*(ch.encode_p))]));
        (*(ch.encode_p)) += p;
    } else {
        ch.encode[(*(ch.encode_p))++] = 0;
    }

#ifdef UI_SHOW_FREEZE_BTT_FEE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"freeze_btt_fee=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_now(cache_holder ch){
    ch.flag = "now";
    int pre_str_size = 3;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t timestamp = 0;
    for(int i = 0; i < *(ch.value_length); i++){
        timestamp = (timestamp * 10);
        timestamp += (ch.cache[i] - 48);
    }
    *(ch.encode_p) += uint32_to_bytes_net(timestamp, &(ch.encode[(*(ch.encode_p))]));

#ifdef UI_SHOW_NOW
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"now=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_expiration(cache_holder ch){
    ch.flag = "expiration";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t timestamp = 0;
    for(int i = 0; i < *(ch.value_length); i++){
        timestamp = (timestamp * 10);
        timestamp += (ch.cache[i] - 48);
    }
    *(ch.encode_p) += uint32_to_bytes_net(timestamp, &(ch.encode[(*(ch.encode_p))]));

#ifdef UI_SHOW_EXPIRATION
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"expiration=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_custom_btt_fee_rate(cache_holder ch){
    ch.flag = "custom_btt_fee_rate";
    int pre_str_size = 19;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    if(*(ch.value_length) > 0){
        ch.encode[(*(ch.encode_p))++] = 1;

        if(*(ch.value_length) > 1){
            ch.encode[(*(ch.encode_p))++] = (ch.cache[1] - 48);
            ch.encode[(*(ch.encode_p))++] = (ch.cache[0] - 48);
        } else {
            ch.encode[(*(ch.encode_p))++] = (ch.cache[0] - 48);
            ch.encode[(*(ch.encode_p))++] = 0;
        }
    } else {
        ch.encode[(*(ch.encode_p))++] = 0;
    }

#ifdef UI_SHOW_CUSTOM_BTT_FEE_RATE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"custom_btt_fee_rate=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_custom_no_btt_fee_rate(cache_holder ch){
    ch.flag = "custom_no_btt_fee_rate";
    int pre_str_size = 22;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    if(*(ch.value_length) > 0){
        ch.encode[(*(ch.encode_p))++] = 1;

        if(*(ch.value_length) > 1){
            ch.encode[(*(ch.encode_p))++] = (ch.cache[1] - 48);
            ch.encode[(*(ch.encode_p))++] = (ch.cache[0] - 48);
        } else {
            ch.encode[(*(ch.encode_p))++] = (ch.cache[0] - 48);
            ch.encode[(*(ch.encode_p))++] = 0;
        }
        
    } else {
        ch.encode[(*(ch.encode_p))++] = 0;
    }

#ifdef UI_SHOW_CUSTOM_NO_BTT_FEE_RATE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"custom_no_btt_fee_rate=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_money_id(cache_holder ch){
    ch.flag = "money_id";
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t num = 0;
    for(int i = 0; i < *(ch.value_length); i++){
        num = (num * 10);
        num += (ch.cache[i] - 48);
    }
    *(ch.encode_p) += uint32_to_bytes_net(num, &(ch.encode[(*(ch.encode_p))]));

#ifdef UI_SHOW_MONEY_ID
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"money_id=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_stock_id(cache_holder ch){
    ch.flag = "stock_id";
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t num = 0;
    for(int i = 0; i < *(ch.value_length); i++){
        num = (num * 10);
        num += (ch.cache[i] - 48);
    }
    *(ch.encode_p) += uint32_to_bytes_net(num, &(ch.encode[(*(ch.encode_p))]));

#ifdef UI_SHOW_STOCK_ID
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"stock_id=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_asset_type(cache_holder ch){
    ch.flag = "asset_type";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t num = 0;
    for(int i = 0; i < *(ch.value_length); i++){
        num = (num * 10);
        num += (ch.cache[i] - 48);
    }
    *(ch.encode_p) += uint32_to_bytes_net(num, &(ch.encode[(*(ch.encode_p))]));

#ifdef UI_SHOW_ASSET_TYPE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"asset_type=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_asset_fee(cache_holder ch){
    ch.flag = "asset_fee";
    int pre_str_size = 9;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    if(*(ch.value_length) > 0){

        ch.encode[(*(ch.encode_p))++] = 1;

        uint32_t num = 0;
        for(int i = 0; i < *(ch.value_length); i++){
            num = (num * 10);
            num += (ch.cache[i] - 48);
        }
        *(ch.encode_p) += uint32_to_bytes_net(num, &(ch.encode[(*(ch.encode_p))]));
    } else {
        ch.encode[(*(ch.encode_p))++] = 0;
    }

#ifdef UI_SHOW_ASSET_FEE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"asset_fee=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}

void find_order_id(cache_holder ch){
    ch.flag = "order_id";
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
    *(ch.encode_p) += *(ch.value_length);

#ifdef UI_SHOW_ORDER_ID
    // if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 ) < MAX_CHARS_SHOW_LINE - 1)){
    //     os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"order_id=", pre_str_size + 1);
    //     *(ch.data_p) += (pre_str_size + 1);
    //     read_message(ch);
    // }
#endif 
}

void find_payment_id(cache_holder ch){
    ch.flag = "payment_id";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
    *(ch.encode_p) += *(ch.value_length);

#ifdef UI_SHOW_PAYMENT_ID
    // if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 ) < MAX_CHARS_SHOW_LINE - 1)){
    //     os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"payment_id=", pre_str_size + 1);
    //     *(ch.data_p) += (pre_str_size + 1);
    //     read_message(ch);
    // }
#endif 
}

void find_contract_id(cache_holder ch){
    ch.flag = "contract_id";
    int pre_str_size = 11;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
    *(ch.encode_p) += *(ch.value_length);

#ifdef UI_SHOW_CONTRACT_ID
    // if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 ) < MAX_CHARS_SHOW_LINE - 1)){
    //     os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"contract_id=", pre_str_size + 1);
    //     *(ch.data_p) += (pre_str_size + 1);
    //     read_message(ch);
    // }
#endif 
}

void find_proposed_ops(cache_holder ch, bool *go_next_p){
    ch.flag = "proposed_ops";
    int pre_str_size = 12;
    (*(ch.value_length)) = find_data_processor(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation, false);

    // os_memcpy(&(ch.encode[*(ch.encode_p)]), &(ch.input[find_info_delimiter + 1]), *(ch.value_length));
    // *(ch.encode_p) += *(ch.value_length);

    internal_structure = true;
    find_i = find_info_delimiter;

    int ops_size = ch.input[find_info_delimiter + 1] - 48;
    ch.encode[(*(ch.encode_p))++] = (char) ops_size;

    proposed_ops_array_size = ops_size;

    
}

void build_withdraw_operation_data(cache_holder ch, bool *go_next_p){

    ch.encode[(*(ch.encode_p))++] = 4;

    find_fee(ch, go_next_p);
    find_from(ch);
    find_to_external_address(ch);
    find_asset_type(ch);
    find_amount(ch, go_next_p);
}

short build_withdraw_operation(char *input, int length, transaction *tx){

    volatile int value_length = 0;
    volatile int cache_length = 100;
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_withdraw_operation_data(ch, go_next_p);

    ch.operation->data[(*(ch.data_p))++] = '\0';

    return *(ch.encode_p);
}

void build_withdraw2_operation_data(cache_holder ch, bool *go_next_p){

    ch.encode[(*(ch.encode_p))++] = 26;

    find_fee(ch, go_next_p);
    find_from(ch);
    find_to_external_address(ch);
    find_asset_type(ch);
    find_amount(ch, go_next_p);
    find_asset_fee(ch);
}

short build_withdraw2_operation(char *input, int length, transaction *tx){

    volatile int value_length = 0;
    volatile int cache_length = 100;
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_withdraw2_operation_data(ch, go_next_p);

    ch.operation->data[(*(ch.data_p))++] = '\0';

    return *(ch.encode_p);
}

void build_transfer2_operation_data(cache_holder ch, bool *go_next_p){
    ch.encode[(*(ch.encode_p))++] = 28;

    find_fee(ch, go_next_p);
    find_from(ch);
    find_to(ch);
    find_asset_type(ch);
    find_amount(ch, go_next_p);
    find_message(ch);
}

short build_transfer2_operation(char *input, int length, transaction *tx){
    
    volatile int value_length = 0;
    volatile int cache_length = 100;
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_transfer2_operation_data(ch, go_next_p);

    ch.operation->data[(*(ch.data_p))++] = '\0';

    return *(ch.encode_p);
}

void build_order_create3_operation_data(cache_holder ch, bool *go_next_p){

    ch.encode[(*(ch.encode_p))++] = 32;

    find_fee(ch, go_next_p);
    while(*go_next_p == false){};

    *go_next_p = false;
    find_creator(ch, go_next_p);
    while(*go_next_p == false){};

    find_side(ch);
    find_order_type(ch);
    find_market_name(ch);
    find_amount(ch, go_next_p);
    find_price(ch);

    find_use_btt_as_fee(ch);
    find_freeze_btt_fee(ch);
    find_now(ch);
    find_expiration(ch);
    find_custom_btt_fee_rate(ch);
    find_custom_no_btt_fee_rate(ch);
    find_money_id(ch);
    find_stock_id(ch);
}

short build_order_create3_operation(char *input, int length, transaction *tx){

    volatile int value_length = 0;
    volatile int cache_length = 100;
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_order_create3_operation_data(ch, go_next_p);

    ch.operation->data[(*(ch.data_p))++] = '\0';

    return *(ch.encode_p);
}

void build_order_cancel2_operation_data(cache_holder ch, bool *go_next_p){
    ch.encode[(*(ch.encode_p))++] = 33;

    find_fee(ch, go_next_p);
    find_creator(ch, go_next_p);
    find_market_name(ch);
    find_order_id(ch);
    find_money_id(ch);
    find_stock_id(ch);
}

short build_order_cancel2_operation(char *input, int length, transaction *tx){

    volatile int value_length = 0;
    volatile int cache_length = 100;
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_order_cancel2_operation_data(ch, go_next_p);

    ch.operation->data[(*(ch.data_p))++] = '\0';

    return *(ch.encode_p);
}

void build_pledge_operation_data(cache_holder ch, bool *go_next_p){
    ch.encode[(*(ch.encode_p))++] = 36;

    find_fee(ch, go_next_p);
    find_pledger(ch, go_next_p);
    find_contract_id(ch);
    find_amount(ch, go_next_p);
    find_asset_type(ch);
}

short build_pledge_operation(char *input, int length, transaction *tx){

    volatile int value_length = 0;
    volatile int cache_length = 100;
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_pledge_operation_data(ch, go_next_p);

    ch.operation->data[(*(ch.data_p))++] = '\0';

    return *(ch.encode_p);
}

void build_redeem_operation_data(cache_holder ch, bool *go_next_p){

    ch.encode[(*(ch.encode_p))++] = 37;

    find_fee(ch, go_next_p);
    find_pledger(ch, go_next_p);
    find_contract_id(ch);
    find_amount(ch, go_next_p);
    find_asset_type(ch);

}

short build_redeem_operation(char *input, int length, transaction *tx){

    volatile int value_length = 0;
    volatile int cache_length = 100;
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_redeem_operation_data(ch, go_next_p);

    ch.operation->data[(*(ch.data_p))++] = '\0';

    return *(ch.encode_p);
}

void build_torrent_payment_refund_operation_data(cache_holder ch, bool *go_next_p){
    ch.encode[(*(ch.encode_p))++] = 47;

    find_fee(ch, go_next_p);
    find_payment_id(ch);
    find_creator(ch, go_next_p);
}

short build_torrent_payment_refund_operation(char *input, int length, transaction *tx){
    
    volatile int value_length = 0;
    volatile int cache_length = 100;
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_torrent_payment_refund_operation_data(ch, go_next_p);

    ch.operation->data[(*(ch.data_p))++] = '\0';

    return *(ch.encode_p);
}

void build_proposal_operation_data(cache_holder ch, bool *go_next_p){
    ch.encode[(*(ch.encode_p))++] = 18;

    find_fee(ch, go_next_p);
    find_proposaler(ch, go_next_p);
    find_expiration(ch);
    find_proposed_ops(ch, go_next_p);
    
    volatile int ops_i = 0;
    volatile int i = 0;
    volatile int find_info_delimiter_cache = find_info_delimiter;
    volatile int id;

    // find_ops :

        id = 0;
        for(; i < proposed_ops_array_size; i++){
            
            while(ops_i < (*(ch.value_length)) + 1){

                if(ch.input[find_info_delimiter_cache + ops_i] == '}'){

                    ch.flag = "id";
                    int pre_str_size = 2;
                    int op_length = find_data_processor(ch.cache, ch.flag, ch.input, ops_i, pre_str_size, ch.operation, true);
                    id = get_id(ch.cache, 2);

                    i++;
                    ops_i++;

                    // goto found_ops;

                    // switch(id){
                    //     case 4:
                    //         // build_withdraw_operation_data(ch, go_next_p);

                    //             ch.encode[(*(ch.encode_p))++] = 4;

                    //             find_fee(ch, go_next_p);
                    //             find_from(ch);
                    //             find_to_external_address(ch);
                    //             find_asset_type(ch);
                    //             find_amount(ch, go_next_p);

                    //         break;
                    //     case 18:
                    //         build_proposal_operation_data(ch, go_next_p);
                    //         break;
                    //     case 26:
                    //         build_withdraw2_operation_data(ch, go_next_p);
                    //         break;
                    //     case 28:
                    //         build_transfer2_operation_data(ch, go_next_p);
                    //         break;
                    //     case 32:
                    //         build_order_create3_operation_data(ch, go_next_p);
                    //         break;
                    //     case 33:
                    //         build_order_cancel2_operation_data(ch, go_next_p);
                    //         break;
                    //     case 36:
                    //         build_pledge_operation_data(ch, go_next_p);
                    //         break;
                    //     case 37:
                    //         build_redeem_operation_data(ch, go_next_p);
                    //         break;
                    //     // case 43:
                    //     //     l = build_torrent_payment_operation(nput, length, tx);
                    //     //     break;
                    //     case 47:
                    //         build_torrent_payment_refund_operation_data(ch, go_next_p);
                    //         break;    
                    // }

                    
                }
                ops_i++;
            }
        }

        // found_ops:

            if(id == 4){
                // build_withdraw_operation_data(ch, go_next_p);
                
                ch.encode[(*(ch.encode_p))++] = 4;

                find_fee(ch, go_next_p);
                find_from(ch);
                find_to_external_address(ch);
                find_asset_type(ch);
                find_amount(ch, go_next_p);
            }

            // if(id != 0){
            //     goto find_ops;
            // }
}

short build_proposal_operation(char *input, int length, transaction *tx) {
    volatile int value_length = 0;
    volatile int cache_length = 100;
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_proposal_operation_data(ch, go_next_p);




    // if(proposed_ops_array[0] > 0){
    // ch.operation->data[(*(ch.data_p))++] = '\0';
    // }
    ch.operation->data[(*(ch.data_p))++] = '\0';

    return *(ch.encode_p);
}

int distribution(cache_holder ch, bool *go_next_p, int id){
    
    switch(id){
        case 18:
            build_proposal_operation_data(ch, go_next_p);
            break;
        case 26:
            build_withdraw2_operation_data(ch, go_next_p);
            break;
        case 28:
            build_transfer2_operation_data(ch, go_next_p);
            break;
        case 32:
            build_order_create3_operation_data(ch, go_next_p);
            break;
        case 33:
            build_order_cancel2_operation_data(ch, go_next_p);
            break;
        case 36:
            build_pledge_operation_data(ch, go_next_p);
            break;
        case 37:
            build_redeem_operation_data(ch, go_next_p);
            break;
        // case 43:
        //     l = build_torrent_payment_operation(nput, length, tx);
        //     break;
        case 47:
            build_torrent_payment_refund_operation_data(ch, go_next_p);
            break;    
    }
    ch.operation->data[(*(ch.data_p))++] = '\0';

    return *(ch.encode_p);
}

int build_operation_distribution(char *input, int length, transaction *tx, int id){

    volatile int value_length = 0;
    volatile int cache_length = 100;
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    int l = 0;
    l = distribution(ch, go_next_p, id);

    return l;
}

int build_operation(char *input, int length, transaction *tx){

    find_value_length = 0;
    find_i = 0;
    find_info_start = 0;
    find_info_delimiter = 0;
    proposed_ops_array_size = 0;

    internal_structure_type_1 = false;
    internal_structure_type_2 = false;
    internal_structure = false;

    // log_p = 0;
    // log[log_p++] = 'o';
    // log[log_p++] = (char)(*(tx->encode_p) + 48);

    // log[log_p++] = input[0];
    // log[log_p++] = input[1];

    cache = &(all_data[cache_data_p]);
    
    char value[2];
    char *flag = "id";
    find_data(value, flag, input, length, 2, &(tx->operation));

    int id = get_id(value, 2);
    // int l = 0;
    // l = build_operation_distribution(input, length, tx, id);

    // return l;

    int l = 0;
    switch(id){
        case 4:
            l = build_withdraw_operation(input, length, tx);
            break;
        case 18:
            l = build_proposal_operation(input, length, tx);
            break;
        case 26:
            l = build_withdraw2_operation(input, length, tx);
            break;
        case 28:
            l = build_transfer2_operation(input, length, tx);
            break;
        case 32:
            l = build_order_create3_operation(input, length, tx);
            break;
        case 33:
            l = build_order_cancel2_operation(input, length, tx);
            break;
        case 36:
            l = build_pledge_operation(input, length, tx);
            break;
        case 37:
            l = build_redeem_operation(input, length, tx);
            break;
        // case 43:
        //     l = build_torrent_payment_operation(nput, length, tx);
        //     break;
        case 47:
            l = build_torrent_payment_refund_operation(input, length, tx);
            break;    
    }

    

    // // os_memcpy(&(tx->encode[0]), &(log[0]), log_p);

    return l;
}

