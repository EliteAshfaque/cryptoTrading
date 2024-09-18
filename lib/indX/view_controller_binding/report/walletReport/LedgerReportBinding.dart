import 'package:get/get.dart';

import 'LedgerReportController.dart';

class LedgerReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LedgerReportController());
  }

}