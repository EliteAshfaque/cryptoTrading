import 'package:get/get.dart';

import 'AddUserController.dart';

class AddUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddUserController());
  }

}