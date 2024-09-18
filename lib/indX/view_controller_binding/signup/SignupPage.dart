import 'package:control_style/control_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../api/model/BasicResponse.dart';
import '../../api/model/signup/RoleResponse.dart';
import '../../common/ConstantString.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import 'SignupController.dart';

class SignupPage extends StatelessWidget {

  SignupController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(

            child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heightSpace_20,
                  SvgPicture.asset("assets/svg/logo.svg",
                      width: 170),
                  heightSpace_5,
                  Text("Welcome Back !",
                      style: poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24)),
                  Text("Create your account",
                      style: poppins(
                          color: gray_4,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                  Padding(
                    padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
                    child: TextField(
                      controller: controller.referralController,
                      readOnly: controller.roleResponse.value.isReferralEditable==false?true:false,
                      style: poppins(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        if(value.isEmpty || value!=controller.inputReferrralId){
                          controller.roleResponse.value = RoleResponse();
                        }
                      },
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
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        prefixIcon:const Icon(
                          Icons.people_outline,
                          color: primaryColorLight,
                        ),
                          suffixIcon: controller.roleResponse.value.isReferralEditable==false? null: IconButton(
                            style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap,padding: EdgeInsets.zero),
                            icon: const Icon(Icons.search, color: gray_4),
                            onPressed: () {
                              controller.referralError.value="";
                              if(controller.referralController.text.trim().isEmpty){
                                controller.referralError.value="Enter Referral Id.";
                                return;
                              }
                              controller.role(context, controller.referralController.text.trim());
                            },
                          ),
                          errorText: controller.referralError.value.isNotEmpty?controller.referralError.value:null,
                          errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                          hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                          hintText: "Enter Referral Id",
                          fillColor: Colors.white),
                    ),
                  ),

