import 'package:get/get.dart';


import 'GAuthSetupController.dart';

class GAuthSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GAuthSetupController());
  }

}