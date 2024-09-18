import 'package:get/get.dart';

import 'SendMoneyBankController.dart';

class SendMoneyBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SendMoneyBankController());
  }

}