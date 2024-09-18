enum MasterAuthType {
  email,
  sms,
  none,
  google_auth
}

enum LoginStatus {
  In_Progress,
  Success,
  Failed
}

enum OrderTypes {
  BUY,
  SELL
}

enum LedgerStatus {
  PENDING,
  COMPLETED,
  FAILED,
  ALL
}

enum TransactionType {
  WithDrawal,
  Deposit,
  ALL
}

enum TransactionTypeLedger {
  CREDITED,
  DEBITED
}

enum TransactionLogStatus {
  SUCCESS,
  PENDING,
  FAILED,
  ALL
}

enum Filters {
  Email,
  Name,
  None
}

enum OrderStatus {
  Partially_Processed,
  Placed,
  Partially_Cancelled,
  Completed,
  Canceled
}

enum LedgerTransactionType {
  CREDITED,
  DEBITED
}

enum DocumentsType {
  transferProof,
  pan,
  aadhaarFront,
  aadhaarBack,
  userImage
}

enum KycStatus {
  PENDING,
  VERIFIED,
  REJECTED,
  NOT_INITIATED
}

enum UserBankStatus {
  PENDING,
  VERIFIED
}


enum WithdrawalStatus {
  IN_PROGRESS,
  SUCCESS
}

enum FiatType {
  INR,
  USDT,
  ETH,
  BTC,
  BNB,
  ONEFX
}
enum CoinStatus {
  ACTIVE,
  INACTIVE
}

enum GainerLoserPopular {
  GAINER,
  LOSER,
  POPULAR
}

enum WithdrawalType {
  COIN,
  INR
}

enum NetworkTypes {
  BEP20,
  TRC20,
  ERC20
}