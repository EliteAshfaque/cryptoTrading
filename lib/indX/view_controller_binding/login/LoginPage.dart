import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Api/TypeActions.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../common/ConstantString.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import 'LoginController.dart';

class LoginPage extends StatelessWidget {
  LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          /*decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [primaryColorLight,primaryColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
          ),*/
          child: SingleChildScrollView(
            child: Obx(() => Column(children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset("assets/svg/login_bg.svg",
                          /*width: MediaQuery.of(context).size.width,*/
                          fit: BoxFit.fill),
                      SvgPicture.asset("assets/svg/logo.svg",
                          width: 180)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Welcome Back !",
                            style: poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 24)),
                        Text("Login to your account",
                            style: poppins(
                                color: gray_4,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)),
                        heightSpace_20,
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: TextField(
                                controller: controller.userIdController,
                                style: poppins(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                cursorColor: primaryColor,
                                maxLength: 10,

                                decoration: InputDecoration(
                                    border: DecoratedInputBorder(
                                      shadow: const [
                                        BoxShadow(
                                          color: primaryShadowGrey,
                                          blurRadius: 2,
                                          spreadRadius: 1.0
                                        )
                                      ],
                                      child: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    counterText: "",
                                    filled: true,
                                    contentPadding: const EdgeInsets.fromLTRB(70, 0, 10, 0),
                                    errorText: controller.userIdError.value.isNotEmpty ? controller.userIdError.value : null,
                                    errorStyle: poppins(
                                        color: Colors.red,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                    hintStyle: poppins(
                                        color: gray_3,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    hintText: "Enter Mobile Number/ User Id",
                                    fillColor: Colors.white),
                              ),
                            ),
                            Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryShadowGrey,
                                        blurRadius: 2,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: const Icon(
                                  size: 35,
                                  Icons.person_outlined,
                                  color: primaryColorLight,
                                ))
                          ],
                        ),
                        heightSpace_30,
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: TextField(
                                controller: controller.passwordController,
                                style: poppins(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                cursorColor: primaryColor,
                                obscureText: controller.passVisibility.value,
                                decoration: InputDecoration(
                                    border: DecoratedInputBorder(
                                      shadow: const [
                                        BoxShadow(
                                            color: primaryShadowGrey,
                                            blurRadius: 2,
                                            spreadRadius: 1.0
                                        )
                                      ],
                                      child: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    filled: true,
                                    contentPadding: const EdgeInsets.fromLTRB(70, 0, 10, 0),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          controller.passVisibility.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey[400]),
                                      onPressed: () {
                                        controller.passVisibility.value = !controller.passVisibility.value;
                                      },
                                    ),
                                    errorText:
                                        controller.passwordError.value.isNotEmpty
                                            ? controller.passwordError.value
                                            : null,
                                    errorStyle: poppins(
                                        color: Colors.red,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                    hintStyle: poppins(
                                        color: gray_3,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    hintText: "Enter Password",
                                    fillColor: Colors.white),
                              ),
                            ),
                            Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryShadowGrey,
                                        blurRadius: 2,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                                child: const Icon(
                                  size: 35,
                                  Icons.lock_outline_rounded,
                                  color: primaryColorLight,
                                ))
                          ],
                        ),
                        heightSpace_10,
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                showForgetPassDialog(context, controller);
                              },
                              child: Text("Forgot Password?",
                                  style: poppins(
                                      decoration: TextDecoration.underline,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13))),
                        ),
                        heightSpace_10,
                        InkWell(
                          onTap: () async {
                            controller.userIdError.value = "";
                            controller.passwordError.value = "";

                            if (controller.userIdController.text.trim().isEmpty) {
                              controller.userIdError.value = "Please enter valid mobile number/user id";
                              return;
                            } else if (controller.userIdController.text.trim().isNumericOnly &&
                                controller.userIdController.text.trim().length != 10) {
                              controller.userIdError.value = "Please enter valid 10 digit mobile number";
                              return;
                            } else if (!controller.userIdController.text.trim().isNumericOnly &&
                                controller.userIdController.text.trim().length < 3) {
                              controller.userIdError.value = "Please enter valid user id";
                              return;
                            } else if (controller.passwordController.text.trim().isEmpty) {
                              controller.passwordError.value = "Please enter password";
                              return;
                            }
                            controller.login(
                                controller.userIdController.text.trim(),
                                controller.passwordController.text.trim(),
                                    (LoginResponse response, int action) {
                                  if (action == TypeActions.INSTANCE.OTP) {
                                    controller.startTimer();
                                    showOTPDialog(context, controller, response);
                                  } else if (action ==
                                      TypeActions.INSTANCE.GAUTH) {
                                    showGAUTHDialog(context, controller, response);
                                  } else {
                                    Utility.INSTANCE.dialogIconOneButton("error", "", response.msg ?? SOMETHING_WRONG, "Cancel");
                                  }
                                });
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
                                    colors: [primaryColorLight,primaryColor],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)
                            ),child: Text("Login",
                              style: poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18)),
                          ),
                        ),

                        heightSpace_30,
                        Text("Don't have account?",
                            style: poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 12)),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.signup,arguments: true);
                            },
                            style: TextButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap,visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity)),
                            child: Text("Signup here",
                                style: poppins(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13))),
                      ],
                    ),
                  )
                ])),
          ),
        ),
      ),
    );
  }

  void showForgetPassDialog(context, LoginController controller) {
    Get.bottomSheet(
        isScrollControlled: true,
        Column(
          mainAxisSize: MainAxisSize.min,
         /* alignment: Alignment.topCenter,*/
          children: [
            InkWell(
              onTap: () => Get.back(),
              child:  const Icon(Icons.cancel, color: Colors.white, size: 35),
            ),
            Container(
                margin: const EdgeInsets.only(top: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                child: Obx(() => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Forgot Password!",
                            style: poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 25)),
                        heightSpace_5,
                        Text("Enter your registered mobile number or user id",
                            style: poppins(
                                color: gray_3,
                                fontWeight: FontWeight.w700,
                                fontSize: 12)),
                        heightSpace_30,
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: TextField(
                                controller: controller.userIdFPController,
                                style: poppins(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                cursorColor: Colors.black,
                                maxLength: 10,

                                decoration: InputDecoration(
                                    border: DecoratedInputBorder(
                                      shadow: const [
                                        BoxShadow(
                                            color: primaryShadowGrey,
                                            blurRadius: 2,
                                            spreadRadius: 1.0
                                        )
                                      ],
                                      child: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    counterText: "",
                                    filled: true,
                                    contentPadding: const EdgeInsets.fromLTRB(70, 0, 10, 0),
                                    errorText: controller.userIdFPError.value.isNotEmpty ? controller.userIdFPError.value : null,
                                    errorStyle: poppins(
                                        color: Colors.red,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                    hintStyle: poppins(
                                        color: gray_3,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    hintText: "Enter Mobile Number/ User Id",
                                    fillColor: Colors.white),
                              ),
                            ),
                            Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryShadowGrey,
                                        blurRadius: 2,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                                child: const Icon(
                                  size: 35,
                                  Icons.person_outlined,
                                  color: primaryColorLight,
                                ))
                          ],
                        ),
                        heightSpace_30,
                        InkWell(
                          onTap: () async {
                            controller.userIdFPError.value = "";

                            if (controller.userIdFPController.text
                                .trim()
                                .isEmpty) {
                              controller.userIdFPError.value =
                              "Please enter valid mobile number/user id";
                              return;
                            } else if (controller.userIdFPController.text
                                .trim()
                                .isNumericOnly &&
                                controller.userIdFPController.text
                                    .trim()
                                    .length !=
                                    10) {
                              controller.userIdFPError.value =
                              "Please enter valid 10 digit mobile number";
                              return;
                            } else if (!controller.userIdFPController.text
                                .trim()
                                .isNumericOnly &&
                                controller.userIdFPController.text
                                    .trim()
                                    .length <
                                    3) {
                              controller.userIdFPError.value =
                              "Please enter valid user id";
                              return;
                            }
                            controller.forgetPass(
                                controller.userIdFPController.text.trim());
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
                                    colors: [primaryColorLight,primaryColor],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)
                            ),child: Text("Submit",
                              style: poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18)),
                          ),
                        ),
                      ],
                    ))),

          ],
        ));
  }

  void showOTPDialog(
      context, LoginController controller, LoginResponse response) {
    Get.bottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Icon(Icons.cancel, color: Colors.white, size: 35),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.white),
                child: Obx(() => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("OTP Verification!",
                            style: poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 25)),
                       heightSpace_5,
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "An ",
                                style: poppins(
                                    color: gray_4,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                                children: [
                                  TextSpan(
                                      text: "OTP",
                                      style: poppins(
                                          color: gray_4,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12)),
                                  TextSpan(
                                      text:
                                          " has been sent on your registered ",
                                      style: poppins(
                                          color: gray_4,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)),
                                  TextSpan(
                                      text: "Mobile number",
                                      style: poppins(
                                          color: gray_4,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12)),
                                  TextSpan(
                                      text: " or ",
                                      style: poppins(
                                          color: gray_4,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)),
                                  TextSpan(
                                      text: "Email id",
                                      style: poppins(
                                          color: gray_4,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12)),
                                  TextSpan(
                                      text:
                                          " to verify mobile number, please enter it below.",
                                      style: poppins(
                                          color: gray_4,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12))
                                ])),
                        heightSpace_30,
                        OtpTextField(
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
                          handleControllers: (controllers) =>
                              controller.otpControllers.value = controllers,
                          enabledBorderColor:
                              controller.otpError.value.isNotEmpty
                                  ? Colors.red
                                  : gray_3,
                          fillColor: gray_1,

                          showFieldAsBox: true,
                          onCodeChanged: (value) {
                            if (value.length != 6) {
                              controller.otpValue.value = "";
                            }
                          },
                          onSubmit: (String verificationCode) {
                            controller.otpError.value = "";
                            controller.otpValue.value = verificationCode;
                          }, // end onSubmit
                        ),
                        heightSpace_5,
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Text(controller.otpError.value,
                                  textAlign: TextAlign.left,
                                  style: poppins(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12)),
                            )),
                        heightSpace_25,
                        InkWell(
                          onTap: () async {
                            controller.otpError.value = "";
                            if (controller.otpValue.value.length != 6) {
                              controller.otpError.value =
                              "Please enter valid 6 digit OTP";
                              return;
                            }

                            controller.validateOtp(controller.otpValue.value,
                                response.otpSession ?? "");
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
                                    colors: [primaryColorLight,primaryColor],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)
                            ),child: Text("Verify",
                              style: poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18)),
                          ),
                        ),

                        heightSpace_30,
                        if (controller.isOTPTimerStart.value == false)
                          ElevatedButton(
                              onPressed: () async {
                                controller.resendOtp(response.otpSession ?? "");
                              },
                              style: ElevatedButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: accentColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  minimumSize: const Size(100, 30)),
                              child: Text("Resend",
                                  style: poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)))
                        else
                          Text("Resend OTP : ${controller.second()} SEC",
                              style: poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14))
                      ],
                    ))),

          ],
        )).then((value) {
      controller.disposeOtpDialog();
    });
  }

  void showGAUTHDialog(
      context, LoginController controller, LoginResponse response) {
    Get.bottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Icon(Icons.cancel, color: Colors.white, size: 35),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.white),
                child: Obx(() => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("TOTP Verification!",
                            style: poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 25)),
                        heightSpace_5,
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Open Google Auth Application and enter ",
                                style: poppins(
                                    color: gray_4,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                                children: [
                                  TextSpan(
                                      text: "TOTP",
                                      style: poppins(
                                          color: gray_4,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12)),
                                  TextSpan(
                                      text:
                                          " to verify User Id, please enter it below.",
                                      style: poppins(
                                          color: gray_4,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12))
                                ])),
                        heightSpace_30,
                        OtpTextField(
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
                          handleControllers: (controllers) =>
                              controller.otpControllers.value = controllers,
                          enabledBorderColor:
                              controller.otpError.value.isNotEmpty
                                  ? Colors.red
                                  : gray_3,
                          fillColor: gray_1,
                          showFieldAsBox: true,
                          onCodeChanged: (value) {
                            if (value.length != 6) {
                              controller.otpValue.value = "";
                            }
                          },
                          onSubmit: (String verificationCode) {
                            controller.otpError.value = "";
                            controller.otpValue.value = verificationCode;
                          }, // end onSubmit
                        ),
                        heightSpace_5,
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Text(controller.otpError.value,
                                  textAlign: TextAlign.left,
                                  style: poppins(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12)),
                            )),
                        heightSpace_20,
                        InkWell(
                          onTap: () async {
                            controller.otpError.value = "";
                            if (controller.otpValue.value.length != 6) {
                              controller.otpError.value =
                              "Please enter valid 6 digit TOTP";
                              return;
                            }

                            controller.validateGAUTH(
                                controller.otpValue.value,
                                response.otpSession ?? "");
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
                                    colors: [primaryColorLight,primaryColor],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)
                            ),child: Text("Verify",
                              style: poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18)),
                          ),
                        ),
                      ],
                    ))),

          ],
        )).then((value) {
      controller.disposeOtpDialog();
    });
  }
}
