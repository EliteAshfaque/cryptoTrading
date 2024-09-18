import 'package:get/get.dart';

import 'AddUpdateBankController.dart';

class AddUpdateBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddUpdateBankController());
  }

}