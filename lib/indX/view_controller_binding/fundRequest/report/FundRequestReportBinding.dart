import 'package:get/get.dart';

import 'FundRequestReportController.dart';

class FundRequestReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FundRequestReportController());
  }

}