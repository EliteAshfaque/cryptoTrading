import 'package:get/get.dart';

import 'WalletToBlockChainTransferController.dart';

class WalletToBlockChainTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletToBlockChainTransferController());
  }

}