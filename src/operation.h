#include "uint256.h"
#include "os.h"
#include "cx.h"
#include "ux.h"
#include "transaction_builder.h"

// typedef enum operation_type {
//     transfer_operation,
//     order_create_operation,
//     order_cancel_operation,
//     deposit_operation,
//     withdraw_operation,
//     create_asset_operation,
//     create_market_operation,
//     witness_create_operation,
//     witness_update_operation,
//     deal_operation,
//     order_cancel_settlement_operation,
//     witness_minning_rewards_operation,
//     pledge_asset_operation,
//     redeem_asset_operation,
//     redeem_asset_settlement_operation,
//     set_balance_operation,
//     vote_operation,
//     execute_operation,
//     proposal_operation,
//     withdraw_settlement_operation,
//     super_deposit_operation,
//     order_freeze_btt_fee_settlement_operation,
//     account_create_operation,
//     account_update_operation,
//     account_reset_claim,
//     btc_withdraw_operation,
//     withdraw2_operation,
//     order_create2_operation,
//     transfer2_operation,
//     deposit2_operation,
//     vote2_operation,
//     withdraw_settlement2_operation,
//     order_create3_operation,
//     order_cancel2_operation,
//     delayed_operation,
//     create_pledge_contract_operation,
//     pledge_operation,
//     redeem_operation,
//     redeem_settlement_operation,
//     request_remove_node_operation,
//     request_add_node_operation,
//     torrent_create_operation,
//     torrent_update_operation,
//     torrent_payment_operation,
//     torrent_payment_selttement_operation,
//     torrent_receipt_operation,
//     settlement_operation,
//     torrent_payment_refund_operation,
//     torrent_payment_increase_operation
// } operation_type;

// extern struct operation_data;

typedef struct _cache_holder{
    volatile char *flag;
    volatile int *value_length;
    volatile char *cache;
    volatile int *cache_length;
    volatile int *data_p;
    operation_data *operation;
    char *input;
    volatile int length;
    volatile int *encode_p;
    volatile char *encode;
} cache_holder;

int build_operation(char *input, int length, transaction *tx);

void build_withdraw_operation_data(cache_holder ch, bool *go_next_p);

void build_withdraw2_operation_data(cache_holder ch, bool *go_next_p);

void build_transfer2_operation_data(cache_holder ch, bool *go_next_p);

void build_order_create3_operation_data(cache_holder ch, bool *go_next_p);

void build_order_cancel2_operation_data(cache_holder ch, bool *go_next_p);

void build_pledge_operation_data(cache_holder ch, bool *go_next_p);

void build_redeem_operation_data(cache_holder ch, bool *go_next_p);

void build_torrent_payment_refund_operation_data(cache_holder ch, bool *go_next_p);

void build_proposal_operation_data(cache_holder ch, bool *go_next_p);

