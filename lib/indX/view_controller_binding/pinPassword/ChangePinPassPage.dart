import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import 'ChangePinPassController.dart';

class ChangePinPassPage extends StatelessWidget {
  bool isCancelable;
  bool isPin;
  String title;
  String msg;
  Function? callBack;

  ChangePinPassPage(
      {super.key,
      required this.isCancelable,
      required this.isPin,
      required this.title,
      required this.msg,
      required this.callBack});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ChangePinPassController controller = Get.put( ChangePinPassController());
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCancelable == true) ...[
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Padding(
                    padding: EdgeInsets.only(top: 5,bottom: 5),
                    child: Icon(Icons.cancel,
                        color: Colors.white, size: 35)))
          ],
          Container(

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: Colors.white),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text("$title!",
                        style: poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 25)),
                  ),
                  heightSpace_30,
                 if (msg.isNotEmpty) ...[
                    Center(
                      child: Text(msg,
                          textAlign: TextAlign.center,
                          style: poppins(
                              color: Colors.red[300]!,
                              fontWeight: FontWeight.w600,
                              fontSize: 12)),
                    ),
                    heightSpace_30,
                  ],
                  if (isPin == true) ...[
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
                              controller.passError.value.isNotEmpty
                                  ? controller.passError.value
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
                    heightSpace_20,
                    Text("Enter PIN Password",
                        textAlign: TextAlign.left,
                        style: poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
                    heightSpace_7,
                    OtpTextField(
                      margin: const EdgeInsets.all(0),
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      numberOfFields: 4,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10)),
                      borderColor: gray_3,
                      focusedBorderColor: gray_3,
                      cursorColor: primaryColor,
                      fieldWidth: (size.width - 110) / 4,
                      textStyle: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500),
                      filled: true,
                      borderWidth: 1,
                      handleControllers: (controllers) => controller
                          .pinControllers.value = controllers,
                      enabledBorderColor:
                      controller.pinError.value.isNotEmpty
                          ? Colors.red
                          : gray_3,
                      fillColor: gray_1,
                      showFieldAsBox: true,
                      onCodeChanged: (value) {
                        if (value.length != 4) {
                          controller.pinValue.value = "";
                        }
                      },
                      onSubmit: (String verificationCode) {
                        controller.pinError.value = "";
                        controller.pinValue.value =
                            verificationCode;
                      }, // end onSubmit
                    ),
                    if (controller.pinError.value.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(controller.pinError.value,
                            textAlign: TextAlign.left,
                            style: poppins(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 10)),
                      ),
                   ],
                    heightSpace_20,
                    Text("Confirm PIN Password",
                        textAlign: TextAlign.left,
                        style: poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
                    heightSpace_7,
                    OtpTextField(
                      margin: const EdgeInsets.all(0),
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      numberOfFields: 4,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10)),
                      borderColor: gray_3,
                      focusedBorderColor: gray_3,
                      cursorColor: primaryColor,
                      fieldWidth: (size.width - 110) / 4,
                      textStyle: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500),
                      filled: true,
                      borderWidth: 1,
                      handleControllers: (controllers) => controller
                          .confPinControllers.value = controllers,
                      enabledBorderColor:
                      controller.confPinError.value.isNotEmpty
                          ? Colors.red
                          : gray_3,
                      fillColor: gray_1,
                      showFieldAsBox: true,
                      onCodeChanged: (value) {
                        if (value.length != 4) {
                          controller.confPinValue.value = "";
                        }
                      },
                      onSubmit: (String verificationCode) {
                        controller.confPinError.value = "";
                        controller.confPinValue.value =
                            verificationCode;
                      }, // end onSubmit
                    ),
                    if (controller.confPinError.value.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(controller.confPinError.value,
                            textAlign: TextAlign.left,
                            style: poppins(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 10)),
                      ),
                    ],
                    heightSpace_30,
                  InkWell(
                    onTap: () async {
                      controller.passError.value = "";
                      controller.pinError.value = "";
                      controller.confPinError.value = "";
                      if (controller.passwordController.text
                          .trim()
                          .isEmpty) {
                        controller.passError.value =
                        "Please enter password.";
                        return;
                      } else if (controller
                          .pinValue.value.length !=
                          4) {
                        controller.pinError.value =
                        "Please enter 4 digit PIN";
                        return;
                      } else if (controller
                          .confPinValue.value.length !=
                          4) {
                        controller.confPinError.value =
                        "Please enter 4 digit PIN again";
                        return;
                      } else if (controller
                          .confPinValue.value !=
                          controller.pinValue.value) {
                        controller.confPinError.value =
                        "Confirm PIN should be same as PIN";
                        return;
                      }

                      controller.changePinPass(true, callBack);
                    },
                    child: Align(
                      alignment: Alignment.center,
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
                  ),
                  ] else ...[
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: TextField(
                            controller: controller.passwordOldController,
                            style: poppins(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            cursorColor: primaryColor,
                            obscureText: controller.passOldVisibility.value,
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
                                      controller.passOldVisibility.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey[400]),
                                  onPressed: () {
                                    controller.passOldVisibility.value = !controller.passOldVisibility.value;
                                  },
                                ),
                                errorText:
                                controller.passOldError.value.isNotEmpty
                                    ? controller.passOldError.value
                                    : null,
                                errorStyle: poppins(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                                hintStyle: poppins(
                                    color: gray_3,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                hintText: "Enter Current Password",
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
                    heightSpace_20,
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: TextField(
                            controller: controller.passwordNewController,
                            style: poppins(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            cursorColor: primaryColor,
                            obscureText: controller.passNewVisibility.value,
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
                                      controller.passNewVisibility.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey[400]),
                                  onPressed: () {
                                    controller.passNewVisibility.value = !controller.passNewVisibility.value;
                                  },
                                ),
                                errorText:
                                controller.passNewError.value.isNotEmpty
                                    ? controller.passNewError.value
                                    : null,
                                errorStyle: poppins(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                                hintStyle: poppins(
                                    color: gray_3,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                hintText: "Enter New Password",
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
                    heightSpace_20,
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: TextField(
                            controller: controller.passwordConfController,
                            style: poppins(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            cursorColor: primaryColor,
                            obscureText: controller.passConfVisibility.value,
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
                                      controller.passConfVisibility.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey[400]),
                                  onPressed: () {
                                    controller.passConfVisibility.value = !controller.passConfVisibility.value;
                                  },
                                ),
                                errorText:
                                controller.passConfError.value.isNotEmpty
                                    ? controller.passConfError.value
                                    : null,
                                errorStyle: poppins(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                                hintStyle: poppins(
                                    color: gray_3,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                hintText: "Enter Confirm Password",
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
                    heightSpace_30,
                    InkWell(
                      onTap: () async {
                        controller.passOldError.value = "";
                        controller.passNewError.value = "";
                        controller.passConfError.value = "";
                        if (controller.passwordOldController.text
                            .trim()
                            .isEmpty) {
                          controller.passOldError.value =
                          "Please enter current password.";
                          return;
                        } else if (controller
                            .passwordNewController.text
                            .trim()
                            .isEmpty) {
                          controller.passNewError.value =
                          "Please enter new password.";
                          return;
                        } else if (controller
                            .passwordOldController.text
                            .trim() ==
                            controller.passwordNewController.text
                                .trim()) {
                          controller.passNewError.value =
                          "New password should be different from old password";
                          return;
                        } else if (controller
                            .passwordConfController.text
                            .trim()
                            .isEmpty) {
                          controller.passConfError.value =
                          "Please enter confirm password.";
                          return;
                        } else if (controller
                            .passwordConfController.text
                            .trim() !=
                            controller.passwordNewController.text
                                .trim()) {
                          controller.passConfError.value =
                          "Confirm password should be same as new password";
                          return;
                        }

                        controller.changePinPass(false, callBack);
                      },
                      child: Align(
                        alignment: Alignment.center,
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
                    ),
                  ]
                ],
              ))),

        ],
      ),
    );
  }
}
