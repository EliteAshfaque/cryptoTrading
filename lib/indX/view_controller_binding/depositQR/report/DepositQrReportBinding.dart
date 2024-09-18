import 'package:get/get.dart';

import 'DepositQrReportController.dart';

class DepositQrReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DepositQrReportController());
  }

}