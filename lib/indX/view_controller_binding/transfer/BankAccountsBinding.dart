import 'package:get/get.dart';

import 'BankAccountsController.dart';

class BankAccountsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BankAccountsController());
  }

}