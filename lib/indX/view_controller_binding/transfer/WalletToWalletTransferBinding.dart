import 'package:get/get.dart';

import 'WalletToWalletTransferController.dart';

class WalletToWalletTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletToWalletTransferController());
  }

}