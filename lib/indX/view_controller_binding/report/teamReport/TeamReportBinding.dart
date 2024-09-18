import 'package:get/get.dart';

import 'TeamReportController.dart';



class TeamReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeamReportController());
  }

}