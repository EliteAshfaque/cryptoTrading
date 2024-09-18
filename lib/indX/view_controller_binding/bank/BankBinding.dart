import 'package:get/get.dart';

import 'BankController.dart';

class BankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BankController());
  }

}