                  if(controller.roleResponse.value.name!=null && controller.roleResponse.value.name!.isNotEmpty)...[
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
                      child: RichText(
                        text: TextSpan(
                          text: 'Referral Name : ',
                          style: poppins(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: controller.roleResponse.value.name??"",
                              style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                if(controller.roleResponse.value.isBinaryon==2)...[
                    heightSpace_20,
                    Row(
                      children: [
                        widthSpace_20,
                        Text('Select Position',
                            style: poppins(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => controller.leg.value="L",
                          child: Container(
                            width: 70,
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            alignment: Alignment.center,
                            decoration:  BoxDecoration(
                                color: controller.leg.value=="L"?primaryColor:Colors.transparent,
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: primaryColor,width: 1)
                            ),
                            child: Text('Left',
                                style: poppins(color: controller.leg.value=="L"?Colors.white:Colors.black,fontSize: 14,fontWeight: FontWeight.w500)),
                          ),
                        ),
                        widthSpace_10,
                        GestureDetector(
                          onTap: () => controller.leg.value="R",
                          child: Container(
                            width: 70,
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            alignment: Alignment.center,
                            decoration:  BoxDecoration(
                                color: controller.leg.value=="R"?primaryColor:Colors.transparent,
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: primaryColor,width: 1)
                            ),
                            child: Text('Right',
                                style: poppins(color: controller.leg.value=="R"?Colors.white:Colors.black,fontSize: 14,fontWeight: FontWeight.w500)),
                          ),
                        ),
                        widthSpace_20
                      ],
                    )
                     ],

                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                    child: TextField(
                      controller: controller.nameController,
                      style: poppins(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),
                      cursorColor: Colors.black,
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
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          prefixIcon: const Icon(
                            Icons.person_outlined,
                            color: primaryColorLight,
                          ),
                          errorText: controller.nameError.value.isNotEmpty?controller.nameError.value:null,
                          errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                          hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                          hintText: "Enter Name",
                          fillColor: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                    child: TextField(
                      controller: controller.mobileController,
                      style: poppins(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600),
                      cursorColor: Colors.black,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
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
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          prefixIcon: const Icon(
                            Icons.phone_android_outlined,
                            color: primaryColorLight,
                          ),
                          errorText: controller.mobileError.value.isNotEmpty?controller.mobileError.value:null,
                          errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                          hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                          hintText: "Enter Mobile Number",
                          fillColor: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                    child: TextField(
                      controller: controller.emailController,
                      style: poppins(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
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
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: primaryColorLight,
                          ),
                          errorText: controller.emailError.value.isNotEmpty?controller.emailError.value:null,
                          errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                          hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                          hintText: "Enter Email Id",
                          fillColor: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                    child: TextField(
                      controller: controller.addressController,
                      style: poppins(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),
                      cursorColor: Colors.black,
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
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          prefixIcon: const Icon(
                            Icons.home_work_outlined,
                            color: primaryColorLight,
                          ),
                          errorText: controller.addressError.value.isNotEmpty?controller.addressError.value:null,
                          errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                          hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                          hintText:
                          "Enter Address",
                          fillColor: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                    child: TextField(
                      controller: controller.pincodeController,
                      style: poppins(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),
                      cursorColor: Colors.black,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
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
                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          prefixIcon: const Icon(
                            Icons.pin_drop_outlined,
                            color: primaryColorLight,
                          ),
                          errorText: controller.pincodeError.value.isNotEmpty?controller.pincodeError.value:null,
                          errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                          hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                          hintText: "Enter Pincode",
                          fillColor: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:20,top:15,right:20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'You agree with our ',
                        style: poppins(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: accentColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Get.toNamed(AppRoutes.tCPP,arguments: ["Terms & Conditions",TERM_CONDITION]);
                            },
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: accentColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Get.toNamed(AppRoutes.tCPP,arguments: ["Privacy Policy",PRIVACY_POLICY]);
                            },
                          ),
                          const TextSpan(text: ' by tapping Sign Up button'),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        controller.signup(context,(BasicResponse response){
                          showDetailDialog(response);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20,right: 20,top: 15),
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
                          ),
                        child: Text("Sign Up",
                            style: poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18)),
                      )),
                  heightSpace_10,
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SvgPicture.asset("assets/svg/signup_bg.svg",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                            width: 70,
                            height: 70,
                            margin: const EdgeInsets.only(top: 35),
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
                                BorderRadius.all(Radius.circular(40))),
                            child: const Icon(
                              size: 35,
                              Icons.close,
                              color: primaryColorLight,
                            )),
                      ),
                      Positioned(
                       bottom: 25,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'have an account?\n',
                            style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                text: 'Login here',
                                style:  poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: accentColor,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  Get.back();
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ])),
          ),
        ),
      ),
    );
  }

  void showDetailDialog(BasicResponse response){
    Get.dialog(Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(onTap:() =>  Get.back(),child:  Container(
            padding: const EdgeInsets.only(top: 5),
            color: Colors.transparent,
            child: const Icon(Icons.cancel,color: Colors.white,size: 35),
          ) ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Registration\n",
                          style: poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                          children: [
                            TextSpan(
                                text: "Complete",
                                style: poppins(
                                    color: green_2,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20))
                          ])),
                  heightSpace_10,
                  Text("Welcome, Your account has been created successfully.",
                      textAlign: TextAlign.center,
                      style: poppins(
                          color: gray_4,
                          fontWeight: FontWeight.w600,
                          fontSize: 12)),
                  heightSpace_20,
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: grayishBlue,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.person,color: primaryColorMoreLight,size: 20),
                        widthSpace_10,
                        Text("Login Credential!",
                            style: poppins(
                                color: primaryColorMoreLight,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),

                      ],
                    ) ,
                  ),
                  Container(
                   margin: const EdgeInsets.only(top: 2,bottom: 15),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                    decoration: const BoxDecoration(
                        color: grayishBlue_alpha_55,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Your Name : ",style: poppins(color: primaryColor,fontWeight: FontWeight.w600,fontSize: 13)),
                            Text(response.userName??"",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12))
                          ],
                        ),
                        const Divider(color:  Color(0xff033ca4),height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("User Id : ",style: poppins(color: primaryColor,fontWeight: FontWeight.w600,fontSize: 13)),
                            Text(response.userId??"",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12))
                          ],
                        ),
                        const Divider(color:  Color(0xff033ca4),height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Password : ",style: poppins(color: primaryColor,fontWeight: FontWeight.w600,fontSize: 13)),
                            Text(response.password??"",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12))
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if(controller.isFromLogin==true){
                        Get.back(closeOverlays: true,canPop: true);
                      }else{
                        Get.back();
                        Get.offNamed(AppRoutes.login,preventDuplicates: false);
                      }

                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
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
                      ),
                      child: Text("Login",
                          style: poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                  ),
                  Text("We have sent you an email & message containing your login details.",
                      textAlign: TextAlign.center,
                      style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12)),

                  heightSpace_10,
                  Text("Please keep credential safe.",
                      textAlign: TextAlign.center,
                      style: poppins(color: primaryColorLight,fontWeight: FontWeight.w500,fontSize: 12))
                ],
              )),


          /* Container(
                width: 50,
                height: 50,
                alignment: Alignment.topCenter,
                *//*padding: EdgeInsets.only(bottom: 60),*//*
                decoration:  const BoxDecoration(
                    color: Color(0xff00BFCE),
                    *//* border: Border.all(color: Colors.black),*//*
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: const Icon(Icons.close,color: Colors.black,),
              ),*/
        ],
      ),
    ));
  }
}
