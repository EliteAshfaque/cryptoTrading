import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'SplashController.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    Get.put(GetStorage(),permanent: true);
  }
}