import 'package:get/get.dart';

import 'WalletOrCryptoWithdrawalReportController.dart';



class WalletOrCryptoWithdrawalReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletOrCryptoWithdrawalReportController());
  }

}