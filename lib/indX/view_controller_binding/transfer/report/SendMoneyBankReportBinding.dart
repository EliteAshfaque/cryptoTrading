import 'package:get/get.dart';

import 'SendMoneyBankReportController.dart';



class SendMoneyBankReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SendMoneyBankReportController());
  }

}