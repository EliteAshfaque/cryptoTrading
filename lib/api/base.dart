import 'dart:io';

import 'package:cryptox/api/Order/cancelOrder/cancelOrder.dart';
import 'package:cryptox/api/Order/placeOrder/placeOrder.dart';
import 'package:cryptox/api/Order/placedOrderEntries/placeOrderEntries.dart';
import 'package:cryptox/api/bank/adminBanks/adminBanks.dart';
import 'package:cryptox/api/bank/bankList/bankList.dart';
import 'package:cryptox/api/bank/createUserBank/createUserBank.dart';
import 'package:cryptox/api/bank/userBank/userBank.dart';
import 'package:cryptox/api/bank/verifyUtr/verifyUtr.dart';
import 'package:cryptox/api/banner/getBanner/getBanner.dart';
import 'package:cryptox/api/coinTransactionLogs/transactionLogHistory.dart';
import 'package:cryptox/api/coins/ledger/ledgerEntries.dart';
import 'package:cryptox/api/coins/masterCoinList/getMasterCoinList.dart';
import 'package:cryptox/api/funds/allCoinsFund/allCoinsFund.dart';
import 'package:cryptox/api/funds/cryptoDeposit/cryptoDeposit.dart';
import 'package:cryptox/api/funds/cryptoWithdrawal/cryptoWithdrawal.dart';
import 'package:cryptox/api/funds/estimateDeduction/estimateDeduction.dart';
import 'package:cryptox/api/funds/generateUserAddress/generateUserAddress.dart';
import 'package:cryptox/api/funds/withdrawalinr/withdrawalInr.dart';
import 'package:cryptox/api/helpDesk/allConversations/allConversations.dart';
import 'package:cryptox/api/helpDesk/allTickets/allTickets.dart';
import 'package:cryptox/api/helpDesk/createTicket/createTicket.dart';
import 'package:cryptox/api/helpDesk/createTicketWithDoc/createTicketWIthDoc.dart';
import 'package:cryptox/api/helpDesk/replyTicket/replyTicket.dart';
import 'package:cryptox/api/helpDesk/replyTicketWithDoc/replyTicketWithDoc.dart';
import 'package:cryptox/api/kyc/kycId/kycId.dart';
import 'package:cryptox/api/kyc/submitKyc/submitKyc.dart';
import 'package:cryptox/api/login/login.dart';
import 'package:cryptox/api/masterAuth/allMasterAuth/allMasterAuth.dart';
import 'package:cryptox/api/notification/getAllUserNotifications/getAllNotifications.dart';
import 'package:cryptox/api/notification/updateNotification/updateNotification.dart';
import 'package:cryptox/api/orderFills/24HourVolume/24HourVolume.dart';
import 'package:cryptox/api/orderFills/completedOrderEntries/completedOrderEntries.dart';
import 'package:cryptox/api/request/allRequest/allRequests.dart';
import 'package:cryptox/api/request/createRequest/createRequest.dart';
import 'package:cryptox/api/signUp/signUp.dart';
import 'package:cryptox/api/transactions/validateBEP20Address/validateBEP20Address.dart';
import 'package:cryptox/api/tron/validateAddress/validateAddress.dart';
import 'package:cryptox/api/uniqueCode/unique_code.dart';
import 'package:cryptox/api/upload/fileUpload.dart';
import 'package:cryptox/api/user/activityLogs/activityLogs.dart';
import 'package:cryptox/api/user/changePassword/changePassword.dart';
import 'package:cryptox/api/user/deleteAccount/deleteAccount.dart';
import 'package:cryptox/api/user/enableAuth/enableAuth.dart';
import 'package:cryptox/api/user/getUser/getUser.dart';
import 'package:cryptox/api/user/logout/logout.dart';
import 'package:cryptox/api/user/referral/referral.dart';
import 'package:cryptox/api/user/refreshMobileToken/refreshMobileToken.dart';
import 'package:cryptox/api/user/resendVerificationEmail/resendVerificationEmail.dart';
import 'package:cryptox/api/user/resetMobile/resetMobile.dart';
import 'package:cryptox/api/user/resetPass/resetPass.dart';
import 'package:cryptox/api/user/sendActiveOotp/sendActiveOtp.dart';
import 'package:cryptox/api/user/userAdditionalDetails/userAdditionalDetails.dart';
import 'package:cryptox/api/user/verifyActiveOtp/verifyActiveOtp.dart';
import 'package:cryptox/api/user/verifyAuth/verifyAuth.dart';
import 'package:cryptox/api/user/verifyTOtp/verifyTOtp.dart';
import 'package:cryptox/api/wallet/userWallet/userWallets.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../constant/api.dart';
import 'announcement/getAnnouncements/getAnnouncements.dart';
import 'coins/allCoins/allCoins.dart';
import 'coins/orderBook/orderBook.dart';
import 'coins/tradeHistory/tradeHistory.dart';
import 'generare_unique/generate_unique_code_struct.dart';

