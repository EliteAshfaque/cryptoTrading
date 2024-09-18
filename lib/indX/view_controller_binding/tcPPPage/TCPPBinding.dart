import 'package:get/get.dart';

import 'TCPPController.dart';

class TCPPBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TCPPController());
  }

}