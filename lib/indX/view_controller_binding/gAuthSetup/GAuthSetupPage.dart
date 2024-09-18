import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../api/model/support/Google2FAResponse.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import '../../widgets/CachePlaceHolderImage.dart';
import '../otp/OTPController.dart';
import '../otp/OTPPage.dart';
import 'GAuthSetupController.dart';

class GAuthSetupPage extends StatelessWidget {

  GAuthSetupController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return AppBarView(
        titleText: "Google Authenticator",
        bodyWidget: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child:   Obx(() => Column(

            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("Enable authenticator powered by",style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600)),
                  widthSpace_5,
                  SvgPicture.asset("assets/svg/google.svg",height: 20)
                ],
              ),
              heightSpace_15,
              Text("To use an authenticator app go through the following steps :",style: poppins(fontWeight: FontWeight.w600,fontSize: 13,color: gray_3)),
              heightSpace_5,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("1. ",style: poppins(fontWeight: FontWeight.w600,fontSize: 13,color: gray_3)),
                    Expanded(
                      child: RichText(text: TextSpan(
                          text: "Download",
                          style: poppins(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w600,decoration: TextDecoration.underline),
                          children: [
                            TextSpan(text: " Two-Factor Google Authenticator App from here.",
                                style: poppins(fontWeight: FontWeight.w600,fontSize: 13,color: gray_3))
                          ]
                      )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("2. ",style: poppins(fontWeight: FontWeight.w600,fontSize: 13,color: gray_3)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Scan the QR Code or enter this key",style: poppins(fontWeight: FontWeight.w600,fontSize: 13,color: gray_3)),
                          GestureDetector(
                            onTap: () => Utility.INSTANCE.copyText(controller.gAuthResp.value.qrCodeSetupKey??"", "GAuth Key"),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: const BoxDecoration(
                                  color: red_2,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),child: Text(controller.gAuthResp.value.qrCodeSetupKey??"",style: poppins(fontWeight: FontWeight.w600,fontSize: 11,color: Colors.white)),),
                          ),
                          Text("into your Two-Factor Google Authenticator App. Spaces and casing do not matter. Copy key from here.",style: poppins(fontWeight: FontWeight.w600,fontSize: 13,color: gray_3)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              heightSpace_5,
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset("assets/svg/qr_code_area.svg",width: size.width-55,height: size.width-55),
                  CachePlaceHolderImage(imageUrl: "${controller.gAuthResp.value.qrCodeSetupImageUrl}&chld=L|0",
                    errorIconHeight: size.width-80,
                    errorColorBackground: Colors.transparent,
                    imageHeight: size.width-80,
                    imgaeWidth: size.width-80,
                  )
                ],),
              heightSpace_5,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("3. ",style: poppins(fontWeight: FontWeight.w600,fontSize: 13,color: gray_3)),
                    Expanded(
                      child: Text(
                          "Once you have scanned the QR code or input the given key above, your Two-Factor Google Authentication App will provide you a unique code. Enter that code in the verification box below.",
                          style: poppins(fontWeight: FontWeight.w600,fontSize: 13,color: gray_3)),
                    )
                  ],
                ),
              ),

              if(controller.gAuthResp.value.isEnabled==true || controller.gAuthResp.value.alreadyRegistered==true)...[
                GestureDetector(
                  onTap: () =>   controller.sendOTPApi(false, (Google2FAResponse response) {
                    if((response.referenceId??0 )> 0){
                      showGauthOTPDialog(false, response);
                    }else{
                      controller.resetGoogleAuth(false,"",0);
                    }

                  }),
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        color: grayishBlue_alpha_22,
                        borderRadius: BorderRadius.all( Radius.circular(25))
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/google_auth.svg",height: 30,width: 30),
                        widthSpace_10,
                        Expanded(child: Text(controller.gAuthResp.value.isEnabled==true?"Disable GAuth Double Factor":"Enable GAuth Double Factor",style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16))),
                        widthSpace_10,
                        Switch(
                          activeColor: green_2,
                          inactiveTrackColor: Colors.red[300],
                          inactiveThumbColor: Colors.red,
                          value: (controller.gAuthResp.value.isEnabled??false), onChanged: (value) {
                          controller.sendOTPApi(false, (Google2FAResponse response) {
                            if((response.referenceId??0 )> 0){
                              showGauthOTPDialog(false, response);
                            }else{
                              controller.resetGoogleAuth(false,"",0);
                            }

                          });
                        },)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>   controller.sendOTPApi(false, (Google2FAResponse response) {
                    if((response.referenceId??0 )> 0){
                      showGauthOTPDialog(true, response);
                    }else{
                      controller.enableDisableGoogleAuth(false,"",0);
                    }

                  }),
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        color: grayishBlue_alpha_22,
                        borderRadius: BorderRadius.all( Radius.circular(25))
                    ),
                    child: Column(
                      children: [
                        Text("Reset GAuth Double Factor",textAlign: TextAlign.center,style: poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14)),
                        heightSpace_3,
                        Text("Reset GAuth double factor to register new device or change GAuth setup",textAlign: TextAlign.center,
                            style: poppins(color: gray_3,fontWeight: FontWeight.w500,fontSize: 12)),

                      ],
                    ),
                  ),
                )
              ]else...[
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(vertical:  10),
                  decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                          colors: [
                            Color(0xff01a2af),
                            Color(0xff033ca4)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Verification Code",style: poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14)),
                      heightSpace_5,
                      OtpTextField(
                        margin: const EdgeInsets.all(0),
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        numberOfFields: 6,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderColor: Colors.transparent,
                        focusedBorderColor: Colors.transparent,
                        cursorColor: Colors.white,
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500),
                        filled: true,
                        borderWidth: 1,
                        handleControllers: (controllers) => controller.otpControllers.value = controllers,
                        enabledBorderColor: controller.otpError.value.isNotEmpty?Colors.red:Colors.transparent,
                        fillColor: primaryColor_alpha_54,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                        child: Text(controller.otpError.value,
                            textAlign: TextAlign.left,
                            style: poppins(color:Colors.red,fontWeight: FontWeight.w600,fontSize: 12 )),
                      ),
                      heightSpace_5,
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      controller.otpError.value="";
                      if(controller.otpValue.value.length != 6){
                        controller.otpError.value="Please enter valid 6 digit OTP";
                        return;
                      }

                      controller.verifyGAuthSetup(false, controller.gAuthResp.value.accountSecretKey??"", controller.otpValue.value);

                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        minimumSize: const Size(double.infinity, 50)),
                    child: Text("Enable 2FA",
                        style: poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18))),
              ],



            ],



          )),
        ));
  }
  void showGauthOTPDialog(bool isReset,Google2FAResponse response){

    var res=response;
    if(Get.isDialogOpen==false) {
      Get.bottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          OTPPage(callBack: (OTPController controllerOTP,String otp) {
            if(otp.isNotEmpty&& otp.length==6){
              if(isReset==true){
                controller.resetGoogleAuth(true,otp,res.referenceId??0);
              }else{
                controller.enableDisableGoogleAuth(true,otp,res.referenceId??0);
              }
            }else{
              controller.sendOTPApi(true, (Google2FAResponse response) {
                res=response;
                controllerOTP.startTimer();
              });
            }


          }));
    }
  }

}
