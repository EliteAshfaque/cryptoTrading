import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import 'OTPController.dart';

class OTPPage extends StatelessWidget {

  Function? callBack;
  bool? isGauth;

  OTPPage({super.key,this.isGauth, required this.callBack});

  @override
  Widget build(BuildContext context) {

    OTPController controller = Get.put( OTPController());
    if ((isGauth ?? false) == false){
      controller.startTimer();
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(onTap:() {
            Get.back();

          },child: const Padding(
            padding: EdgeInsets.only(top: 5,bottom: 5),
            child: Icon(Icons.cancel,color: Colors.white,size: 35),
          ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: Colors.white),
              child: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(isGauth==true?"TOTP Verification!":"OTP Verification!",
                      style: poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 25)),
                  heightSpace_20,
                  if(isGauth==true)...[
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
                                      fontSize: 12)
                              ),
                              TextSpan(
                                  text: " to verify User Id, please enter it below.",
                                  style: poppins(
                                      color: gray_4,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)
                              )
                            ]
                        )),
                  ]else...[
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
                                    fontSize: 12)
                            ),
                            TextSpan(
                                text: " has been sent on your registered ",
                                style: poppins(
                                    color: gray_4,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)
                            ),
                            TextSpan(
                                text: "Mobile number",
                                style: poppins(
                                    color: gray_4,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12)
                            ),
                            TextSpan(
                                text: " or ",
                                style: poppins(
                                    color: gray_4,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)
                            ),
                            TextSpan(
                                text: "Email id",
                                style: poppins(
                                    color: gray_4,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12)
                            ),
                            TextSpan(
                                text: " to verify mobile number, please enter it below.",
                                style: poppins(
                                    color: gray_4,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)
                            )
                          ]
                      )),],

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
                    handleControllers: (controllers) => controller.otpControllers.value = controllers,
                    enabledBorderColor: controller.otpError.value.isNotEmpty?Colors.red:gray_3,
                    fillColor: gray_1,
                    showFieldAsBox: true,
                    onCodeChanged: (value) {
                      if (value.length != 6) {
                        controller.otpValue.value = "";
                      }
                    },
                    onSubmit: (String verificationCode) {
                      controller.otpError.value="";
                      controller.otpValue.value = verificationCode;
                    }, // end onSubmit
                  ),
                  heightSpace_5,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                        child: Text(controller.otpError.value,
                            textAlign: TextAlign.left,
                            style: poppins(color:Colors.red,fontWeight: FontWeight.w600,fontSize: 12 )),
                      )),

                  heightSpace_20,
                  InkWell(
                    onTap: () async {
                      controller.otpError.value="";
                      if(controller.otpValue.value.length != 6){
                        controller.otpError.value="Please enter valid 6 digit OTP";
                        return;
                      }
                      if(callBack!=null){
                        callBack!(controller,controller.otpValue.value);
                      }

                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(

                        width: double.infinity,
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
                  ),
                  heightSpace_20,
                  if ((isGauth ?? false) == false) ...[
                        if (controller.isOTPTimerStart.value == false)
                          ElevatedButton(
                              onPressed: () async {
                                if (callBack != null) {
                                  callBack!(controller, "");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: primaryColorLight,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  minimumSize: const Size(100, 30)),
                              child: Text("Resend",
                                  style: poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)))
                        else
                          Text("Resend OTP : ${controller.second()} SEC",
                              style: poppins(
                                  color: gray_4,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14))
                      ],
                    ],
              ))),

        ],
      ),
    );
  }
}
