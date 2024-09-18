import 'package:get/get.dart';


import 'DepositQrController.dart';

class DepositQrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DepositQrController());
  }

}