import 'package:get/get.dart';

import 'SupportSettingController.dart';

class SupportSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupportSettingController());
  }

}