part 'base.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /* USER */

  @POST("users/login")
  Future<Login> loginUser(@Body() Object obj);

  @POST("users/google_login")
  Future<Login> googleLoginUser(@Body() Object obj);

  @POST("users/google_auth")
  Future<SignUp> googleAuthUser(@Body() Object obj);

  @GET("users/get_user_by_referral?uniqueId={uniqueId}")
  Future<SignUp> getUserByReferral(@Path("uniqueId") String uniqueId);

  @POST("users/update_details")
  Future<SignUp> updateUserDetails(@Body() Object obj);

  @POST("users/send_email_verify_otp")
  Future<SignUp> sendEmailVerifyOtp(@Body() Object obj);

  @GET("users/user_additional_info")
  Future<UserAdditionalDetailsApiStruct> getUserDetails();

  @POST("users/submit_user_Details")
  Future<SignUp> submitUserDetails(@Body() Object obj);

  @POST("users/sign_up")
  Future<SignUp> signUpUser(@Body() Object obj);

  @GET("users/get_details")
  Future<UserDetailsApiStruct> getIUser();

  @POST("users/verify_auth")
  Future<VerifyAuthApiStruct> verifyOtp(@Body() Object obj);

  @GET("users/enable_auth?type={type}")
  Future<EnableAuthApiStruct> enableAuth(@Path("type") String type);

  @POST("users/update_Settings")
  Future<VerifyTOtpApiStruct> updateUserSettings(@Body() Object obj);

  @GET("users/get_logs")
  Future<ActivityLogsApiStruct> getUserLogs();

  @GET("users/reset_email_request?email={email}")
  Future<ResetPassApiStruct> resetUserPass(@Path("email") String email);

  @PATCH("users/update_user_mobile_token")
  Future<RefreshMobilTokenApiStruct> refreshUserMobilToken(@Body() Object obj);

  @POST("users/resend_verification_link")
  Future<ResendVerificationEmailApiStruct> resendVerificationLink(
      @Body() Object obj);

  @POST("users/update_phone")
  Future<ResetMobileApiStruct> updateUserMobile(@Body() Object obj);

  @POST("users/delete_account")
  Future<DeleteAccountApiStruct> deleteAccount(@Body() Object obj);

  @GET("users/referrals")
  Future<ReferralApiStruct> getReferrals();

  @GET("users/logout_all_devices")
  Future<LogOutApiStruct> logOutAllDevices();

  @POST("users/send_email_otp")
  Future<SendActiveOtpApiStruct> sendActiveOtp();

  @PATCH("users/update_user_status")
  Future<VerifyActiveOtpApiStruct> verifyActiveOtp(@Body() Object obj);

  @POST("users/change_password")
  Future<ChangePasswordApiStruct> changePassword(@Body() Object obj);

  /* COIN ENDPOINTS */

  @GET("binance/get_all_coins")
  Future<AllCoins> getAllCoins();

  @GET("order/get_orders?symbol={symbol}&fiat={fiat}")
  Future<OrderBookStruct> getOrderBook(
      @Path("symbol") String symbol, @Path("fiat") String fiat);

  @GET("order_fills/get_trade_history?symbol={symbol}&fiat={fiat}")
  Future<TradeHistoryApiStruct> getTradeHistory(
      @Path("symbol") String symbol, @Path("fiat") String fiat);

  @GET("master_coin/get_all_coins?symbol={symbol}")
  Future<GetMasterCoinListApiStruct> getMasterCoinList(
      {@Path("symbol") String? symbol});

  /* WALLET ENDPOINTS */

  @GET("wallet/get_user_wallets")
  Future<UserWalletStruct> getUserWallet();

  /* ORDER */

  @POST("order/create_order")
  Future<PlaceOrderApiStruct> createOrder(@Body() Object obj);

  @GET(
      "order/get_all_orders?page={page}&searchTerm={searchTerm}&type={type}&status={status}&searchFilter={searchFilter}")
  Future<PlaceOrderEntriesApiStruct> getOrderPlacedCancelledEntries(
      @Path("page") String page,
      @Path("searchTerm") String searchTerm,
      @Path("type") String type,
      @Path("status") String status,
      @Path("searchFilter") String searchFilter);
  @GET(
      "order/get_all_orders?page={page}&searchTerm={searchTerm}&type={type}&status={status}&searchFilter={searchFilter}")
  Future<PlaceOrderEntriesApiStruct> getCancelledEntries(
      @Path("page") String page,
      @Path("searchTerm") String searchTerm,
      @Path("type") String type,
      @Path("status") String status,
      @Path("searchFilter") String searchFilter);

  @POST("order/cancel_order")
  Future<CancelOrderApiStruct> cancelOrder(@Body() Object obj);

  /* ORDER FILLS */

  @GET(
      "order_fills/get_user_order_report?page={page}&searchTerm={searchTerm}&type={type}&symbol={symbol}&searchFilter={searchFilter}")
  Future<CompletedOrderEntriesApiStruct> getCompletedOrderEntries(
      @Path("page") String page,
      @Path("searchTerm") String searchTerm,
      @Path("type") String type,
      @Path("symbol") String symbol,
      @Path("searchFilter") String searchFilter);

  @GET("order_fills/24_hour_volume?symbol={symbol}")
  Future<Last24HourVolumeApiStruct> getLast24HourVolume(
      @Path("symbol") String symbol);

  /* REQUEST */

  @GET("request/get_all_requests?page={page}&status={status}")
  Future<AllRequestApiStruct> getAllDeposits(
      @Path("page") String page, @Path("status") String status);

  @POST("request/create_request")
  Future<CreateRequestApiStruct> createInrRequest(@Body() Object obj);

  /* LOGS */

  @GET(
      "logs/get_history?page={page}&symbol={symbol}&requestType={requestType}&status={status}")
  Future<TransactionLogHistoryApiStruct> getCoinTransactionHistory(
      @Path("page") String page,
      @Path("symbol") String symbol,
      @Path("requestType") String requestType,
      @Path("status") String status);

  /* LEDGER */

  @GET("ledger/get_all_ledger_entries?page={page}&symbol={symbol}")
  Future<LedgerEntriesApiStruct> getLedgerEntries(
      @Path("page") String page, @Path("symbol") String symbol);

  /* UPLOAD */

  @POST("upload/doc")
  @MultiPart()
  Future<FileUploadApiStruct> uploadDoc(
      @Part() File image, @Part() String data, @Part() String type);

  /* KYC */

  @GET("kyc/get_kyc_Id")
  Future<KycIdApiStruct> getKycId();

  @POST("kyc/create_entry")
  Future<SubmitKycApiStruct> createKycEntry(@Body() Object obj);

  /* BANK */

  @GET("users/get_banks")
  Future<UserBankApiStruct> getUserBank();

  @GET("banks_list/get_bank_list")
  Future<BankListApiStruct> getAllBanks();

  @POST("users/create_bank")
  Future<CreateUserBankApiStruct> createUserBank(@Body() Object obj);

  @POST("users/verify_utr")
  Future<VerifyUtrApiStruct> verifyUtr(@Body() Object obj);

  @GET("banks/get_banks")
  Future<AdminBanksApiStruct> getAdminBanks();

  /* MASTER AUTH */

  @GET("master_auth/get_all_auth")
  Future<AllMasterAuthApiStruct> getAllMasterAuth();

  /* FUNDS */

  @POST("funds/withdrawal_Inr")
  Future<WithdrawalInrApiStruct> withdrawalInr(@Body() Object obj);

  @GET("funds/deposit/{network}?symbol={symbol}")
  Future<GenerateUserAddressApiStruct> generateUserAddress(
      @Path("network") String network, @Path("symbol") String symbol);

  @POST("funds/transfer_tokens_new/{network}")
  Future<CryptoDepositApiStruct> depositCrypto(
      @Path("network") String network, @Body() Object obj);

  @POST("funds/withdrawal_tokens/{network}")
  Future<CryptoWithdrawalApiStruct> withdrawalCrypto(
      @Path("network") String network, @Body() Object obj);

  @GET("funds/get_all_coins?page={page}")
  Future<AllCoinsFundApiStruct> allCoinsFunds(@Path("page") String page);

  @GET(
      "funds/get_estimate_deduction?amount={amount}&type={type}&symbol={symbol}&network={netwrok}")
  Future<EstimateDeductionApiStruct> getEstimatedFunds(
      @Path("amount") String amount,
      @Path("type") String type,
      @Path("symbol") String? symbol,
      @Path('network') String network);

  /* HELPDESK */

  @POST("help_desk/create_ticket")
  Future<CreateTicketApiStruct> createTicket(@Body() Object obj);

  @POST("help_desk/create_ticket_with_doc")
  @MultiPart()
  Future<CreateTicketWithDocApiStruct> createTicketWithDoc(
      @Part() List<File> attachments,
      @Part() String phone,
      @Part() String description,
      @Part() String subject,
      @Part() int status,
      @Part() int priority,
      @Part() int source);

  @GET("help_desk/get_all_tickets")
  Future<AllTicketsApiStruct> getAllTickets();

  @GET("help_desk/all_conversations_on_ticket?id={id}")
  Future<AllConversationsApiStruct> getAllConversations(@Path("id") int id);

  @POST("help_desk/reply_ticket")
  Future<ReplyTicketApiStruct> replyTicket(@Body() Object obj);

  @POST("help_desk/reply_ticket_with_doc")
  @MultiPart()
  Future<ReplyTicketWithDocApiStruct> replyTicketWithDoc(
      @Part() List<File> attachments,
      @Part() String reply,
      @Part() int id,
      @Part() int user_id);

  @POST("help_desk/reply_ticket_with_doc")
  @MultiPart()
  Future<ReplyTicketWithDocApiStruct> replyTicketWithDoc1(
      @Part() List<File> attachments, @Part() int id, @Part() int user_id);

  /* NOTIFICATION */

  @GET("notification/get_all_notifications")
  Future<GetAllNotificationsApiStruct> getAllUserNotifications();

  @PATCH("notification/update_notification")
  Future<UpdateNotificationsApiStruct> updateNotification(@Body() Object obj);

  /* BANNER */

  @GET("banner/get_banner?limit={limit}")
  Future<GetBannerApiStruct> getAllBanner(@Path("limit") String limit);

  /* ANNOUNCEMENT */

  @GET("announcements/read_announce_web?limit={limit}")
  Future<GetAnnouncementApiStruct> getAnnouncements(
      [@Path("limit") String limit = "3"]);

  /* TRANSACTION */

  @GET("transaction/validate_BEP20_address?address={address}")
  Future<ValidateBEP20AddressApiStruct> validateBEP20AddressApiStruct(
      @Path("address") String address);

  /* TRON */

  @GET("tron/validate_address?address={address}")
  Future<ValidateAddressApiStruct> validateTronAddress(
      @Path("address") String address);

/*GetUniqueCode*/
  @GET("request/getUniqueCode")
  Future<UniqueCodeStruct> getUniqueCode(
      @Query("paymentMode") String paymentMode);
/*GenerateUniqueCode*/
  @POST("/request/generateCDMUniqueCode")
  Future<GenerateUnique> generateUnique(@Body() Object obj);
}

@JsonSerializable()
class Base {
  @JsonKey(name: "success")
  bool success;

  @JsonKey(name: "result")
  dynamic result;

  Base({required this.success, @required this.result});

  factory Base.fromJson(Map<String, dynamic> json) => _$BaseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "message")
  dynamic message;

  Result({@required this.message});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class ErrorBase {
  @JsonKey(name: "success")
  bool success;

  @JsonKey(name: "result")
  ErrorResult result;

  ErrorBase({required this.success, required this.result});

  factory ErrorBase.fromJson(Map<String, dynamic> json) =>
      _$ErrorBaseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorBaseToJson(this);
}

@JsonSerializable()
class ErrorResult {
  @JsonKey(name: "error")
  String error;

  ErrorResult({required this.error});

  factory ErrorResult.fromJson(Map<String, dynamic> json) =>
      _$ErrorResultFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResultToJson(this);
}
