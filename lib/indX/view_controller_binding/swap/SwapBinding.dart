import 'package:get/get.dart';

import 'SwapController.dart';

class SwapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SwapController());
  }

}