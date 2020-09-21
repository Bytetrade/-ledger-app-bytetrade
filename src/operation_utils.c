#include "context.h"

int uint32_to_bytes(uint32_t val, char *out) {

    out[0] = ((val >> 24) & 0xFF);
    out[1] = ((val >> 16) & 0xFF);
    out[2] = ((val >> 8) & 0xFF);
    out[3] = ((val) & 0xFF);

    return 4;
}

int uint32_to_bytes_net(uint32_t val, char *out) {

    out[3] = ((val >> 24) & 0xFF);
    out[2] = ((val >> 16) & 0xFF);
    out[1] = ((val >> 8) & 0xFF);
    out[0] = ((val) & 0xFF);

    return 4;
}

int get_uint_128_bytes(uint128_t *value, char *out){
    
    int p = 0;
    out[p++] = ((value->elements[0]) & 0xFF);
    out[p++] = ((value->elements[0] >> 8) & 0xFF);
    out[p++] = ((value->elements[0] >> 16) & 0xFF);
    out[p++] = ((value->elements[0] >> 24) & 0xFF);
    out[p++] = ((value->elements[0] >> 32) & 0xFF);
    out[p++] = ((value->elements[0] >> 40) & 0xFF);
    out[p++] = ((value->elements[0] >> 48) & 0xFF);
    out[p++] = ((value->elements[0] >> 56) & 0xFF);
    
    out[p++] = ((value->elements[1]) & 0xFF);
    out[p++] = ((value->elements[1] >> 8) & 0xFF);
    out[p++] = ((value->elements[1] >> 16) & 0xFF);
    out[p++] = ((value->elements[1] >> 24) & 0xFF);
    out[p++] = ((value->elements[1] >> 32) & 0xFF);
    out[p++] = ((value->elements[1] >> 40) & 0xFF);
    out[p++] = ((value->elements[1] >> 48) & 0xFF);
    out[p++] = ((value->elements[1] >> 56) & 0xFF);
    
    return p;
}

int get_uint_128_bytes_c(uint128_t *value, char *out){
    
    int p = 0;
    out[p++] = ((value->elements[0] >> 56) & 0xFF);
    out[p++] = ((value->elements[0] >> 48) & 0xFF);
    out[p++] = ((value->elements[0] >> 40) & 0xFF);
    out[p++] = ((value->elements[0] >> 32) & 0xFF);
    out[p++] = ((value->elements[0] >> 24) & 0xFF);
    out[p++] = ((value->elements[0] >> 16) & 0xFF);
    out[p++] = ((value->elements[0] >> 8) & 0xFF);
    out[p++] = ((value->elements[0]) & 0xFF);
    
    out[p++] = ((value->elements[1] >> 56) & 0xFF);
    out[p++] = ((value->elements[1] >> 48) & 0xFF);
    out[p++] = ((value->elements[1] >> 40) & 0xFF);
    out[p++] = ((value->elements[1] >> 32) & 0xFF);
    out[p++] = ((value->elements[1] >> 24) & 0xFF);
    out[p++] = ((value->elements[1] >> 16) & 0xFF);
    out[p++] = ((value->elements[1] >> 8) & 0xFF);
    out[p++] = ((value->elements[1]) & 0xFF);
    
    return p;
}

int get_uint_256_bytes(uint256_t *value, char *out){
    
    int p = 0;
    p = get_uint_128_bytes_c(&(value->elements[0]), out);
    p = get_uint_128_bytes_c(&(value->elements[1]), out + p);
    
    return p;
}
