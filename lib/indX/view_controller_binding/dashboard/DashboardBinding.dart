import 'package:get/get.dart';

import 'DashboardController.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }

}