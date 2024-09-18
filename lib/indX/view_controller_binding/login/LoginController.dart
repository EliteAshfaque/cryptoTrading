import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/TypeActions.dart';
import '../../api/model/login/LoginRequest.dart';
import '../../api/model/login/OTPRequest.dart';
import '../../api/model/login/OTPResendRequest.dart';
import '../../common/ConstantString.dart';
import '../../routes/AppRoutes.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import 'LoginApi.dart';

 class LoginController extends GetxController {


  var userIdError ="".obs;
  var passwordError ="".obs;

  var userIdFPError ="".obs;
  var passVisibility=true.obs;

  final TextEditingController  userIdController = TextEditingController();
  final TextEditingController  passwordController = TextEditingController();

  final TextEditingController  userIdFPController = TextEditingController();

  final otpControllers = <TextEditingController?>[].obs;
  final otpError="".obs;
  final otpValue="".obs;


  Timer? countdownTimer;
  Rx<Duration> myDuration =  const Duration(seconds: 60).obs;
  var isOTPTimerStart = false.obs;
  LoginApi api = LoginApi();
  PackageInfo packageInfo =Get.find();
  /*@override
  void onInit() async {
    super.onInit();

  }*/



  Future<void> login( String userId, String password, Function callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Authenticating ...',isCancelabel: false);
    await api.login( LoginRequest(isSeller: true,userID:userId,
        password: password,appid: APP_ID,domain: DOMAIN,imei: DEVICE_ID,loginTypeID: 1,regKey: "",serialNo: DEVICE_ID,version: packageInfo.version), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        Get.offAllNamed(AppRoutes.dashboard);
      }else if (action == TypeActions.INSTANCE.OTP || action == TypeActions.INSTANCE.GAUTH) {
        if(callBack!=null){
          callBack(response,action);
        }
      }else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  Future<void> validateOtp( String otp, String otpSession) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Validating OTP ...',isCancelabel: false);
    await api.validateOTP( OTPRequest(isSeller: true,loginTypeID:1, otp: otp, oTPSession: otpSession,oTPType: 1,domain: DOMAIN,appid: APP_ID,
        imei: DEVICE_ID,regKey: "",version: packageInfo.version,serialNo: DEVICE_ID), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }
  Future<void> resendOtp( String otpSession,) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Resending OTP ...',isCancelabel: false);
    await api.resendOTP( OTPResendRequest(isSeller: true,loginTypeID:1,  oTPSession: otpSession,domain: DOMAIN,appid: APP_ID,
        imei: DEVICE_ID,regKey: "",version: packageInfo.version,serialNo: DEVICE_ID), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        startTimer();
        Get.snackbar("OTP", response).show();
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  Future<void> validateGAUTH(String otp, String otpSession) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Validating TOTP ...',isCancelabel: false);
    await api.validateGAuthPin(OTPRequest(isSeller: true,loginTypeID:1, otp: otp, oTPSession: otpSession,oTPType: 1,domain: DOMAIN,appid: APP_ID,
        imei: DEVICE_ID,regKey: "",version: packageInfo.version,serialNo: DEVICE_ID), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  Future<void> forgetPass(String userId) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Sending Password ...',isCancelabel: false);
    await api.forgetPassword( LoginRequest(isSeller: true,userID:userId,
        password: "",appid: APP_ID,domain: DOMAIN,imei: DEVICE_ID,loginTypeID: 1,regKey: "",serialNo: DEVICE_ID,version: packageInfo.version), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        Get.back();
        userIdFPController.text="";
        Utility.INSTANCE.dialogIconOneButton("check","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }


  String second(){
    String strDigits(int n) => n.toString().padLeft(2, '0');
   var seconds = strDigits(myDuration.value.inSeconds.remainder(60));
   if (seconds == "-1" || seconds=="00") {
       seconds = "60";
    }
    return seconds;
  }
  void resetTimer() {

    myDuration.value = const Duration(seconds: 60);
    stopTimer();
  }

  void stopTimer() {

    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
    isOTPTimerStart.value = false;
  }
  void startTimer() {

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    isOTPTimerStart.value = true;
  }
  void setCountDown() {
    const reduceSecondsBy = 1;

    var seconds = myDuration.value.inSeconds - reduceSecondsBy;

    if (seconds <= 0) {
      resetTimer();
    } else {
      myDuration.value = Duration(seconds: seconds);
    }

  }

  @override
  void onClose() {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
    super.onClose();
  }

  @override
  void dispose() {
    userIdController.dispose();
    userIdFPController.dispose();
    passwordController.dispose();

    for(var item in otpControllers){
      item!.dispose();
    }
    otpControllers.clear();

    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
    super.dispose();
  }

  void disposeOtpDialog() {

    otpError.value="";
    otpValue.value="";
    if (countdownTimer != null && countdownTimer!.isActive) {
      resetTimer();
    }
  }
}