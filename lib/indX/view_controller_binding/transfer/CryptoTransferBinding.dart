import 'package:get/get.dart';

import 'CryptoTransferController.dart';

class CryptoTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CryptoTransferController());
  }

}