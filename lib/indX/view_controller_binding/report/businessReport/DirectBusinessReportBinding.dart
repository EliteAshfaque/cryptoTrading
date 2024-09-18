import 'package:get/get.dart';

import 'DirectBusinessReportController.dart';



class DirectBusinessReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DirectBusinessReportController());
  }

}