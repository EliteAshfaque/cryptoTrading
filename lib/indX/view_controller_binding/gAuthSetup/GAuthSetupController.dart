

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../api/TypeActions.dart';
import '../../api/model/balance/BalanceResponse.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/support/Google2FAResponse.dart';
import '../../api/model/userDetails/UserDetailResponse.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import 'GoogleAuthApi.dart';


class GAuthSetupController extends GetxController {

  GoogleAuthApi api = GoogleAuthApi();
  LoginResponse loginResponse =Get.find();
  Rx<bool> isGoogle2FAEnable = Get.arguments[0];
  Rx<Google2FAResponse> gAuthResp=Get.arguments[1];
  GetStorage storage = Get.find();
  final otpControllers = <TextEditingController?>[].obs;
  final otpError="".obs;
  final otpValue="".obs;
  @override
  void onInit() async {
    super.onInit();
  }


  Future<void> sendOTPApi(bool isDialogOpen,Function? callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Changing GAuth Double Factor Status ...', isCancelabel: false);
    await api.sendOTP(storage, loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        if(callBack!=null){
          callBack(response);
        }
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> getGoogleAuthData(bool isDialogOpen, String otp, int refId,Function? callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting GAuth Data ...', isCancelabel: false);
    await api.getGAuthData(storage, otp, refId, loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if(isDialogOpen==true) {
        Get.back();
      }
      if (action == TypeActions.INSTANCE.SUCCESS) {

        if (response.qrCodeSetupKey != null && response.qrCodeSetupKey!.isNotEmpty &&
            response.qrCodeSetupImageUrl != null && response.qrCodeSetupImageUrl!.isNotEmpty) {
          if (callBack != null) {
            callBack(response);
          }
        } else {
          Utility.INSTANCE.dialogIconOneButton("error", "","Setup data is not available","Cancel");
        }

      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> resetGoogleAuth(bool isDialogOpen, String otp, int refId) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Resetting GAuth Data ...', isCancelabel: false);
    await api.resetGoogleAuth(storage, otp, refId, loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();

      if (action == TypeActions.INSTANCE.SUCCESS) {
        if(isDialogOpen==true) {
          Get.back();
        }

        isGoogle2FAEnable.value=response.isEnabled??false;
        gAuthResp.value.isEnabled=response.isEnabled??false;
        gAuthResp.value.alreadyRegistered=response.alreadyRegistered??false;
        gAuthResp.refresh();
        if(Get.isRegistered<UserDetailResponse>(tag: USER_DATA)){
          UserDetailResponse responseUser = Get.find<UserDetailResponse>(tag: USER_DATA);
          responseUser.userInfo!.isGoogle2FAEnable=response.isEnabled??false;
          responseUser.userInfo!.isGoogle2FARegister=response.alreadyRegistered??false;
          await storage.write(USER_DATA, responseUser.toJson());
          await Get.delete<UserDetailResponse>(tag: USER_DATA,force: true);
          await Get.putAsync<UserDetailResponse>(() async {return responseUser;}, tag: USER_DATA,permanent: true);
        } else if(storage.hasData(USER_DATA)){
          UserDetailResponse responseUser =UserDetailResponse.fromJson(await storage.read(USER_DATA));
          responseUser.userInfo!.isGoogle2FAEnable=response.isEnabled??false;
          responseUser.userInfo!.isGoogle2FARegister=response.alreadyRegistered??false;
          await storage.write(USER_DATA, responseUser.toJson());
          await Get.delete<UserDetailResponse>(tag: USER_DATA,force: true);
          await Get.putAsync<UserDetailResponse>(() async {return responseUser;}, tag: USER_DATA,permanent: true);

        }
        if(Get.isRegistered<BalanceResponse>(tag: BALANCE_DATA)){
          BalanceResponse responseBal =await Get.find<BalanceResponse>(tag: BALANCE_DATA);
          responseBal.isGoogle2FARegister=response.isEnabled??false;
          responseBal.isGoogle2FAEnable=response.alreadyRegistered??false;
          await storage.write(BALANCE_DATA, responseBal.toJson());
          await Get.delete<BalanceResponse>(tag: BALANCE_DATA,force: true);
          await Get.putAsync<BalanceResponse>(() async {return responseBal;}, tag: BALANCE_DATA,permanent: true);
        } else if(storage.hasData(BALANCE_DATA)){
          BalanceResponse responseBal =BalanceResponse.fromJson(await storage.read(BALANCE_DATA));
          responseBal.isGoogle2FARegister=response.isEnabled??false;
          responseBal.isGoogle2FAEnable=response.alreadyRegistered??false;
          await storage.write(BALANCE_DATA, responseBal.toJson());
          await Get.delete<BalanceResponse>(tag: BALANCE_DATA,force: true);
          await Get.putAsync<BalanceResponse>(() async {return responseBal;}, tag: BALANCE_DATA,permanent: true);
        }

        Utility.INSTANCE.dialogIconOneButtonWithCallback("check", "", response.msg??"You are successfully reset google authenticator",false, "Ok",(value){
          Get.back(result: true);
        });

      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> enableDisableGoogleAuth(bool isDialogOpen, String otp, int refId) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Changing Status ...', isCancelabel: false);
    await api.enableDisableGoogleAuth(storage, otp, refId, loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();

      if (action == TypeActions.INSTANCE.SUCCESS) {
        if(isDialogOpen==true) {
          Get.back();
        }

        isGoogle2FAEnable.value=response.isEnabled??false;
        gAuthResp.value.isEnabled=response.isEnabled??false;
        gAuthResp.value.alreadyRegistered=response.alreadyRegistered??false;
        gAuthResp.refresh();

        if(Get.isRegistered<UserDetailResponse>(tag: USER_DATA)){
          UserDetailResponse responseUser = Get.find<UserDetailResponse>(tag: USER_DATA);
          responseUser.userInfo!.isGoogle2FAEnable=response.isEnabled??false;
          responseUser.userInfo!.isGoogle2FARegister=response.alreadyRegistered??false;
          await storage.write(USER_DATA, responseUser.toJson());
          await Get.delete<UserDetailResponse>(tag: USER_DATA,force: true);
          await Get.putAsync<UserDetailResponse>(() async {return responseUser;}, tag: USER_DATA,permanent: true);
        } else if(storage.hasData(USER_DATA)){
          UserDetailResponse responseUser =UserDetailResponse.fromJson(await storage.read(USER_DATA));
          responseUser.userInfo!.isGoogle2FAEnable=response.isEnabled??false;
          responseUser.userInfo!.isGoogle2FARegister=response.alreadyRegistered??false;
          await storage.write(USER_DATA, responseUser.toJson());
          await Get.delete<UserDetailResponse>(tag: USER_DATA,force: true);
          await Get.putAsync<UserDetailResponse>(() async {return responseUser;}, tag: USER_DATA,permanent: true);

        }
        if(Get.isRegistered<BalanceResponse>(tag: BALANCE_DATA)){
          BalanceResponse responseBal =await Get.find<BalanceResponse>(tag: BALANCE_DATA);
          responseBal.isGoogle2FARegister=response.isEnabled??false;
          responseBal.isGoogle2FAEnable=response.alreadyRegistered??false;
          await storage.write(BALANCE_DATA, responseBal.toJson());
          await Get.delete<BalanceResponse>(tag: BALANCE_DATA,force: true);
          await Get.putAsync<BalanceResponse>(() async {return responseBal;}, tag: BALANCE_DATA,permanent: true);
        } else if(storage.hasData(BALANCE_DATA)){
          BalanceResponse responseBal =BalanceResponse.fromJson(await storage.read(BALANCE_DATA));
          responseBal.isGoogle2FARegister=response.isEnabled??false;
          responseBal.isGoogle2FAEnable=response.alreadyRegistered??false;
          await storage.write(BALANCE_DATA, responseBal.toJson());
          await Get.delete<BalanceResponse>(tag: BALANCE_DATA,force: true);
          await Get.putAsync<BalanceResponse>(() async {return responseBal;}, tag: BALANCE_DATA,permanent: true);
        }

        Utility.INSTANCE.dialogIconOneButtonWithCallback("check", "", response.msg??"You are successfully reset google authenticator",false, "Ok",(value){
          Get.back(result: true);
        });

      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> verifyGAuthSetup(bool isDialogOpen, String accountSecretKey, String googlePin) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Setting up google authenticator ...', isCancelabel: false);
    await api.verifyGAuthSetup(storage, accountSecretKey, googlePin, loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();

      if (action == TypeActions.INSTANCE.SUCCESS) {
        if(isDialogOpen==true) {
          Get.back();
        }
        isGoogle2FAEnable.value=true;
        gAuthResp.value.isEnabled=true;
        gAuthResp.value.alreadyRegistered=true;
        gAuthResp.refresh();

        if(Get.isRegistered<UserDetailResponse>(tag: USER_DATA)){
          UserDetailResponse responseUser = Get.find<UserDetailResponse>(tag: USER_DATA);
          responseUser.userInfo!.isGoogle2FAEnable=true;
          responseUser.userInfo!.isGoogle2FARegister=true;
          await storage.write(USER_DATA, responseUser.toJson());
          await Get.delete<UserDetailResponse>(tag: USER_DATA,force: true);
          await Get.putAsync<UserDetailResponse>(() async {return responseUser;}, tag: USER_DATA,permanent: true);
        } else if(storage.hasData(USER_DATA)){
          UserDetailResponse responseUser =UserDetailResponse.fromJson(await storage.read(USER_DATA));
          responseUser.userInfo!.isGoogle2FAEnable=true;
          responseUser.userInfo!.isGoogle2FARegister=true;
          await storage.write(USER_DATA, responseUser.toJson());
          await Get.delete<UserDetailResponse>(tag: USER_DATA,force: true);
          await Get.putAsync<UserDetailResponse>(() async {return responseUser;}, tag: USER_DATA,permanent: true);

        }
        if(Get.isRegistered<BalanceResponse>(tag: BALANCE_DATA)){
          BalanceResponse responseBal =await Get.find<BalanceResponse>(tag: BALANCE_DATA);
          responseBal.isGoogle2FARegister=true;
          responseBal.isGoogle2FAEnable=true;
          await storage.write(BALANCE_DATA, responseBal.toJson());
          await Get.delete<BalanceResponse>(tag: BALANCE_DATA,force: true);
          await Get.putAsync<BalanceResponse>(() async {return responseBal;}, tag: BALANCE_DATA,permanent: true);
        } else if(storage.hasData(BALANCE_DATA)){
          BalanceResponse responseBal =BalanceResponse.fromJson(await storage.read(BALANCE_DATA));
          responseBal.isGoogle2FARegister=true;
          responseBal.isGoogle2FAEnable=true;
          await storage.write(BALANCE_DATA, responseBal.toJson());
          await Get.delete<BalanceResponse>(tag: BALANCE_DATA,force: true);
          await Get.putAsync<BalanceResponse>(() async {return responseBal;}, tag: BALANCE_DATA,permanent: true);
        }

        Utility.INSTANCE.dialogIconOneButtonWithCallback("check", "", response.msg??"You are successfully register with google authenticator",false, "Ok",(value){
          Get.back(result: true);
        });

      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  @override
  void dispose() {

    for(var item in otpControllers){
      item!.dispose();
    }
    otpControllers.clear();


    super.dispose();
  }

}
