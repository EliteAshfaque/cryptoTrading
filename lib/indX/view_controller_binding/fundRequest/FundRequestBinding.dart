import 'package:get/get.dart';

import 'FundRequestController.dart';

class FundRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FundRequestController());
  }

}