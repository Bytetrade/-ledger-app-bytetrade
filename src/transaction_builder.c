#include "context.h" 

static char *flag;
static char *cache;
static char *encode;
int encode_p;

// static char log[100];
// static short log_p;

uint256_t chain_id;
uint32_t timestamp;
uint32_t expiration;

int find_tx_data(char *value, char *flag, char *input, int length, short key_length, bool write_cache){

    int value_length = 0;
    int i = 0;
    int info_start = 0;
    int info_delimiter = 0;

    // log[log_p++] = 'f';

    while(i < length){

        if(input[i] == '#'){
            info_delimiter = i;
            // log[log_p++] = '#';
            // log[log_p++] = (char)(i + 48);
        }

        if(input[i] == '*'){

            // log[log_p++] = '*';
            // log[log_p++] = (char)(i + 48);

            // for(int k = 0; k < 9; k++){
            //     if(input[info_start + k] == flag[k]){
            //         log[log_p++] = 'y';
            //     } else {
            //         log[log_p++] = 'n';
            //     }
            // }
            

            if(strncmp(&(input[info_start]), flag, key_length) == 0){

                // log[log_p++] = 'c';

                value_length = i - info_delimiter - 1;

                if(write_cache){
                    os_memcpy(value, &(input[info_delimiter + 1]), value_length);
                } else {
                    value[0] = (((info_delimiter + 1) >> 8) & 0xFF);
                    value[1] = (info_delimiter + 1) & 0xFF;
                }

                return value_length;
            }
            info_start = i + 1;
        }

        i++;
    }

    return value_length;
}

void encode_chain_id(transaction *tx){

    // log[log_p++] = '1';
    clear256(&chain_id);

    // log[log_p++] = '2';
    UPPER(LOWER(chain_id)) = 0;
    LOWER(LOWER(chain_id)) = 1;

    // log[log_p++] = '3';
    tx->chain_id = &chain_id;

    // log[log_p++] = '4';
    // if(tostring256(tx->chain_id, 16, &(cache[0]), 32)){
    //     log[log_p++] = '6';
    // } else {
    //     log[log_p++] = '7';
    // }
    get_uint_256_bytes(tx->chain_id, &(cache[0]));

    // log[log_p++] = '5';
    os_memcpy(&(tx->encode[encode_p]), &(cache[0]), 32);
    encode_p += 32; 
}

void encode_timestamp(char *input, int length, transaction *tx){
    flag = "timestamp";
    int value_length = find_tx_data(cache, flag, input, length, 9, true);

    // log[log_p++] = 't';

    timestamp = 0;
    for(int i = 0; i < value_length; i++){
        timestamp = (timestamp * 10);
        timestamp += (cache[i] - 48);

        // log[log_p++] = cache[i];
    }
    
    tx->timestamp = &timestamp;

    encode_p += uint32_to_bytes(*(tx->timestamp), &(tx->encode[encode_p]));
}


void encode_expiration(char *input, int length, transaction *tx){
    flag = "expiration";
    int value_length = find_tx_data(cache, flag, input, length, 10, true);

    if(value_length == 0){
        tx->encode[encode_p++] = 0;
    } else {
        tx->encode[encode_p++] = 1;

        // log[log_p++] = 'e';

        expiration = 0;
        for(int i = 0; i < value_length; i++){
            expiration = (expiration * 10);
            expiration += (cache[i] - 48);

            // log[log_p++] = cache[i];
        }
        
        tx->expiration = &expiration;

        encode_p += uint32_to_bytes(*(tx->expiration), &(tx->encode[encode_p]));
    }

}

void encode_operation(char *input, int length, transaction *tx){

    flag = "operation";
    int value_length = find_tx_data(cache, flag, input, length, 9, false);

    tx->encode[encode_p++] = 1;
    
    short start = (cache[0] << 8) + cache[1];

    // tx->encode[encode_p++] = (value_length + 48);
    // tx->encode[encode_p++] = (start + 48);

    encode_p = build_operation(&(input[start]), value_length, tx);
}

void encode_validate_type(char *input, int length, transaction *tx){
    flag = "validate_type";
    int value_length = find_tx_data(cache, flag, input, length, 13, true);
    if(value_length > 0){
        tx->encode[encode_p++] = (cache[0] - 48);
    }
}

void encode_dapp(char *input, int length, transaction *tx){
    flag = "dapp";
    int value_length = find_tx_data(cache, flag, input, length, 4, true);
    if(value_length > 0){
        tx->encode[encode_p++] = 1;
        tx->encode[encode_p++] = value_length;
        os_memcpy(&(tx->encode[encode_p]), cache, value_length);
        encode_p += value_length;
    } else {
        tx->encode[encode_p++] = 0;
    }
}

void encode_proposal_transaction_id(char *input, int length, transaction *tx){
    flag = "proposal_transaction_id";
    int value_length = find_tx_data(cache, flag, input, length, 23, true);
    if(value_length > 0){
        tx->encode[encode_p++] = 1;
        tx->encode[encode_p++] = value_length;
        os_memcpy(&(tx->encode[encode_p]), cache, value_length);
        encode_p += value_length;
    } else {
        tx->encode[encode_p++] = 0;
    }
}


void encode_hex(transaction *tx){

    if(encode_p > 128 + 32){
        os_memcpy(tx->encode_hex, tx->encode + 32, 128);
    } else {
        os_memcpy(tx->encode_hex, tx->encode + 32, encode_p - 32);
    }
}

void build_transaction(char *input, int length, transaction *tx){

    // log_p = 0;
    

    cache = &(all_data[cache_data_p]);
    encode = &(all_data[message_data_p]);
    
    encode_p = 0;
    tx->encode = encode;
    tx->encode_p = &encode_p;

    encode_chain_id(tx); 
    
    encode_timestamp(input, length, tx); 

    encode_expiration(input, length, tx);

    encode_operation(input, length, tx);
    
    encode_validate_type(input, length, tx);

    encode_dapp(input, length, tx);

    encode_proposal_transaction_id(input, length, tx);

    // encode_hex(tx);

    // tx->encode_hex[encode_p + 1] = '\0';


    // os_memcpy(tx->encode_hex, &log, log_p);
    // tx->encode_hex[log_p] = '\0';
};
