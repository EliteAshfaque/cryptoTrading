

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../api/model/BasicResponse.dart';
import '../../api/model/signup/RoleResponse.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../widgets/AppBarView.dart';
import 'AddUserController.dart';

class AddUserPage extends StatelessWidget {

  AddUserController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return AppBarView(titleText: "Add Member", bodyWidget: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Obx(() => Column(
        children: [

          heightSpace_20,

          Container(
            padding: const EdgeInsets.fromLTRB(10,10,10,20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: grayishBlue)
            ),
            child: Column(children: [
              Container(
                color: primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                transform: Matrix4.translationValues(-60, -23, 0),
                  child: Text("Referral Details",style:  poppins(color: grayishBlue,fontSize: 16,fontWeight: FontWeight.w700))),
              TextField(
                controller: controller.referralController,
                readOnly: controller.roleResponse.value.isReferralEditable==false?true:false,
                style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                cursorColor: Colors.white,
                onChanged: (value) {
                  if(value.isEmpty || value!=controller.inputReferrralId){
                    controller.roleResponse.value = RoleResponse();
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                      BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    suffixIcon: controller.roleResponse.value.isReferralEditable==false?
                    Icon(
                      Icons.people_outline,
                      color: Colors.grey[400],
                    ):
                    IconButton(
                      style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap,padding: EdgeInsets.zero),
                      icon: Icon(Icons.search, color: Colors.grey[400]),
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
                    fillColor: grayishBlue_alpha_22),
              ),

              if(controller.roleResponse.value.name!=null && controller.roleResponse.value.name!.isNotEmpty)...[
                heightSpace_15,
                RichText(
                  text: TextSpan(
                    text: 'Referral Name : ',
                    style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: controller.roleResponse.value.name??"",
                        style: poppins(color: lightPurple,fontSize: 14,fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
              if(controller.roleResponse.value.isBinaryon==2)...[
                heightSpace_25,
                Row(
                  children: [
                    Text('Select Position',
                        style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500)),
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
                            style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500)),
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
                            style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500)),
                      ),
                    )
                  ],
                )
              ]
            ]),
          ),
          heightSpace_30,
          Container(
            padding: const EdgeInsets.fromLTRB(10,10,10,20),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: grayishBlue)
            ),
            child: Column(
              children: [
                Container(
                    color: primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    transform: Matrix4.translationValues(-60, -23, 0),
                    child: Text("Personal Details",style:  poppins(color: grayishBlue,fontSize: 16,fontWeight: FontWeight.w700))),
                TextField(
                  controller: controller.nameController,
                  style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      suffixIcon: Icon(
                        Icons.person_outlined,
                        color: Colors.grey[400],
                      ),
                      errorText: controller.nameError.value.isNotEmpty?controller.nameError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Name",
                      fillColor: grayishBlue_alpha_22),
                ),
                heightSpace_25,
                TextField(
                  controller: controller.mobileController,
                  style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: Colors.white,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(10.0),
                      ),
                      counterText: "",
                      filled: true,
                      suffixIcon: Icon(
                        Icons.phone_android_outlined,
                        color: Colors.grey[400],
                      ),
                      errorText: controller.mobileError.value.isNotEmpty?controller.mobileError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Mobile Number",
                      fillColor: grayishBlue_alpha_22),
                ),

                heightSpace_25,
                TextField(
                  controller: controller.emailController,
                  style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      suffixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey[400],
                      ),
                      errorText: controller.emailError.value.isNotEmpty?controller.emailError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Email Id",
                      fillColor: grayishBlue_alpha_22),
                ),
                heightSpace_25,
                TextField(
                  controller: controller.addressController,
                  style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      suffixIcon: Icon(
                        Icons.home_work_outlined,
                        color: Colors.grey[400],
                      ),
                      errorText: controller.addressError.value.isNotEmpty?controller.addressError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText:
                      "Enter Address",
                      fillColor: grayishBlue_alpha_22),
                ),
                heightSpace_25,
                TextField(
                  controller: controller.pincodeController,
                  style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: Colors.white,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(10.0),
                      ),
                      counterText: "",
                      filled: true,
                      suffixIcon: Icon(
                        Icons.pin_drop_outlined,
                        color: Colors.grey[400],
                      ),
                      errorText: controller.pincodeError.value.isNotEmpty?controller.pincodeError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Pincode",
                      fillColor: grayishBlue_alpha_22),
                ),
              ],
            ),
          ),

          heightSpace_40,

          ElevatedButton(
              onPressed: () {
                controller.signup(context,(BasicResponse response){
                  showDetailDialog(response);
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  minimumSize: const Size(double.infinity, 50)),
              child: Text("Add Member",
                  style: poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18))),

        ],
      )),
    ));
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
                      children: [
                        const Icon(Icons.person,color: primaryColorLight,size: 20),
                        widthSpace_10,
                        Text("Login Credential!",
                            style: poppins(
                                color: primaryColorLight,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Get.back(canPop: true,closeOverlays: true);
                            },
                            style: TextButton.styleFrom(backgroundColor: primaryColor,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                            child: Text("Login",style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12)))
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
                            Text(response.userName??"",style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12))
                          ],
                        ),
                        const Divider(color:  Color(0xff033ca4),height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("User Id : ",style: poppins(color: primaryColor,fontWeight: FontWeight.w600,fontSize: 13)),
                            Text(response.userId??"",style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12))
                          ],
                        ),
                        const Divider(color:  Color(0xff033ca4),height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Password : ",style: poppins(color: primaryColor,fontWeight: FontWeight.w600,fontSize: 13)),
                            Text(response.password??"",style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12))
                          ],
                        ),
                      ],
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
                    *//* border: Border.all(color: Colors.white),*//*
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: const Icon(Icons.close,color: Colors.white,),
              ),*/
        ],
      ),
    ));
  }
}
