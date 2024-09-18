import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../api/TypeActions.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/userDetails/UserDetailResponse.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import 'ProfileApi.dart';

class ProfileController extends GetxController {

  ProfileApi api = ProfileApi();
  LoginResponse loginResponse =Get.find();
  var userDetailResponse=UserDetailResponse().obs;
  GetStorage storage = Get.find();
  @override
  void onInit() async{
    super.onInit();
   await getUserDetails();
  }



  Future<void> getUserDetails() async {

    await api.getProfile(storage, loginResponse.data!, (action, response) async {

      if (action == TypeActions.INSTANCE.SUCCESS) {
        userDetailResponse.value =response;
        if(userDetailResponse.value.userInfo!.isDoubleFactor!=loginResponse.data!.isDoubleFactor){
          loginResponse.data!.isDoubleFactor = userDetailResponse.value.userInfo!.isDoubleFactor;
          Get.delete<LoginResponse>(force: true);
          Get.put(loginResponse,permanent: true);
          await storage.write(LOGIN_DATA, loginResponse.toJson());
        }

      }else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  Future<void> getStoredUserDetails() async {
    await api.getStoredProfile( storage,(UserDetailResponse response) async {
        userDetailResponse.value =response;
    });
  }

  Future<void> emailVerify() async {

    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Verifying Email id ...',isCancelabel: false);
    await api.emailVerify(storage, loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        Utility.INSTANCE.dialogIconOneButton("check","", response, "Cancel");
      }else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  Future<void> logout(String type) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Signing Out ...', isCancelabel: false);
    await api.logout(storage, type,loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
       /* Utility.INSTANCE.dialogIconOneButton("check","", response, "Cancel");*/
      }else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

}