import 'package:get/get.dart';

import 'DirectTeamReportController.dart';

class DirectTeamReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DirectTeamReportController());
  }

}