import 'package:get/get.dart';

import 'InviteReferralController.dart';

class InviteReferralBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InviteReferralController());
  }

}