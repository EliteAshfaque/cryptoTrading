import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ChangePinPassPage.dart';

enum ChangePinPass {
  INSTANCE;

  /*void showChangePinPassDialog( size,  String title,String msg, bool isCancelable, Function? callBack){
    ChangePinPassController controller= Get.put(ChangePinPassController());
    Get.bottomSheet(
        isScrollControlled: true,
        isDismissible: isCancelable,
        enableDrag: isCancelable,

        WillPopScope(
          onWillPop: () async => isCancelable,
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if(isCancelable==true)...[
                GestureDetector(onTap:() {
                  Get.back();

                },child: SvgPicture.asset("assets/svg/polygon.svg",width: 60,height: 30))
                ],
                Container(
                    margin: const EdgeInsets.fromLTRB(10,29,10,10),
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
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
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text("$title!",
                              style: poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25)),
                        ),
                        Center(
                          child: Container(
                              color: Colors.white,
                              height: 2,
                              width: 230,
                              margin:  EdgeInsets.only(top: 10, bottom: msg.isNotEmpty?15:40)),
                        ),
                        if(msg.isNotEmpty)...[
                          Center(
                            child: Text(msg,
                                textAlign: TextAlign.center,
                                style: poppins(
                                    color: Colors.red[300]!,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12)),
                          ),
                          heightSpace_30
                        ],
                        TextField(
                          controller: controller.passwordController,
                          style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                          cursorColor: Colors.white,
                          obscureText: controller.passVisibility.value,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(controller.passVisibility.value ?Icons.visibility_off:Icons.visibility, color: Colors.grey[400]),
                                onPressed: () {
                                  controller.passVisibility.value = !controller.passVisibility.value;
                                },
                              ),
                              errorText: controller.passError.value.isNotEmpty?controller.passError.value:null,
                              errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                              hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                              hintText: "Enter Password",
                              fillColor: primaryColor_alpha_54),
                        ),
                        heightSpace_20,
                        Text("Enter PIN Password",
                            textAlign: TextAlign.left,
                            style: poppins(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 13 )),
                        heightSpace_7,
                        OtpTextField(
                          margin: const EdgeInsets.all(0),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          numberOfFields: 4,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          borderColor: Colors.transparent,
                          focusedBorderColor: Colors.transparent,
                          cursorColor: Colors.white,
                          fieldWidth: (size.width-110)/4,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500),
                          filled: true,
                          borderWidth: 1,
                          handleControllers: (controllers) => controller.pinControllers.value = controllers,
                          enabledBorderColor: controller.pinError.value.isNotEmpty?Colors.red:Colors.transparent,
                          fillColor: primaryColor_alpha_54,
                          showFieldAsBox: true,
                          onCodeChanged: (value) {
                            if (value.length != 4) {
                              controller.pinValue.value = "";
                            }
                          },
                          onSubmit: (String verificationCode) {
                            controller.pinError.value="";
                            controller.pinValue.value = verificationCode;
                          }, // end onSubmit
                        ),
                        if(controller.pinError.value.isNotEmpty)...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          child: Text(controller.pinError.value,
                              textAlign: TextAlign.left,
                              style: poppins(color:Colors.red,fontWeight: FontWeight.w600,fontSize: 10 )),
                        )],
                        heightSpace_20,
                        Text("Confirm PIN Password",
                            textAlign: TextAlign.left,
                            style: poppins(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 13 )),
                        heightSpace_7,
                        OtpTextField(
                          margin: const EdgeInsets.all(0),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          numberOfFields: 4,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          borderColor: Colors.transparent,
                          focusedBorderColor: Colors.transparent,
                          cursorColor: Colors.white,
                          fieldWidth: (size.width-110)/4,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500),
                          filled: true,
                          borderWidth: 1,
                          handleControllers: (controllers) => controller.confPinControllers.value = controllers,
                          enabledBorderColor: controller.confPinError.value.isNotEmpty?Colors.red:Colors.transparent,
                          fillColor: primaryColor_alpha_54,
                          showFieldAsBox: true,
                          onCodeChanged: (value) {
                            if (value.length != 4) {
                              controller.confPinValue.value = "";
                            }
                          },
                          onSubmit: (String verificationCode) {
                            controller.confPinError.value="";
                            controller.confPinValue.value = verificationCode;
                          }, // end onSubmit
                        ),
                        if(controller.confPinError.value.isNotEmpty)...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Text(controller.confPinError.value,
                                textAlign: TextAlign.left,
                                style: poppins(color:Colors.red,fontWeight: FontWeight.w600,fontSize: 10 )),
                          )
                        ],
                        heightSpace_30,
                        ElevatedButton(
                            onPressed: () async {
                             controller.passError.value="";
                             controller.pinError.value="";
                             controller.confPinError.value="";
                             if(controller.passwordController.text.trim().isEmpty){
                               controller.passError.value="Please enter password.";
                               return;
                             }
                              else if(controller.pinValue.value.length != 4){
                                controller.pinError.value="Please enter 4 digit PIN";
                                return;
                              }else if(controller.confPinValue.value.length != 4){
                                controller.confPinError.value="Please enter 4 digit PIN again";
                                return;
                              }else if(controller.confPinValue.value != controller.pinValue.value){
                                controller.confPinError.value="Confirm PIN should be same as PIN";
                                return;
                              }

                              controller.changePinPass(true,callBack);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                minimumSize: const Size(double.infinity, 50)),
                            child: Text("Submit",
                                style: poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18))),



                      ],
                    ))),
                if(isCancelable==true)...[
                  GestureDetector(onTap:() {
                    Get.back();

                  },child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(top: 5),
                    child: const Icon(Icons.cancel,color: Colors.white,size: 35)
                  )
                  )
                ]

              ],
            ),
          ),
        ));
  }*/

