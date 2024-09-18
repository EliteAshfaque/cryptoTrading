import 'package:get/get.dart';

import 'ActivateUserByStakingController.dart';

class ActivateUserByStakingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivateUserByStakingController());
  }

}