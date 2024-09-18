import 'package:get/get.dart';

import 'SwapReportController.dart';



class SwapReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SwapReportController());
  }

}