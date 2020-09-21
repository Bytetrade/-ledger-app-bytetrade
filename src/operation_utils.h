#include "uint256.h"

int uint32_to_bytes(uint32_t val, char *out);

int uint32_to_bytes_net(uint32_t val, char *out);

int get_uint_128_bytes(uint128_t *value, char *out);

int get_uint_128_bytes_c(uint128_t *value, char *out);

int get_uint_256_bytes(uint256_t *value, char *out);
