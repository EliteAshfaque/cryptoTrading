import 'package:get/get.dart';

import 'SponserBusinessReportController.dart';

class SponserBusinessReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SponserBusinessReportController());
  }
}
