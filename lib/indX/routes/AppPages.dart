import 'package:get/get.dart';


import '../view_controller_binding/activateUser/ActivateUserByStakingBinding.dart';
import '../view_controller_binding/activateUser/ActivateUserByStakingPage.dart';
import '../view_controller_binding/addUser/AddUserBinding.dart';
import '../view_controller_binding/addUser/AddUserPage.dart';
import '../view_controller_binding/bank/BankBinding.dart';
import '../view_controller_binding/bank/BankPage.dart';
import '../view_controller_binding/dashboard/DashboardBinding.dart';
import '../view_controller_binding/dashboard/DashboardPage.dart';
import '../view_controller_binding/depositQR/DepositQrBinding.dart';
import '../view_controller_binding/depositQR/DepositQrPage.dart';
import '../view_controller_binding/depositQR/report/DepositQrReportBinding.dart';
import '../view_controller_binding/depositQR/report/DepositQrReportPage.dart';
import '../view_controller_binding/fundRequest/FundRequestBinding.dart';
import '../view_controller_binding/fundRequest/FundRequestPage.dart';
import '../view_controller_binding/fundRequest/report/FundRequestReportBinding.dart';
import '../view_controller_binding/fundRequest/report/FundRequestReportPage.dart';
import '../view_controller_binding/gAuthSetup/GAuthSetupBinding.dart';
import '../view_controller_binding/gAuthSetup/GAuthSetupPage.dart';
import '../view_controller_binding/inviteReferral/InviteReferralBinding.dart';
import '../view_controller_binding/inviteReferral/InviteReferralPage.dart';
import '../view_controller_binding/login/LoginBinding.dart';
import '../view_controller_binding/login/LoginPage.dart';
import '../view_controller_binding/myStake/MyStakeReportBinding.dart';
import '../view_controller_binding/myStake/MyStakeReportPage.dart';
import '../view_controller_binding/profile/ProfileBinding.dart';
import '../view_controller_binding/profile/ProfilePage.dart';
import '../view_controller_binding/profile/UpdateProfileBinding.dart';
import '../view_controller_binding/profile/UpdateProfilePage.dart';
import '../view_controller_binding/recentPinActivity/RecentPinActivityBinding.dart';
import '../view_controller_binding/recentPinActivity/RecentPinActivityPage.dart';
import '../view_controller_binding/report/businessReport/BinaryBusinessReportBinding.dart';
import '../view_controller_binding/report/businessReport/BinaryBusinessReportPage.dart';
import '../view_controller_binding/report/businessReport/DirectBusinessReportBinding.dart';
import '../view_controller_binding/report/businessReport/DirectBusinessReportPage.dart';
import '../view_controller_binding/report/businessReport/SelfBusinessReportBinding.dart';
import '../view_controller_binding/report/businessReport/SelfBusinessReportPage.dart';
import '../view_controller_binding/report/businessReport/SponserBusinessReportPage.dart';
import '../view_controller_binding/report/teamReport/DirectTeamReportBinding.dart';
import '../view_controller_binding/report/incomeReport/IncomeReportBinding.dart';
import '../view_controller_binding/report/incomeReport/IncomeReportPage.dart';
import '../view_controller_binding/report/teamReport/DirectTeamReportPage.dart';
import '../view_controller_binding/report/teamReport/SponserTeamReportPage.dart';
import '../view_controller_binding/report/walletReport/LedgerReportBinding.dart';
import '../view_controller_binding/report/businessReport/SponserBusinessReportBinding.dart';
import '../view_controller_binding/report/teamReport/SponserTeamReportBinding.dart';
import '../view_controller_binding/report/teamReport/TeamReportBinding.dart';
import '../view_controller_binding/report/teamReport/TeamReportPage.dart';
import '../view_controller_binding/report/walletReport/LedgerReportPage.dart';
import '../view_controller_binding/signup/SignupBinding.dart';
import '../view_controller_binding/signup/SignupPage.dart';
import '../view_controller_binding/splash/SplashBinding.dart';
import '../view_controller_binding/splash/SplashPage.dart';
import '../view_controller_binding/stakeNow/StakeNowByPackageBinding.dart';
import '../view_controller_binding/stakeNow/StakeNowByPackagePage.dart';
import '../view_controller_binding/stakeNow/report/StakeReportBinding.dart';
import '../view_controller_binding/stakeNow/report/StakeReportPage.dart';
import '../view_controller_binding/support_settings/SupportSettingBinding.dart';
import '../view_controller_binding/support_settings/SupportSettingPage.dart';
import '../view_controller_binding/swap/SwapBinding.dart';
import '../view_controller_binding/swap/SwapPage.dart';
import '../view_controller_binding/swap/report/SwapReportBinding.dart';
import '../view_controller_binding/swap/report/SwapReportPage.dart';
import '../view_controller_binding/tcPPPage/TCPPBinding.dart';
import '../view_controller_binding/tcPPPage/TCPPPage.dart';
import '../view_controller_binding/transfer/BankAccountsBinding.dart';
import '../view_controller_binding/transfer/BankAccountsPage.dart';
import '../view_controller_binding/transfer/CryptoTransferBinding.dart';
import '../view_controller_binding/transfer/CryptoTransferPage.dart';
import '../view_controller_binding/transfer/WalletToBlockChainTransferBinding.dart';
import '../view_controller_binding/transfer/WalletToBlockChainTransferPage.dart';
import '../view_controller_binding/transfer/WalletToWalletTransferBinding.dart';
import '../view_controller_binding/transfer/WalletToWalletTransferPage.dart';
import '../view_controller_binding/transfer/addBank/AddUpdateBankBinding.dart';
import '../view_controller_binding/transfer/addBank/AddUpdateBankPage.dart';
import '../view_controller_binding/transfer/report/SendMoneyBankReportBinding.dart';
import '../view_controller_binding/transfer/report/SendMoneyBankReportPage.dart';
import '../view_controller_binding/transfer/report/WalletOrCryptoWithdrawalReportBinding.dart';
import '../view_controller_binding/transfer/report/WalletOrCryptoWithdrawalReportPage.dart';
import '../view_controller_binding/transfer/sendMoneyBank/SendMoneyBankBinding.dart';
import '../view_controller_binding/transfer/sendMoneyBank/SendMoneyBankPage.dart';
import '../view_controller_binding/welcome/WelcomePage.dart';
import 'AppRoutes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => WelcomePage()
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupPage(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.addUser,
      page: () => AddUserPage(),
      binding: AddUserBinding(),
    ),
    GetPage(
      name: AppRoutes.updateProfile,
      page: () => UpdateProfilePage(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.bank,
      page: () => BankPage(),
      binding: BankBinding(),
    ),
    GetPage(
      name: AppRoutes.supportSettings,
      page: () => SupportSettingPage(),
      binding: SupportSettingBinding(),
    ),
    GetPage(
      name: AppRoutes.activateUserByStaking,
      page: () => ActivateUserByStakingPage(),
      binding: ActivateUserByStakingBinding(),
    ),
    GetPage(
      name: AppRoutes.depositQR,
      page: () => DepositQrPage(),
      binding: DepositQrBinding(),
    ),
    GetPage(
      name: AppRoutes.depositQRReport,
      page: () => DepositQrReportPage(),
      binding: DepositQrReportBinding(),
    ),
    GetPage(
      name: AppRoutes.recentPinActivity,
      page: () => RecentPinActivityPage(),
      binding: RecentPinActivityBinding(),
    ),
    GetPage(
      name: AppRoutes.ledgerReport,
      page: () => LedgerReportPage(),
      binding: LedgerReportBinding(),
    ),
    GetPage(
      name: AppRoutes.teamReport,
      page: () => TeamReportPage(),
      binding: TeamReportBinding(),
    ),
    GetPage(
      name: AppRoutes.directTeamReport,
      page: () => DirectTeamReportPage(),
      binding: DirectTeamReportBinding(),
    ),
    GetPage(
      name: AppRoutes.sponserTeamReport,
      page: () => SponserTeamReportPage(),
      binding: SponserTeamReportBinding(),
    ),
    GetPage(
      name: AppRoutes.incomeReport,
      page: () => IncomeReportPage(),
      binding: IncomeReportBinding(),
    ),
    GetPage(
      name: AppRoutes.directBusinessReport,
      page: () => DirectBusinessReportPage(),
      binding: DirectBusinessReportBinding(),
    ),
    GetPage(
      name: AppRoutes.sponserBusinessReport,
      page: () => SponserBusinessReportPage(),
      binding: SponserBusinessReportBinding(),
    ),
    GetPage(
      name: AppRoutes.selfBusinessReport,
      page: () => SelfBusinessReportPage(),
      binding: SelfBusinessReportBinding(),
    ),
    GetPage(
      name: AppRoutes.binaryBusinessReport,
      page: () => BinaryBusinessReportPage(),
      binding: BinaryBusinessReportBinding(),
    ),
    GetPage(
      name: AppRoutes.inviteReferral,
      page: () => InviteReferralPage(),
      binding: InviteReferralBinding(),
    ),
    GetPage(
      name: AppRoutes.myStakeHistory,
      page: () => MyStakeReportPage(),
      binding: MyStakeReportBinding(),
    ),
    GetPage(
      name: AppRoutes.walletToWalletTransfer,
      page: () => WalletToWalletTransferPage(),
      binding: WalletToWalletTransferBinding(),
    ),
    GetPage(
      name: AppRoutes.walletToBlockChainTransfer,
      page: () => WalletToBlockChainTransferPage(),
      binding: WalletToBlockChainTransferBinding(),
    ),
    GetPage(
      name: AppRoutes.walletCryptoWithdrawalReport,
      page: () => WalletOrCryptoWithdrawalReportPage(),
      binding: WalletOrCryptoWithdrawalReportBinding(),
    ),
    GetPage(
      name: AppRoutes.cryptoTransfer,
      page: () => CryptoTransferPage(),
      binding: CryptoTransferBinding(),
    ),
    GetPage(
      name: AppRoutes.gAuthSetup,
      page: () => GAuthSetupPage(),
      binding: GAuthSetupBinding(),
    ),
    GetPage(
      name: AppRoutes.stakeNowByPackage,
      page: () => StakeNowByPackagePage(),
      binding: StakeNowByPackageBinding(),
    ),
    GetPage(
      name: AppRoutes.stakeHistory,
      page: () => StakeReportPage(),
      binding: StakeReportBinding(),
    ),
    GetPage(
      name: AppRoutes.tCPP,
      page: () => TCPPPage(),
      binding: TCPPBinding(),
    ),
    GetPage(
      name: AppRoutes.swap,
      page: () => SwapPage(),
      binding: SwapBinding(),
    ),
    GetPage(
      name: AppRoutes.swapReport,
      page: () => SwapReportPage(),
      binding: SwapReportBinding(),
    ),
    GetPage(
      name: AppRoutes.fundRequest,
      page: () => FundRequestPage(),
      binding: FundRequestBinding(),
    ),
    GetPage(
      name: AppRoutes.fundRequestReport,
      page: () => FundRequestReportPage(),
      binding: FundRequestReportBinding(),
    ),
    GetPage(
      name: AppRoutes.bankAccounts,
      page: () => BankAccountsPage(),
      binding: BankAccountsBinding(),
    ),
    GetPage(
      name: AppRoutes.addUpdateBank,
      page: () => AddUpdateBankPage(),
      binding: AddUpdateBankBinding(),
    ),
    GetPage(
      name: AppRoutes.sendMoneyBank,
      page: () => SendMoneyBankPage(),
      binding: SendMoneyBankBinding(),
    ),
    GetPage(
      name: AppRoutes.sendMoneyBankReport,
      page: () => SendMoneyBankReportPage(),
      binding: SendMoneyBankReportBinding(),
    ),
  ];
}
