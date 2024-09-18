import 'package:get/get.dart';

import 'StakeNowByPackageController.dart';

class StakeNowByPackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StakeNowByPackageController());
  }

}