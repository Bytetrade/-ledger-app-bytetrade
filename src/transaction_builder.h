#ifndef _TRANSACTION_S_
#define _TRANSACTION_S_

typedef struct _operation_data{
    char *data;
    char *hash; 
} operation_data;

typedef struct transaction_s{
    uint256_t *chain_id;
    uint32_t *timestamp;
    uint32_t *expiration;
    operation_data operation;
    uint8_t *validate_type;
    char *dapp;
    char *proposal_transaction_id;
    char *encode;
    char *encode_hex;
    volatile int *encode_p;
} transaction;

void build_transaction(char *input, int length, transaction *tx);

#endif