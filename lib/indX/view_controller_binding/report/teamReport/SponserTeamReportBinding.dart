import 'package:get/get.dart';


import 'SponserTeamReportController.dart';


class SponserTeamReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SponserTeamReportController());
  }

}