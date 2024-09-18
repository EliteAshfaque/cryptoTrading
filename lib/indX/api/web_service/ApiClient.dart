

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../common/ConstantString.dart';
import '../model/AppSessionBasicRequest.dart';
import '../model/BasicRequest.dart';
import '../model/BasicResponse.dart';
import '../model/activateUser/ActivateUserResponse.dart';
import '../model/activateUser/TopupDataByUserIdResponse.dart';
import '../model/balance/BalanceResponse.dart';
import '../model/bank/BankResponse.dart';
import '../model/currencyList/GetCurrencyBalanceResponse.dart';
import '../model/currencyList/GetCurrencyListResponse.dart';
import '../model/currencyList/LiveRateResponse.dart';
import '../model/dashboardData/DashboardDataResponse.dart';
import '../model/dashboardData/StakeBalanceResponse.dart';
import '../model/depositQr/AutoDepositHistoryResponse.dart';
import '../model/depositQr/GetTechnologyQrResponse.dart';
import '../model/fundRequest/BankPaymentModeRequest.dart';
import '../model/fundRequest/BankPaymentModeResponse.dart';
import '../model/fundRequest/FundRequestReportResponse.dart';
import '../model/fundRequest/FundRequestRequest.dart';
import '../model/login/LoginRequest.dart';
import '../model/login/LoginResponse.dart';
import '../model/login/LoginWithOTPRequest.dart';
import '../model/login/OTPRequest.dart';
import '../model/login/OTPResendRequest.dart';
import '../model/myStake/WithdrawlMintResponse.dart';
import '../model/recentPinActivity/RecentPinActivityResponse.dart';
import '../model/report/IncomeWiseReportRequest.dart';
import '../model/report/ReportRequest.dart';
import '../model/report/ReportResponse.dart';
import '../model/signup/RoleRequest.dart';
import '../model/signup/RoleResponse.dart';
import '../model/signup/SignupRequest.dart';
import '../model/stakeNow/StakeHistoryResponse.dart';
import '../model/support/CallMeRqstRequest.dart';
import '../model/support/Change2FARequest.dart';
import '../model/support/CompanyProfileResponse.dart';
import '../model/support/Google2FAResponse.dart';
import '../model/support/ReferralContentResponse.dart';
import '../model/swap/SwapReportResponse.dart';
import '../model/swap/SwappingCurrencyListResponse.dart';
import '../model/swap/SwappingRateResponse.dart';
import '../model/transfer/AddUpdateBankRequest.dart';
import '../model/transfer/DetailsByUserIdResponse.dart';
import '../model/transfer/DisputeRequest.dart';
import '../model/transfer/GetBankAccountsResponse.dart';
import '../model/transfer/SendMoneyBankReportRequest.dart';
import '../model/transfer/UpdateBankRequest.dart';
import '../model/transfer/TransferReportResponse.dart';
import '../model/userDetails/ChangePinPassRequest.dart';
import '../model/userDetails/LogoutRequest.dart';
import '../model/userDetails/UpdateUserRequest.dart';
import '../model/userDetails/UserDetailResponse.dart';
import '../model/userDetails/ValidatePinRequest.dart';


part 'ApiClient.g.dart';