  void showChangePinPassDialog( size,  String title,String msg, bool isCancelable, Function? callBack){

    Get.bottomSheet(
        isScrollControlled: true,
        isDismissible: isCancelable,
        enableDrag: isCancelable,

        WillPopScope(
          onWillPop: () async => isCancelable,
          child: ChangePinPassPage(isPin: true,isCancelable: isCancelable,title: title,msg: msg, callBack: callBack),
        ));
  }

  void showChangePassDialog(  String title,String msg, bool isCancelable, Function? callBack){

    Get.bottomSheet(
        isScrollControlled: true,
        isDismissible: isCancelable,
        enableDrag: isCancelable,

        WillPopScope(
          onWillPop: () async => isCancelable,
          child: ChangePinPassPage(isPin: false,isCancelable: isCancelable,title: title,msg: msg, callBack: callBack),
        ));
  }

  /*void showChangePassDialog(  String title,String msg, bool isCancelable, Function? callBack){
    ChangePinPassController controller= Get.put(ChangePinPassController());
    Get.bottomSheet(
        isScrollControlled: true,
        isDismissible: isCancelable,
        enableDrag: isCancelable,

        WillPopScope(
          onWillPop: () async => isCancelable,
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if(isCancelable==true)...[
                  GestureDetector(onTap:() {
                    Get.back();

                  },child: SvgPicture.asset("assets/svg/polygon.svg",width: 60,height: 30))
                ],
                Container(
                    margin: const EdgeInsets.fromLTRB(10,29,10,10),
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
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
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text("$title!",
                              style: poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25)),
                        ),
                        Center(
                          child: Container(
                              color: Colors.white,
                              height: 2,
                              width: 230,
                              margin:  EdgeInsets.only(top: 10, bottom: msg.isNotEmpty?15:40)),
                        ),
                        if(msg.isNotEmpty)...[
                          Center(
                            child: Text(msg,
                                textAlign: TextAlign.center,
                                style: poppins(
                                    color: Colors.red[300]!,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12)),
                          ),
                          heightSpace_30
                        ],
                        TextField(
                          controller: controller.passwordOldController,
                          style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                          cursorColor: Colors.white,
                          obscureText: controller.passOldVisibility.value,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(controller.passOldVisibility.value ?Icons.visibility_off:Icons.visibility, color: Colors.grey[400]),
                                onPressed: () {
                                  controller.passOldVisibility.value = !controller.passOldVisibility.value;
                                },
                              ),
                              errorText: controller.passOldError.value.isNotEmpty?controller.passOldError.value:null,
                              errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                              hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                              hintText: "Enter Current Password",
                              fillColor: primaryColor_alpha_54),
                        ),
                        heightSpace_20,
                        TextField(
                          controller: controller.passwordNewController,
                          style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                          cursorColor: Colors.white,
                          obscureText: controller.passNewVisibility.value,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(controller.passNewVisibility.value ?Icons.visibility_off:Icons.visibility, color: Colors.grey[400]),
                                onPressed: () {
                                  controller.passNewVisibility.value = !controller.passNewVisibility.value;
                                },
                              ),
                              errorText: controller.passNewError.value.isNotEmpty?controller.passNewError.value:null,
                              errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                              hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                              hintText: "Enter New Password",
                              fillColor: primaryColor_alpha_54),
                        ),
                        heightSpace_20,
                        TextField(
                          controller: controller.passwordConfController,
                          style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                          cursorColor: Colors.white,
                          obscureText: controller.passConfVisibility.value,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(controller.passConfVisibility.value ?Icons.visibility_off:Icons.visibility, color: Colors.grey[400]),
                                onPressed: () {
                                  controller.passConfVisibility.value = !controller.passConfVisibility.value;
                                },
                              ),
                              errorText: controller.passConfError.value.isNotEmpty?controller.passConfError.value:null,
                              errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                              hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                              hintText: "Enter Confirm Password",
                              fillColor: primaryColor_alpha_54),
                        ),
                        heightSpace_30,
                        ElevatedButton(
                            onPressed: () async {
                              controller.passOldError.value="";
                              controller.passNewError.value="";
                              controller.passConfError.value="";
                              if(controller.passwordOldController.text.trim().isEmpty){
                                controller.passOldError.value="Please enter current password.";
                                return;
                              }
                              else if(controller.passwordNewController.text.trim().isEmpty){
                                controller.passNewError.value="Please enter new password.";
                                return;
                              }else if(controller.passwordOldController.text.trim() == controller.passwordNewController.text.trim()){
                                controller.passNewError.value="New password should be different from old password";
                                return;
                              }
                              else if(controller.passwordConfController.text.trim().isEmpty){
                                controller.passConfError.value="Please enter confirm password.";
                                return;
                              }else if(controller.passwordConfController.text.trim() != controller.passwordNewController.text.trim()){
                                controller.passConfError.value="Confirm password should be same as new password";
                                return;
                              }

                              controller.changePinPass(false,callBack);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                minimumSize: const Size(double.infinity, 50)),
                            child: Text("Submit",
                                style: poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18))),



                      ],
                    ))),
                if(isCancelable==true)...[
                  GestureDetector(onTap:() {
                    Get.back();

                  },child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(top: 5),
                      child: const Icon(Icons.cancel,color: Colors.white,size: 35)
                  )
                  )
                ]

              ],
            ),
          ),
        ));
  }*/

}
