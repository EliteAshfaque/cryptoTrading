import 'package:get/get.dart';

import 'BinaryBusinessReportController.dart';

class BinaryBusinessReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BinaryBusinessReportController());
  }
}
