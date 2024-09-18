import 'package:get/get.dart';

import 'MyStakeReportController.dart';

class MyStakeReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyStakeReportController());
  }
}
