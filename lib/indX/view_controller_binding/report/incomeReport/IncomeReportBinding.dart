import 'package:get/get.dart';


import 'IncomeReportController.dart';


class IncomeReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IncomeReportController());
  }

}