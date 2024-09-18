import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/ConstantString.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import '../../widgets/CachePlaceHolderImage.dart';
import '../pinPassword/ChangePinPass.dart';
import 'ProfileController.dart';

class ProfilePage extends StatelessWidget {
  ProfileController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBarView(
        titleText: "Profile",
        isImageTitle: false,
        bodyWidget: SingleChildScrollView(
          child: Obx(() => Column(
            children: [

                 /* Container(
                    margin: const EdgeInsets.fromLTRB(10,88,10,10),
                    padding: const EdgeInsets.fromLTRB(15,25,15,15),
                    decoration: const BoxDecoration(
                        color: primaryColorLight,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      children: [

                        Expanded(
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "Joining Date\n",
                                  style: poppins(color: lightPurple,fontSize: 13,fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                        text: controller.userDetailResponse.value.userInfo!=null?Utility.INSTANCE.formatedDateWithT(controller.userDetailResponse.value.userInfo!.regDate??""):"-",
                                        style: poppins(color: gray_1,fontSize: 12,fontWeight: FontWeight.w500))
                                  ]
                              )),
                        ),
                        Container(color: primaryColor,width: 1,height: 40,margin: const EdgeInsets.symmetric(horizontal: 10),),
                        Expanded(
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "Activate Date\n",
                                  style: poppins(color: lightPurple,fontSize: 13,fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                        text:  controller.userDetailResponse.value.userInfo!=null?Utility.INSTANCE.formatedDateWithT(controller.userDetailResponse.value.userInfo!.activationDate??""):"-",
                                        style: poppins(color: gray_1,fontSize: 12,fontWeight: FontWeight.w500))
                                  ]
                              )),
                        )

                      ],
                    ),
                  ),*/
                  Container(
                    margin: const EdgeInsets.fromLTRB(10,10,10,0),
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      children: [

                        /*  Stack(
                            alignment: Alignment.bottomRight,
                            children: [*/

                        CachePlaceHolderImage(imageUrl: "$BASE_PROFILE_PIC_URL${controller.loginResponse.data!.userID}.png",
                            imgaeWidth: 50,
                            imageHeight: 50,
                            errorColorBackground: Colors.transparent,
                            errorIconHeight: 50,
                            errorCustomWidget: SvgPicture.asset("assets/svg/user_pic.svg",width: 40,height: 40,)),

                        /* SvgPicture.asset("assets/svg/camera.svg")*/
                        /*]),*/
                        widthSpace_15,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hi, ${controller.userDetailResponse.value.userInfo!=null ?controller.userDetailResponse.value.userInfo!.name??controller.loginResponse.data!.name??"":controller.loginResponse.data!.name??""}!",
                                  maxLines: 1,
                                  style: poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                              /*Container(
                                padding: const EdgeInsets.fromLTRB(10,2,10,2),
                                decoration:  BoxDecoration(
                                    color: (controller.userDetailResponse.value.userInfo!=null && controller.userDetailResponse.value.userInfo!.isTopup==1)?
                                    green_2:
                                    Colors.red[300],
                                    borderRadius: const BorderRadius.all(Radius.circular(5))
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset((controller.userDetailResponse.value.userInfo!=null&&controller.userDetailResponse.value.userInfo!.isTopup==1)?
                                    "assets/svg/verify.svg":
                                    "assets/svg/unverify.svg",width: 14,height: 14),
                                    widthSpace_5,
                                    Flexible(
                                      child: Text(controller.loginResponse.data!=null ?"${(controller.loginResponse.data!.prefix??"").toUpperCase()}${controller.loginResponse.data!.userID??0}":"",
                                          style: poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10)),
                                    ),
                                    if(controller.userDetailResponse.value.userInfo!=null &&
                                        controller.userDetailResponse.value.userInfo!.rank!=null &&
                                        (controller.userDetailResponse.value.userInfo!.rank!.toupAmount??0.0)>0)...[
                                      Container(
                                        transform: Matrix4.translationValues(8, 0, 0),
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          margin: const EdgeInsets.only(left: 5),
                                          decoration:  BoxDecoration(
                                              color: Colors.orange[300],
                                              borderRadius: const BorderRadius.all(Radius.circular(4))
                                          ),
                                          child: Text("Topup : ${Utility.INSTANCE.getCurrencySymbol(controller.userDetailResponse.value.userInfo!.rank!.bussinessCurrSymbol??"")} ${Utility.INSTANCE.formatedAmountWithOutRupees(controller.userDetailResponse.value.userInfo!.rank!.toupAmount??0.0)}",
                                              style: poppins(
                                                  color: primaryColorLight,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10)))
                                    ]


                                  ],
                                ),
                              ),*/
                              if(controller.userDetailResponse.value.userInfo!=null)...[
                                RichText(text: TextSpan(
                                    text: "User Id : ",
                                    style: poppins(
                                        color: gray_5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11),
                                    children: [
                                      TextSpan(
                                          text: "${(controller.loginResponse.data!.prefix??"").toUpperCase()}${controller.loginResponse.data!.userID??0}",
                                          style: poppins(
                                              color: accentColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13)
                                      )
                                    ]
                                ))
                              ],
                              RichText(
                                  maxLines: 1,
                                  text: TextSpan(text: controller.userDetailResponse.value.userInfo!=null ?controller.userDetailResponse.value.userInfo!.emailID??controller.loginResponse.data!.emailID??"":controller.loginResponse.data!.emailID??"",
                                  style: poppins(
                                      color: gray_4,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                  children: [
                                    if(controller.userDetailResponse.value.userInfo!=null && controller.userDetailResponse.value.userInfo!.isEmailVerified==false)
                                      TextSpan(
                                        text: ' Verify',
                                        style: poppins(color: Colors.orange,fontSize: 9,fontWeight: FontWeight.w700),
                                        recognizer: TapGestureRecognizer()..onTap = () {
                                          controller.emailVerify();
                                        },
                                      )
                                  ])),
                            ],
                          ),
                        ),
                        widthSpace_15,
                        InkWell(onTap: () {
                          Utility.INSTANCE.dialogIconThreeButtonWithCallback("logout","Sign Out","Are you sure, want to sign out?","Sign Out","Sign Out From All Device","Cancel",(value) {
                            if(value==1) {
                              controller.logout("1");
                            }else if(value==2) {
                              controller.logout("3");
                            }
                          });
                        },child: SvgPicture.asset("assets/svg/logout.svg"))
                      ],
                    ),
                  ),



              if(controller.userDetailResponse.value.userInfo!=null && (
                  (controller.userDetailResponse.value.userInfo!.address!=null && controller.userDetailResponse.value.userInfo!.address!.isNotEmpty) ||
                      (controller.userDetailResponse.value.userInfo!.pincode!=null && controller.userDetailResponse.value.userInfo!.pincode!.isNotEmpty) ||
                      (controller.userDetailResponse.value.userInfo!.city!=null && controller.userDetailResponse.value.userInfo!.city!.isNotEmpty) ||
                      (controller.userDetailResponse.value.userInfo!.stateName!=null && controller.userDetailResponse.value.userInfo!.stateName!.isNotEmpty)))...[


                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 5),
                  decoration:  BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: primaryColor,width: 1),
                      borderRadius: const BorderRadius.all( Radius.circular(15))
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/svg/address.svg",width: 20),
                          widthSpace_10,
                          Text("ADDRESS",style: poppins(color: primaryColor,fontWeight: FontWeight.w700,fontSize: 15),)
                        ],
                      ),
                      const Divider(color: primaryColor,thickness: 1),
                      if(controller.userDetailResponse.value.userInfo!.pincode!=null && controller.userDetailResponse.value.userInfo!.pincode!.isNotEmpty)...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Pincode : ",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14)),
                            Text(controller.userDetailResponse.value.userInfo!.pincode??"-",style: poppins(color: primaryColorLight,fontWeight: FontWeight.w500,fontSize: 12))
                          ],
                        )
                      ],
                      if(controller.userDetailResponse.value.userInfo!.city!=null && controller.userDetailResponse.value.userInfo!.city!.isNotEmpty)...[
                       heightSpace_5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("City : ",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14)),
                            Text(controller.userDetailResponse.value.userInfo!.city??"-",style: poppins(color: primaryColorLight,fontWeight: FontWeight.w500,fontSize: 12))
                          ],
                        ),
                      ],
                      if(controller.userDetailResponse.value.userInfo!.stateName!=null && controller.userDetailResponse.value.userInfo!.stateName!.isNotEmpty)...[
                        heightSpace_5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("State : ",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14)),
                            Text(controller.userDetailResponse.value.userInfo!.stateName??"-",style: poppins(color: primaryColorLight,fontWeight: FontWeight.w500,fontSize: 12))
                          ],
                        ),
                      ],
                      if(controller.userDetailResponse.value.userInfo!.address!=null && controller.userDetailResponse.value.userInfo!.address!.isNotEmpty)...[
                        heightSpace_5,
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Address : ",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14)),
                          Text(controller.userDetailResponse.value.userInfo!.address??"-",style: poppins(color: primaryColorLight,fontWeight: FontWeight.w500,fontSize: 12))
                        ],
                      )
                      ],
                    ],
                  ),
                )
              ],
              /*if(controller.userDetailResponse.value.userInfo!=null && (
                  (controller.userDetailResponse.value.userInfo!.aadhar!=null && controller.userDetailResponse.value.userInfo!.aadhar!.isNotEmpty) ||
                  (controller.userDetailResponse.value.userInfo!.pan!=null && controller.userDetailResponse.value.userInfo!.pan!.isNotEmpty)))...[
              Container(
                padding: const EdgeInsets.fromLTRB(15,0,15,0 ),
                margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                decoration: const BoxDecoration(
                    color: grayishBlue_alpha_22,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25))
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/kyc.svg",width: 20),
                    widthSpace_10,
                    Text("KYC",style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18)),
                    const Spacer(),
                    kycStatus()
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
                decoration: const BoxDecoration(
                    color: primaryColorLight,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))
                ),
                child: Column(
                  children: [
                    if(controller.userDetailResponse.value.userInfo!.aadhar!=null && controller.userDetailResponse.value.userInfo!.aadhar!.isNotEmpty)...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Aadhar : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w500,fontSize: 14)),
                          Text(controller.userDetailResponse.value.userInfo!.aadhar??"-",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 12))
                        ],
                      )
                    ],
                    if(controller.userDetailResponse.value.userInfo!.pan!=null && controller.userDetailResponse.value.userInfo!.pan!.isNotEmpty)...[
                      const Divider(color: primaryColor,height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Pan : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w500,fontSize: 14)),
                          Text(controller.userDetailResponse.value.userInfo!.pan??"-",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 12))
                      ],
                    )
                    ]
                  ],
                ),
              )
              ],*/
             /* Container(
                padding: const EdgeInsets.all(17),
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: grayishBlue_alpha_22,
                    borderRadius: BorderRadius.all( Radius.circular(25))
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/2fa.svg"),
                    widthSpace_10,
                    Text("Enable Double Factor",style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16)),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios,color: grayishBlue,size: 16)
                  ],
                ),
              ),*/
              GestureDetector(
                onTap: () => ChangePinPass.INSTANCE.showChangePassDialog( "Change Password", "", true, null),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 15),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                              colors: [primaryColorLight, primaryColor],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.all( Radius.circular(30))
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/change_password.svg",width: 30,height: 30,),
                      widthSpace_10,
                      Text("Change Password",style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16)),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.updateProfile),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 15),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [primaryColorLight, primaryColor],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.all( Radius.circular(30))
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/update_profile.svg",width: 30,height: 30,),
                      widthSpace_10,
                      Text("Update Profile"/*& KYC*/,style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16)),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18)
                    ],
                  ),
                ),
              ),
             /* GestureDetector(
                onTap: () =>  Get.toNamed(AppRoutes.recentPinActivity),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 15),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [primaryColorLight, primaryColor],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.all( Radius.circular(30))
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/recent_pin_activity.svg",height: 30,width: 30,),
                      widthSpace_10,
                      Expanded(child: Text("Login Activity",style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16))),
                      widthSpace_10,
                      const Icon(Icons.arrow_forward_ios,color: grayishBlue,size: 18)
                    ],
                  ),
                ),
              ),*/
             /* GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.supportSettings,arguments: (controller.userDetailResponse.value.userInfo!.isGoogle2FAEnable??false).obs),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 15),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [primaryColorLight, primaryColor],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.all( Radius.circular(30))
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/support.svg",width: 30,height: 30),
                      widthSpace_10,
                      Text("Support & Settings",style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16)),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 18)
                    ],
                  ),
                ),
              ),*/
              heightSpace_10,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Terms & Conditions',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Get.toNamed(AppRoutes.tCPP,arguments: ["Terms & Conditions",TERM_CONDITION]);

                      },
                    ),
                    const TextSpan(
                      text: ' | ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.white
                      )
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Get.toNamed(AppRoutes.tCPP,arguments: ["Privacy Policy",PRIVACY_POLICY]);
                      },
                    ),
                  ],
                ),
              ),

              heightSpace_20,

            ],
          )),
        ),
      ),
    );
  }


  Widget kycStatus(){
     if (controller.userDetailResponse.value.userInfo!.kycStatus == 2) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
              color: orange_1,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text("KYC APPLIED",style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12)));

    } else if (controller.userDetailResponse.value.userInfo!.kycStatus == 3) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
              color: green_2,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text("KYC COMPLETED",style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12)));

    } else if (controller.userDetailResponse.value.userInfo!.kycStatus == 4) {
      return Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  color: orange_2,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text("APPLY FOR RE-KYC",style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12))),
          kycApplyBtn("Click here to Re-Apply")
        ],
      );
    } else if (controller.userDetailResponse.value.userInfo!.kycStatus == 5) {
      return Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  color: red_2,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text("KYC REJECTED",style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12))),
          kycApplyBtn("Click here to Re-Apply")
        ],
      );
    }else{
       return Column(
         children: [
           Container(
               padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
               margin: const EdgeInsets.only(top: 10),
               decoration: const BoxDecoration(
                   color: primaryColor,
                   borderRadius: BorderRadius.all(Radius.circular(10))),
               child: Text("APPLY FOR KYC",style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12))),
           kycApplyBtn("Click here to Apply")
         ],
       );
     }
  }

  Widget kycApplyBtn(String txt){
    return  TextButton(onPressed: () {},style: TextButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        child: Text(txt,style: poppins(color: Colors.amber,fontWeight: FontWeight.w500,fontSize: 11)));
  }
}
