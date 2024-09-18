
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../api/model/BasicResponse.dart';
import '../../api/model/support/Google2FAResponse.dart';
import '../../common/ConstantString.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import '../otp/OTPController.dart';
import '../otp/OTPPage.dart';
import '../pinPassword/ChangePinPass.dart';
import 'SupportSettingController.dart';

class SupportSettingPage extends StatelessWidget {

  SupportSettingController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: AppBarView(
        titleText: "Support & Settings",
        isImageTitle: false,
        bodyWidget: SingleChildScrollView(
          child: Obx(() => Column(
            children: [
              GestureDetector(
                onTap: () => controller.change2FA(!controller.is2FAEnable.value,false, "", "",(BasicResponse response){
                  showOTPDialog(!controller.is2FAEnable.value,response);
                }),
                child: Container(
                  padding: const EdgeInsets.all(17),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: grayishBlue_alpha_22,
                      borderRadius: BorderRadius.all( Radius.circular(25))
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/2fa.svg",height: 30,width: 30,),
                      widthSpace_10,
                      Expanded(child: Text(controller.is2FAEnable.value?"Disable Double Factor":"Enable Double Factor",style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16))),
                      widthSpace_10,
                       Switch(
                         activeColor: green_2,
                         inactiveTrackColor: Colors.red[300],
                         inactiveThumbColor: Colors.red,

                         value: controller.is2FAEnable.value, onChanged: (value) {
                           controller.change2FA(value,false, "", "",(BasicResponse response){
                             showOTPDialog(value,response);
                           });

                      },)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>  controller.sendOTPApi(false,(Google2FAResponse response){
                  showGauthOTPDialog(response);
                }),
                child: Container(
                  padding: const EdgeInsets.all(17),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: grayishBlue_alpha_22,
                      borderRadius: BorderRadius.all( Radius.circular(25))
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/google_auth.svg",height: 30,width: 30,),
                      widthSpace_10,
                      Expanded(child: Text(controller.isGoogle2FAEnable.value?"Disable GAuth Double Factor":"Enable GAuth Double Factor",style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16))),
                      widthSpace_10,
                      Switch(
                        activeColor: green_2,
                        inactiveTrackColor: Colors.red[300],
                        inactiveThumbColor: Colors.red,

                        value: controller.isGoogle2FAEnable.value, onChanged: (value) {

                       controller.sendOTPApi(false,(Google2FAResponse response){
                         showGauthOTPDialog(response);
                        });

                      },)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showCallMeDialog(),
                child: Container(
                  padding: const EdgeInsets.all(17),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: grayishBlue_alpha_22,
                      borderRadius: BorderRadius.all( Radius.circular(25))
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/call_me_rqst.svg",height: 30,width: 30,),
                      widthSpace_10,
                      Expanded(child: Text("Call Me Request",style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16))),
                      widthSpace_10,
                      const Icon(Icons.arrow_forward_ios,color: grayishBlue,size: 18)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => ChangePinPass.INSTANCE.showChangePinPassDialog(size, "Change PIN Password", "", true, () async {
                    if(controller.storage.hasData(PIN_SET)==false){
                      await controller.storage.write(PIN_SET, true);
                    }
                }),
                child: Container(
                  padding: const EdgeInsets.all(17),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: grayishBlue_alpha_22,
                      borderRadius: BorderRadius.all( Radius.circular(25))
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/change_pin_password.svg",height: 30,width: 30,),
                      widthSpace_10,
                      Expanded(child: Text("Change PIN Password",style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16))),
                      widthSpace_10,
                      const Icon(Icons.arrow_forward_ios,color: grayishBlue,size: 18)
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () =>  Get.toNamed(AppRoutes.inviteReferral),
                child: Container(
                  padding: const EdgeInsets.all(17),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: grayishBlue_alpha_22,
                      borderRadius: BorderRadius.all( Radius.circular(25))
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/refer_earn.svg",height: 30,width: 30,),
                      widthSpace_10,
                      Expanded(child: Text("Invite & Earn",style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16))),
                      widthSpace_10,
                      const Icon(Icons.arrow_forward_ios,color: grayishBlue,size: 18)
                    ],
                  ),
                ),
              ),

              if(controller.companyData.value.customerCareMobileNos!=null && controller.companyData.value.customerCareMobileNos!.isNotEmpty||
                  controller.companyData.value.customerPhoneNos!=null && controller.companyData.value.customerPhoneNos!.isNotEmpty||
                  controller.companyData.value.customerCareEmailIds!=null && controller.companyData.value.customerCareEmailIds!.isNotEmpty||
                  controller.companyData.value.customerWhatsAppNos!=null && controller.companyData.value.customerWhatsAppNos!.isNotEmpty)...[
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: primaryColorLight,
                      borderRadius: BorderRadius.all( Radius.circular(25))
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15,right: 10,top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Customer Care",
                                        style: poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    heightSpace_10,
                                    if (controller.companyData.value.customerCareMobileNos != null && controller.companyData.value.customerCareMobileNos!.isNotEmpty ||
                                        controller.companyData.value.customerPhoneNos != null && controller.companyData.value.customerPhoneNos!.isNotEmpty) ...[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset("assets/svg/contacts_call.svg"),
                                          widthSpace_10,
                                          Expanded(
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: listWidget(controller.companyData.value.customerCareMobileNos ?? "", controller.companyData.value.customerPhoneNos ?? "", 1),
                                            ),
                                          )
                                        ],
                                      ),
                                      heightSpace_15
                                    ],
                                    if (controller.companyData.value.customerWhatsAppNos != null && controller.companyData.value.customerWhatsAppNos!.isNotEmpty) ...[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset("assets/svg/contacts_whatsapp.svg"),
                                          widthSpace_10,
                                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: listWidget(controller.companyData.value.customerWhatsAppNos ?? "", "", 2)))
                                        ],
                                      ),
                                      heightSpace_15,
                                    ],
                                    if (controller.companyData.value.customerCareEmailIds != null && controller.companyData.value.customerCareEmailIds!.isNotEmpty) ...[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset("assets/svg/contacts_mail.svg"),
                                          widthSpace_10,
                                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: listWidget(controller.companyData.value.customerCareEmailIds ?? "", "", 3)))
                                        ],
                                      ),
                                      heightSpace_15,
                                    ]
                                  ],
                                ),
                              ),
                            ),
                            Container(
                          width: 70,
                          height: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff01a2af),
                                  Color(0xff033ca4)
                                ]),
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(25)),
                          ),
                          child: SvgPicture.asset("assets/svg/contacts_customer_care.svg",fit: BoxFit.fitWidth),
                        )
                      ],
                    ),
                  ),
                )
              ],
              if(controller.companyData.value.accountMobileNo!=null && controller.companyData.value.accountMobileNo!.isNotEmpty||
                  controller.companyData.value.accountPhoneNos!=null && controller.companyData.value.accountPhoneNos!.isNotEmpty||
                  controller.companyData.value.accountEmailId!=null && controller.companyData.value.accountEmailId!.isNotEmpty||
                  controller.companyData.value.accountWhatsAppNos!=null && controller.companyData.value.accountWhatsAppNos!.isNotEmpty)...[
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: primaryColorLight,
                      borderRadius: BorderRadius.all( Radius.circular(25))
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 10,top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Payment Enquiry",
                                    style: poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                heightSpace_10,
                                if (controller.companyData.value.accountMobileNo != null && controller.companyData.value.accountMobileNo!.isNotEmpty ||
                                    controller.companyData.value.accountPhoneNos != null && controller.companyData.value.accountPhoneNos!.isNotEmpty) ...[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset("assets/svg/contacts_call.svg"),
                                      widthSpace_10,
                                      Expanded(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: listWidget(controller.companyData.value.accountMobileNo ?? "", controller.companyData.value.accountPhoneNos ?? "", 1),
                                        ),
                                      )
                                    ],
                                  ),
                                  heightSpace_15
                                ],
                                if (controller.companyData.value.accountWhatsAppNos != null && controller.companyData.value.accountWhatsAppNos!.isNotEmpty) ...[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset("assets/svg/contacts_whatsapp.svg"),
                                      widthSpace_10,
                                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: listWidget(controller.companyData.value.accountWhatsAppNos ?? "", "", 2)))
                                    ],
                                  ),
                                  heightSpace_15,
                                ],
                                if (controller.companyData.value.accountEmailId != null && controller.companyData.value.accountEmailId!.isNotEmpty) ...[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset("assets/svg/contacts_mail.svg"),
                                      widthSpace_10,
                                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: listWidget(controller.companyData.value.accountEmailId ?? "", "", 3)))
                                    ],
                                  ),
                                  heightSpace_15,
                                ]
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff01a2af),
                                  Color(0xff033ca4)
                                ]),
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(25)),
                          ),
                          child: SvgPicture.asset("assets/svg/contacts_payment_enq.svg",fit: BoxFit.fitWidth),
                        )
                      ],
                    ),
                  ),
                )
              ],

              if(controller.companyData.value.facebook!=null && controller.companyData.value.facebook!.isNotEmpty && controller.companyData.value.facebook!.isURL||
              controller.companyData.value.instagram!=null && controller.companyData.value.instagram!.isNotEmpty && controller.companyData.value.instagram!.isURL||
              controller.companyData.value.whatsApp!=null && controller.companyData.value.whatsApp!.isNotEmpty && controller.companyData.value.whatsApp!.isURL||
              controller.companyData.value.twitter!=null && controller.companyData.value.twitter!.isNotEmpty && controller.companyData.value.twitter!.isURL||
              controller.companyData.value.telegram!=null && controller.companyData.value.telegram!.isNotEmpty && controller.companyData.value.telegram!.isURL)...[
                Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
                decoration: const BoxDecoration(
                    color: grayishBlue_alpha_22,
                    borderRadius: BorderRadius.vertical(top:  Radius.circular(25))
                ),
                child: Text("Social Media",style: poppins(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700)),
              ),
                Container(

                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
                decoration: const BoxDecoration(
                    color: primaryColorLight,
                    borderRadius: BorderRadius.vertical(bottom:   Radius.circular(25))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(controller.companyData.value.facebook!=null && controller.companyData.value.facebook!.isNotEmpty && controller.companyData.value.facebook!.isURL)
                    InkWell(
                      onTap: () => Utility.INSTANCE.urlLaunch(controller.companyData.value.facebook??""),
                      child: Column(children: [
                        SvgPicture.asset("assets/svg/facebook.svg",height: 55,width: 55),
                        heightSpace_10,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                          decoration: const BoxDecoration(color: primaryColor,borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Text("Follow",style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500)),
                        )
                      ]),
                    ),
                    if(controller.companyData.value.instagram!=null && controller.companyData.value.instagram!.isNotEmpty && controller.companyData.value.instagram!.isURL)
                    InkWell(
                      onTap: () => Utility.INSTANCE.urlLaunch(controller.companyData.value.instagram??""),
                      child: Column(children: [
                        SvgPicture.asset("assets/svg/instagram.svg",height: 55,width: 55),
                        heightSpace_10,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                          decoration: const BoxDecoration(color: primaryColor,borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Text("Follow",style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500)),
                        )
                      ]),
                    ),
                    if(controller.companyData.value.telegram!=null && controller.companyData.value.telegram!.isNotEmpty && controller.companyData.value.telegram!.isURL)
                    InkWell(
                      onTap: () => Utility.INSTANCE.urlLaunch(controller.companyData.value.telegram??""),
                      child: Column(children: [
                        SvgPicture.asset("assets/svg/telegram.svg",height: 55,width: 55),
                        heightSpace_10,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                          decoration: const BoxDecoration(color: primaryColor,borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Text("Follow",style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500)),
                        )
                      ]),
                    ),
                    if(controller.companyData.value.whatsApp!=null && controller.companyData.value.whatsApp!.isNotEmpty && controller.companyData.value.whatsApp!.isURL)
                    InkWell(
                      onTap: () => Utility.INSTANCE.urlLaunch(controller.companyData.value.whatsApp??""),
                      child: Column(children: [
                        SvgPicture.asset("assets/svg/whatsapp.svg",height: 55,width: 55),
                        heightSpace_10,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                          decoration: const BoxDecoration(color: primaryColor,borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Text("Follow",style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500)),
                        )
                      ]),
                    ),
                    if(controller.companyData.value.twitter!=null && controller.companyData.value.twitter!.isNotEmpty && controller.companyData.value.twitter!.isURL)
                    InkWell(
                      onTap: () => Utility.INSTANCE.urlLaunch(controller.companyData.value.twitter??""),
                      child: Column(children: [
                        SvgPicture.asset("assets/svg/twitter.svg",height: 55,width: 55),
                        heightSpace_10,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                          decoration: const BoxDecoration(color: primaryColor,borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Text("Follow",style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500)),
                        )
                      ]),
                    )
                  ],
                ),
              )
              ],
              if(controller.companyData.value.website!=null && controller.companyData.value.website!.isNotEmpty && controller.companyData.value.website!.isURL||
              controller.companyData.value.address!=null && controller.companyData.value.address!.isNotEmpty )...[
                Container(
                      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        children: [
                          if (controller.companyData.value.website != null && controller.companyData.value.website!.isNotEmpty && controller.companyData.value.website!.isURL) ...[
                            InkWell(
                              onTap: () => Utility.INSTANCE.urlLaunch(controller.companyData.value.website??""),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(children: [
                                  SvgPicture.asset("assets/svg/website.svg", height: 40, width: 40),
                                  widthSpace_10,
                                  Text("Open Website",
                                      style: poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500))
                                ]),
                              ),
                            )
                          ],
                          if(controller.companyData.value.address!=null && controller.companyData.value.address!.isNotEmpty)...[
                            Row(children: [
                              SvgPicture.asset("assets/svg/contacts_address.svg",
                                  height: 40, width: 40),
                              widthSpace_10,
                              Expanded(
                                child: Text(controller.companyData.value.address??"",
                                    style: poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              )
                            ]),
                            heightSpace_15
                          ]

                        ],
                      ),
                    )
              ],



              heightSpace_20,

            ],
          )),
        ),
      ),
    );
  }

  List <Widget> listWidget(String first, String second, int type) {
   /* type =1 call;
    type =2 whatsapp;
    type =3 email;*/
    var list = controller.stringToList(first, second);
    return List.generate(list.length, (index) {
      var item =list[index];
      return InkWell(
        onTap: () {
          if(type==1){
            Utility.INSTANCE.urlLaunch("tel:$item");
          }else if(type==2){
            Utility.INSTANCE.urlLaunch("https://api.whatsapp.com/send?phone=$item");
          }else{
            Utility.INSTANCE.urlLaunch("mailto:$item");
          }
        } ,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(item,style: poppins(fontWeight: FontWeight.w500,fontSize: 14,color: grayishBlue)),
        ),
      );
    });
  }


  void showOTPDialog(bool is2FA, BasicResponse response){

    var res=response;
    if(Get.isDialogOpen==false) {
      Get.bottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          OTPPage(callBack: (OTPController controllerOTP,String otp) {
            controller.change2FA(is2FA,true, otp, res.refID ?? "", (BasicResponse response) {
              res=response;
              controllerOTP.startTimer();
            });
          }));
    }
  }

  void showGauthOTPDialog(Google2FAResponse response){

    var res=response;
    if(Get.isDialogOpen==false) {
      Get.bottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          OTPPage(callBack: (OTPController controllerOTP,String otp) {
            if(otp.isNotEmpty&& otp.length==6){
              controller.getGoogleAuthData(true,otp, res.referenceId??0, (Google2FAResponse response) {
                Get.toNamed(AppRoutes.gAuthSetup,arguments:[controller.isGoogle2FAEnable,response.obs] );
              });
            }else{
              controller.sendOTPApi(true, (Google2FAResponse response) {
                res=response;
                controllerOTP.startTimer();
              });
            }


          }));
    }
  }


