import 'package:get/get.dart';


import 'RecentPinActivityController.dart';

class RecentPinActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecentPinActivityController());
  }

}