@RestApi(baseUrl: API_URL)
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @POST("/App/Login")
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST("/App/LoginWithOTP")
  Future<LoginResponse> loginWithOTP(@Body() LoginWithOTPRequest request);

  @POST("/App/ValidateLoginOTP")
  Future<LoginResponse> validateLoginWithOTP(@Body() LoginWithOTPRequest request);

  @POST("/App/ValidateOTP")
  Future<LoginResponse> validateOTP(@Body() OTPRequest request);

  @POST("/App/ValidateGAuthPIN")
  Future<LoginResponse> validateGAuthPin(@Body() OTPRequest request);

  @POST("/App/ResendOTP")
  Future<BasicResponse> resendOTP(@Body() OTPResendRequest request);

  @POST("/App/ForgetPassword")
  Future<LoginResponse> forgetPassword(@Body() LoginRequest request);

  @POST("/App/Logout")
  Future<BasicResponse> logout(@Body() LogoutRequest request);

  @POST("/App/GetRoleForReferral")
  Future<RoleResponse> getRole(@Body() RoleRequest request);

  @POST("/App/AppUserSignup")
  Future<BasicResponse> signup(@Body() SignupRequest request);

  @POST("/App/v2/GetBalance")
  Future<BalanceResponse> balance(@Body() BasicRequest request);

  @POST("/Dashboard/BindNetworkDashboard")
  Future<DashboardDataResponse> dashboardData(@Body() AppSessionBasicRequest request);

  @POST("/App/GetStakeBalance")
  Future<StakeBalanceResponse> getStakeBalance(@Body() BasicRequest request);

  @POST("/App/GetProfile")
  Future<UserDetailResponse> getProfile(@Body() BasicRequest request);

  @POST("/App/SendEmailVerification")
  Future<BasicResponse> emailVerify(@Body() BasicRequest request);

  @POST("/App/GetBankList")
  Future<BankResponse> bankList(@Body() BasicRequest request);

  @POST("/App/UpdateProfile")
  Future<BasicResponse> updateProfile(@Body() UpdateUserRequest request);

  @POST("/App/ChangePinOrPassword")
  Future<BasicResponse> changePinPass(@Body() ChangePinPassRequest request);

  @POST("/App/ValidatePIN")
  Future<BasicResponse> validatePin(@Body() ValidatePinRequest request);

  @POST("/GetTopupDetailsByUserID")
  Future<TopupDataByUserIdResponse> topupDataByUserid(@Body() AppSessionBasicRequest request);

  @POST("/FindUserDetailsById")
  Future<DetailsByUserIdResponse> dataByUserid(@Body() AppSessionBasicRequest request);

  @POST("/GetBusinessCurrencyInUse")
  Future<GetCurrencyListResponse> getBusinessCurrencyUse(@Body() AppSessionBasicRequest request);

  @POST("/GetLiveRate")
  Future<LiveRateResponse> getLiveRate(@Body() AppSessionBasicRequest request);

  @POST("/ActivateUserByApp")
  Future<ActivateUserResponse> activateUserByApp(@Body() AppSessionBasicRequest request);

  @POST("/GetCurrencyList")
  Future<GetCurrencyListResponse> currencyList(@Body() AppSessionBasicRequest request);

  @POST("/GetMasterMoneyBalanceURL")
  Future<GetCurrencyBalanceResponse> getCryptoBalance(@Body() AppSessionBasicRequest request);

  @POST("/GenerateTechnologyQR")
  Future<GetTechnologyQrResponse> generateTechnologyQr(@Body() AppSessionBasicRequest request);

  @POST("/CheckBalanceForAutoDeposit")
  Future<BasicResponse> checkBalanceAutoDeposit(@Body() AppSessionBasicRequest request);

  @POST("/GetWalletDepositCurrencyMapping")
  Future<GetCurrencyListResponse> getWalletDepositCurrencyMapping(@Body() AppSessionBasicRequest request);

  @POST("/App/RecentPinActivity")
  Future<RecentPinActivityResponse> getRecentPinActivity(@Body() BasicRequest request);

  @POST("/App/GetCompanyProfile")
  Future<CompanyProfileResponse> getCompanyProfile(@Body() BasicRequest request);

  @POST("/App/LedgerReport")
  Future<ReportResponse> getLedgerReport(@Body() ReportRequest request);

  @POST("/Dashboard/TotalTeam")
  Future<ReportResponse> getTotalTeam(@Body() AppSessionBasicRequest request);

  @POST("/Dashboard/DirectMemberList")
  Future<ReportResponse> getDirectTeam(@Body() AppSessionBasicRequest request);

  @POST("/Dashboard/BindLevel")
  Future<ReportResponse> getBindLevel(@Body() AppSessionBasicRequest request);

  @POST("/Dashboard/SponserList")
  Future<ReportResponse> getSponsorList(@Body() AppSessionBasicRequest request);

  @POST("/App/GetIncomeWiseReport")
  Future<ReportResponse> getIncomeReport(@Body() IncomeWiseReportRequest request);

  @POST("/GetOPIDListByUserId")
  Future<ReportResponse> getOpIdByUserID(@Body() AppSessionBasicRequest request);

  @POST("/Dashboard/DirectBusiness")
  Future<ReportResponse> getDirectBusiness(@Body() AppSessionBasicRequest request);

  @POST("/Dashboard/SponserBusiness")
  Future<ReportResponse> getSponsorBusiness(@Body() AppSessionBasicRequest request);

  @POST("/Dashboard/SelfBusiness")
  Future<ReportResponse> getSelfBusiness(@Body() AppSessionBasicRequest request);

  @POST("/Dashboard/BinaryBusiness")
  Future<ReportResponse> getBinaryBusiness(@Body() AppSessionBasicRequest request);

  @POST("/App/GetAppRefferalContent")
  Future<ReferralContentResponse> getReferralContent(@Body() BasicRequest request);

  @POST("/App/GetwithdrawlabelMint")
  Future<WithdrawlMintResponse> getWithdrawalMint(@Body() BasicRequest request);

  @POST("/App/GetStackingDetailDB")
  Future<WithdrawlMintResponse> getStakingDetailDb(@Body() BasicRequest request);

  @POST("/App/GetwithdrawlabelMintOLD")
  Future<WithdrawlMintResponse> getWithdrawalMintOld(@Body() BasicRequest request);

  @POST("/App/GetStackingDetailDBOLD")
  Future<WithdrawlMintResponse> getStakingDetailDbOld(@Body() BasicRequest request);

  @POST("/App/GetwithdrawalMint")
  Future<ActivateUserResponse> withdrawalMint(@Body() AppSessionBasicRequest request);

  @POST("/App/GetwithdrawalMintOLD")
  Future<ActivateUserResponse> withdrawalMintOld(@Body() AppSessionBasicRequest request);

  @POST("/CryptoWithDrawal")
  Future<ActivateUserResponse> cryptoWithdrawal(@Body() AppSessionBasicRequest request);

  @POST("/App/WithdrawalWalletReport")
  Future<TransferReportResponse> withdrawalWalletReport(@Body() AppSessionBasicRequest request);

  @POST("/App/WithdrawalCryptoReport")
  Future<TransferReportResponse> withdrawalCryptoReport(@Body() AppSessionBasicRequest request);

  @POST("/InitiateVirtualCryptoTransfer")
  Future<ActivateUserResponse> withdrawalCryptoDb(@Body() AppSessionBasicRequest request);

  @POST("/InitiateCryptoTransfer")
  Future<ActivateUserResponse> withdrawalCrypto(@Body() AppSessionBasicRequest request);

  @POST("/App/ChangeDFStatus")
  Future<BasicResponse> change2FA(@Body() Change2FARequest request);

  @POST("/OTPSend")
  Future<Google2FAResponse> sendOTP(@Body() AppSessionBasicRequest request);

  @POST("/SetupGoogleAuth")
  Future<Google2FAResponse> getGAuthData(@Body() AppSessionBasicRequest request);

  @POST("/GoogleAuthSetupComplete")
  Future<Google2FAResponse> verifyGAuthSetup(@Body() AppSessionBasicRequest request);

  @POST("/ResetSetupGoogleAuth")
  Future<Google2FAResponse> resetGoogleAuth(@Body() AppSessionBasicRequest request);

  @POST("/EnableDisableGoogle2FA")
  Future<Google2FAResponse> enableDisableGoogleAuth(@Body() AppSessionBasicRequest request);

  @POST("/App/UpdateStake")
  Future<BasicResponse> stakeNow(@Body() AppSessionBasicRequest request);

  @POST("/App/StakingHistory")
  Future<StakeHistoryResponse> getStakingHistory(@Body() BasicRequest request);

  @POST("/App/GetCallMeUserReq")
  Future<BasicResponse> callMeRequest(@Body() CallMeRqstRequest request);

  @POST("/Dashboard/SwappingCurrencyList")
  Future<SwappingCurrencyListResponse> getSwappingCurrencyList(@Body() AppSessionBasicRequest request);

  @POST("/GetSwappingCurrencyConversion")
  Future<SwappingRateResponse> getSwappingCurrencyConversion(@Body() AppSessionBasicRequest request);

  @POST("/InitiateCryptoBuySale")
  Future<BasicResponse> submitBuySell(@Body() AppSessionBasicRequest request);

  @POST("/App/SwapReportApp")
  Future<SwapReportResponse> getSwapReport(@Body() BasicRequest request);

  @POST("/App/GetBankAndPaymentMode")
  Future<BankPaymentModeResponse> getBankAndPaymentMode(@Body() BankPaymentModeRequest request);

  @MultiPart()
  @POST("/App/AppFundOrder")
  Future<BasicResponse> submitFundRequest(@Part(name: "UserFundRequest") FundRequestRequest userRequest,{@Part(name: "file") File? file});

  @POST("/App/FundRequestReport")
  Future<FundRequestReportResponse> getFundRequestReport(@Body() AppSessionBasicRequest request);

  @POST("/App/GetSettlementAccount")
  Future<GetBankAccountsResponse> getBankAccounts(@Body() BasicRequest request);

  @POST("/App/UpdateSettlementAccount")
  Future<BasicResponse> addUpdateBankAccount(@Body() AddUpdateBankRequest request);

  @POST("/App/BankTranferServiceMLM")
  Future<BasicResponse> sendMoney(@Body() AppSessionBasicRequest request);

  @POST("/App/DeleteSettlementAcount")
  Future<BasicResponse> deleteBankAccount(@Body() UpdateBankRequest request);

  @POST("/App/DMTReport")
  Future<TransferReportResponse> getDMTReport(@Body() SendMoneyBankReportRequest request);

  @POST("/App/RefundRequest")
  Future<BasicResponse> submitDispute(@Body() DisputeRequest request);

  @POST("/App/AutoDepositHistory")
  Future<AutoDepositHistoryResponse> getAutoDepositHistory(@Body() AppSessionBasicRequest request);
}