void showCallMeDialog(){
  controller.callMeMobController.text="";
    Get.bottomSheet(
        isScrollControlled: true,
        SingleChildScrollView(
          child: Column(
           mainAxisSize: MainAxisSize.min,
            children: [
              Container(

                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                      color: Colors.white),
                  child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text("Call Me Request!",
                            style: poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 25)),
                      ),
                     heightSpace_20,

                      Center(
                        child: Text("Send call me request with your mobile number our support team will contact you soon",
                            textAlign: TextAlign.center,
                            style: poppins(
                                color: gray_4,
                                fontWeight: FontWeight.w600,
                                fontSize: 12)),
                      ),
                      heightSpace_30,
                      TextField(
                        controller: controller.callMeMobController,
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
                            filled: true,
                            counterText: "",
                            errorText: controller.callMeMobError.value.isNotEmpty?controller.callMeMobError.value:null,
                            errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                            hintStyle: poppins(color: Colors.grey[400]!,fontSize: 14,fontWeight: FontWeight.w500),
                            hintText: "Enter Mobile Number",
                            fillColor: primaryColor_alpha_54),
                      ),

                      heightSpace_30,
                      ElevatedButton(
                          onPressed: () async {
                            controller.callMeMobError.value="";
                            if(controller.callMeMobController.text.trim().length!=10){
                              controller.callMeMobError.value="Please enter valid 10 digit mobile number.";
                              return;
                            }
                            Get.back();
                            controller.callMeRqst();
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

                GestureDetector(onTap:() {
                  Get.back();

                },child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(top: 5),
                    child: const Icon(Icons.cancel,color: Colors.white,size: 35)
                )
                )

            ],
          ),
        ));
  }
}
