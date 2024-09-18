import 'package:get/get.dart';

import 'SelfBusinessReportController.dart';



class SelfBusinessReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelfBusinessReportController());
  }

}