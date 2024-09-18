import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../Api/TypeActions.dart';
import '../../api/model/login/LoginData.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/login/LoginWithOTPRequest.dart';
import '../../api/model/signup/SignupRequest.dart';
import '../../api/model/signup/UserCreateSignup.dart';
import '../../common/ConstantString.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import '../signup/SignupApi.dart';
import 'SplashApi.dart';

class SplashController extends GetxController {
  GetStorage storage = Get.find();
  Timer? timer;
  SplashApi api = SplashApi();
  SignupApi apiSignup =SignupApi();
  late PackageInfo packageInfo;
  var isShowLoader = false.obs;
  final otpControllers = <TextEditingController?>[].obs;
  final otpError = "".obs;
  final otpValue = "".obs;
  Timer? countdownTimer;
  Rx<Duration> myDuration = const Duration(seconds: 60).obs;
  var isOTPTimerStart = false.obs;
  var argumentsList = Get.arguments??<String>[];

  @override
  void onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();
    Get.put(packageInfo, permanent: true);

    if(argumentsList!=null && argumentsList.isNotEmpty){
        isShowLoader.value = true;
        String referralId = argumentsList[0];
        String referralName = argumentsList[1];
        String userId = argumentsList[2];
        String name = argumentsList[3];
        String mobile = argumentsList[4];
        String email = argumentsList[5];
        String address = argumentsList[6];
        String pincode = argumentsList[7];


        if(Get.isRegistered<LoginResponse>()) {
          LoginResponse loginResponse=Get.find<LoginResponse>();
          if (loginResponse != null && loginResponse.data != null) {
            if ((loginResponse.data!.emailID ?? "").toLowerCase().trim() == email.toLowerCase().trim()) {
              Get.put(loginResponse, permanent: true);
              Get.offNamed(AppRoutes.dashboard);
            } else {
              await logout(referralId, referralName, userId, name, mobile, email, address, pincode, "1", loginResponse.data!);
            }
          }else{
            await sendOTP(false,referralId, referralName, userId, name, mobile, email, address, pincode);
          }
        }
        else if (await storage.hasData(LOGIN_DATA)) {
          LoginResponse loginResponse = await LoginResponse.fromJson(await storage.read(LOGIN_DATA));
          if (loginResponse != null && loginResponse.data != null) {
            if ((loginResponse.data!.emailID ?? "").toLowerCase().trim() == email.toLowerCase().trim()) {
              Get.put(loginResponse, permanent: true);
              Get.offNamed(AppRoutes.dashboard);
            } else {
              await logout(referralId, referralName, userId, name, mobile, email, address, pincode, "1", loginResponse.data!);
            }
          }else{
            await sendOTP(false,referralId, referralName, userId, name, mobile, email, address, pincode);
          }
        } else {
          await sendOTP(false,referralId, referralName, userId, name, mobile, email, address, pincode);
          /*showOTPDialog(LoginResponse());*/
        }
    } else {
      isShowLoader.value = false;
      next();
    }
  }

  next() {
    timer = Timer(
      const Duration(milliseconds: 500),
          () async {
        if (await storage.hasData(LOGIN_DATA)) {
          Get.put(await LoginResponse.fromJson(await storage.read(LOGIN_DATA)), permanent: true);
          Get.offNamed(AppRoutes.dashboard);
        } else {
          Get.offNamed(AppRoutes.welcome);
        }
      },
    );
  }

  Future<void> logout(String referralId, String referralName, String userId, String name, String mobile, String email, String address,
      String pincode, String type, LoginData loginData) async {
    await api.logout(
        storage, packageInfo, type, loginData, (action, response) async {
      if (action == TypeActions.INSTANCE.SUCCESS) {
        await sendOTP(false,referralId, referralName, userId, name, mobile, email, address, pincode);
        /* Utility.INSTANCE.dialogIconOneButton("check","", response, "Cancel");*/
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> sendOTP(bool isResendOTP,String referralId, String referralName, String userId, String name, String mobile, String email,
      String address, String pincode) async {
    if(isResendOTP) {
      DialogBuilder.INSTANCE.showLoadingIndicator('', 'OTP is resending...', isCancelabel: false);
    }
    await api.sendOTP(LoginWithOTPRequest(isSeller: true, MobileNo: email, appid: APP_ID, domain: DOMAIN, imei: DEVICE_ID, loginTypeID: 1, regKey: "", serialNo: DEVICE_ID, version: packageInfo.version),
            (action, response) async {
              if(isResendOTP) {
                DialogBuilder.INSTANCE.hideOpenDialog();
              }
          if (action == TypeActions.INSTANCE.SUCCESS) {
            startTimer();
            showOTPDialog(referralId, referralName, userId, name, mobile, email, address, pincode,response);
            Get.snackbar("","",
                titleText:Text('Success',
                    style: poppins(color: green_5,fontSize: 14,fontWeight: FontWeight.w700)),
                messageText:Text('OTP sent successfully',
                    style: poppins(color: green_5,fontSize: 12,fontWeight: FontWeight.w600)),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: gray_6 );
           // Utility.INSTANCE.dialogIconOneButton("check", "", "OTP sent successfully", "Cancel");
          } else if (action == TypeActions.INSTANCE.REGISTER) {
            register(referralId, referralName, userId, name, mobile, email, address, pincode);
          } else if (action == TypeActions.INSTANCE.ERROR) {
            Utility.INSTANCE.dialogIconOneButton(
                "error", "", response, "Cancel");
          } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
            Utility.INSTANCE.dialogIconOneButton(
                "wifi_error", "Network Error", "No Internet Connection",
                "Cancel");
          }
        });
  }

  Future<void> validateLoginWithOTP( String otp, String email) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Validating OTP ...',isCancelabel: false);
    await api.validateLoginWithOTP(storage, LoginWithOTPRequest(isSeller: true, MobileNo: email,Otp: otp, appid: APP_ID, domain: DOMAIN, imei: DEVICE_ID, loginTypeID: 1, regKey: "", serialNo: DEVICE_ID, version: packageInfo.version), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        Get.back();
        Get.offNamed(AppRoutes.dashboard);
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  Future<void> register(String referralId, String referralName, String userId, String name, String mobile, String email,
      String address, String pincode) async {
    String reffralStr = referralId.isNotEmpty ? (referralId.trim().isNumericOnly ? referralId.trim() : referralId.trim().replaceAll(RegExp("[^0-9]"), "")) : "1";
    await apiSignup.signup(SignupRequest(isSeller: true, referalID: reffralStr, referalIDstr: referralId.isNotEmpty ? referralId.trim() : "1", legs: "L",
        domain: DOMAIN, appid: APP_ID, imei: DEVICE_ID, regKey: "", version: packageInfo.version, serialNo: DEVICE_ID,
        userCreate: UserCreateSignup(isSeller: true, pincode: pincode.trim(), mobileNo: mobile.trim(), name: name.trim(), address: address.trim(),
            countryCode: "+91", emailID: email.trim(), legs: "L", outletName: name.trim(), referalID: reffralStr, referalIDstr: referralId.isNotEmpty ? referralId.trim() : "1", roleID: 3)), (action, response) async {
      if (action == TypeActions.INSTANCE.SUCCESS) {
        await sendOTP(false,referralId, referralName, userId, name, mobile, email, address, pincode);
        if(referralId!=null && referralId.isNotEmpty) {
          await storage.write(IS_REFFER_USED, true);
        }
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  void showOTPDialog(String referralId, String referralName, String userId, String name, String mobile, String email, String address,
      String pincode,LoginResponse response) {
    if(Get.isBottomSheetOpen==false) {
      Get.bottomSheet(
          isScrollControlled: true,
          ignoreSafeArea: false,
          enableDrag: false,
          isDismissible: false,

          SafeArea(
            child: WillPopScope(
              onWillPop: () async => false,
              child: Obx(() =>
                  Container(
                    height: double.infinity,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                Get.back(closeOverlays: true);
                                /*if (Platform.isAndroid) {
                                  SystemNavigator.pop();
                                } else if (Platform.isIOS) {
                                  exit(0);
                                }*/
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Icon(Icons.cancel, color: Colors.black, size: 30),
                              ),
                            ),
                          ),
                          SvgPicture.asset("assets/svg/logo.svg", width: 180),
                          heightSpace_30,
                          Text("OTP Verification!",
                              style: poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: "An ",
                                    style: poppins(
                                        color: gray_5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                    children: [
                                      TextSpan(
                                          text: "OTP",
                                          style: poppins(
                                              color: gray_5,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12)),
                                      TextSpan(
                                          text: " has been sent on your registered ",
                                          style: poppins(
                                              color: gray_5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12)),
                                      TextSpan(
                                          text: "Mobile number",
                                          style: poppins(
                                              color: gray_5,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12)),
                                      TextSpan(
                                          text: " or ",
                                          style: poppins(
                                              color: gray_5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12)),
                                      TextSpan(
                                          text: "Email id",
                                          style: poppins(
                                              color: gray_5,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12)),
                                      TextSpan(
                                          text: " to verify your account, please enter it below.",
                                          style: poppins(
                                              color: gray_5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))
                                    ])),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                            child: OtpTextField(
                              margin: const EdgeInsets.all(0),
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              numberOfFields: 6,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              borderColor: gray_3,
                              focusedBorderColor: gray_3,
                              cursorColor: primaryColor,
                              textStyle: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w500),
                              filled: true,
                              borderWidth: 1,
                              handleControllers: (controllers) => otpControllers.value = controllers,
                              enabledBorderColor: otpError.value.isNotEmpty ? Colors.red : gray_3,
                              fillColor: gray_1,
                              showFieldAsBox: true,
                              onCodeChanged: (value) {
                                if (value.length != 6) {
                                  otpValue.value = "";
                                }
                              },
                              onSubmit: (String verificationCode) {
                                otpError.value = "";
                                otpValue.value = verificationCode;
                              }, // end onSubmit
                            ),
                          ),
                          heightSpace_5,
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                                child: Text(otpError.value,
                                    textAlign: TextAlign.left,
                                    style: poppins(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                              )),
                          heightSpace_30,
                          InkWell(
                            onTap: () async {
                              otpError.value = "";
                              if (otpValue.value.length != 6) {
                                otpError.value = "Please enter valid 6 digit OTP";
                                return;
                              }
                              await validateLoginWithOTP(otpValue.value, email);
                            },
                            child: Container(
                              width: 170,
                              height: 48,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryShadowGrey,
                                      blurRadius: 2,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  gradient: LinearGradient(
                                      colors: [primaryColorLight, primaryColor],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                              child: Text("Verify",
                                  style: poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18)),
                            ),
                          ),
                          heightSpace_40,
                          if (isOTPTimerStart.value == false)
                            ElevatedButton(
                                onPressed: () async {
                                  await sendOTP(true,referralId, referralName, userId, name, mobile, email, address, pincode);
                                },
                                style: ElevatedButton.styleFrom(
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    backgroundColor: accentColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    minimumSize: const Size(100, 30)),
                                child: Text("Resend",
                                    style: poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13)))
                          else
                            Text("Resend OTP : ${second()} SEC",
                                style: poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                          heightSpace_30,
                        ],
                      ),
                    ),
                  )),
            ),
          )).then((value) {
        disposeOtpDialog();
      });
    }
  }

  String second() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    var seconds = strDigits(myDuration.value.inSeconds.remainder(60));
    if (seconds == "-1" || seconds == "00") {
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
    if (timer != null) {
      timer!.cancel();
    }
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
    super.onClose();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }

    for (var item in otpControllers) {
      item!.dispose();
    }
    otpControllers.clear();

    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
    super.dispose();
  }

  void disposeOtpDialog() {
    otpError.value = "";
    otpValue.value = "";
    if (countdownTimer != null && countdownTimer!.isActive) {
      resetTimer();
    }
  }
}
