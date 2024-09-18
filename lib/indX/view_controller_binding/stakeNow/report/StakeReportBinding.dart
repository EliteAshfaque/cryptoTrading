import 'package:get/get.dart';


import 'StakeReportController.dart';


class StakeReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StakeReportController());
  }

}