
import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../api/model/activateUser/ActivateUserResponse.dart';
import '../../api/model/support/Google2FAResponse.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import '../otp/OTPController.dart';
import '../otp/OTPPage.dart';
import '../qrScanner/QRScannerPage.dart';
import 'CryptoTransferController.dart';

class CryptoTransferPage extends StatelessWidget {

  CryptoTransferController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    if(controller.dashboardController.displayBalCryptoList.isEmpty){
      controller.dashboardController.currencyList(false,null);
    }
    return AppBarView(
        titleText: "Transfer",
        bodyWidget: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10,top: 15),
                decoration:  BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: primaryColor,width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Text("Balance",style: poppins(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black)),
                    heightSpace_5,
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: List.generate(controller.cryptoBalanceList.length, (index) {
                        var item =controller.cryptoBalanceList[index];
                        if(item.isBalanceFromDB==false && !controller.dashboardController.currencyBalanceMap.containsKey(item.id??0)){
                          controller.dashboardController.getCryptoBalanceApi(item.id??0,true,false);
                        }
                        return Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: const BoxDecoration( color: grayishBlue_alpha_55,borderRadius: BorderRadius.all(Radius.circular(7))),
                          alignment: Alignment.center,
                          width: controller.cryptoBalanceList.length%2==0?(size.width-57)/2:
                          index==(controller.cryptoBalanceList.length-1)?(size.width-52):(size.width-57)/2,
                          child: RichText(textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: item.currencyName??"",
                                  style: poppins(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white),
                                  children: [
                                    if(item.isBalanceFromDB==true)...[
                                      TextSpan(
                                          text: "\n${Utility.INSTANCE.formatedAmountNinePlace(item.balance??0.0)}",
                                          style: poppins(fontSize: 12,fontWeight: FontWeight.w500,color: primaryColorDark)
                                      )
                                    ]else...[
                                      TextSpan(
                                          text: "\n${controller.dashboardController.currencyBalanceMap.containsKey(item.id??0)?
                                          controller.dashboardController.currencyBalanceMap[item.id??0]!.balance??"":"0"}",
                                          style: poppins(fontSize: 12,fontWeight: FontWeight.w500,color: primaryColorDark)
                                      ),
                                      TextSpan(
                                          text: "\n\$${controller.dashboardController.currencyBalanceMap.containsKey(item.id??0)?
                                          Utility.INSTANCE.formatedAmountNinePlace(controller.dashboardController.currencyBalanceMap[item.id??0]!.balanceInUSDT??0):"0"}",
                                          style: poppins(fontSize: 10,fontWeight: FontWeight.w500,color: primaryColor)
                                      )
                                    ],

                                  ]
                              )),
                        );
                      }),
                    ),
                    heightSpace_5,
                    ElevatedButton(
                        onPressed: () =>  Get.toNamed(AppRoutes.walletCryptoWithdrawalReport,arguments: [controller.currencyItem.id??0,true]),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)))),
                        child: Text("View Withdrawal History",
                            style: poppins(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w600)))
                  ],
                ),
              ),
              Text("Wallet Address",
                  style: poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
              heightSpace_5,
              TextField(
                controller: controller.addressController,
                style: poppins(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                cursorColor: primaryColor,
                /* maxLength: 42,*/
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                minLines: 1,
                decoration: InputDecoration(
                    border: DecoratedInputBorder(
                        shadow: const [
                          BoxShadow(
                              color: primaryShadowGrey,
                              blurRadius: 2,
                              spreadRadius: 1.0
                          )
                        ],
                        child:OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30),
                        )),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    filled: true,
                    counterText: "",

                    suffixIcon:  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(30))),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: const Size(50, 40),
                            padding: EdgeInsets.zero),
                        child:
                        const Icon(Icons.qr_code_scanner, color: Colors.white),
                        onPressed: () {
                          Get.to(const QRScannerPage())!.then((value) => controller.addressController.text=value);

                        },
                      ),
                    ),
                    errorText: controller.addressError.value.isNotEmpty
                        ? controller.addressError.value
                        : null,
                    errorStyle: poppins(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                    hintStyle: poppins(
                        color: Colors.grey[500]!,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    hintText: "Enter Wallet Address",
                    fillColor: Colors.white),
              ),
              heightSpace_25,
              Text("Amount",
                  style: poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
              heightSpace_5,
              TextField(
                controller: controller.amountController,
                style: poppins(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                cursorColor: primaryColor,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    final text = newValue.text;
                    return text.isEmpty
                        ? newValue
                        : double.tryParse(text) == null
                        ? oldValue
                        : newValue;
                  }),
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
                        child:OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30),
                        )),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    filled: true,
                    errorText: controller.amountError.value.isNotEmpty
                        ? controller.amountError.value
                        : null,
                    errorStyle: poppins(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                    hintStyle: poppins(
                        color: Colors.grey[500]!,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    hintText: "Enter Amount",
                    fillColor: Colors.white),
              ),
              if (controller.loginResponse.data!.isDoubleFactor == true) ...[
                heightSpace_25,
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.otpType.value = 1;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: controller.otpType.value == 1
                                  ? primaryColor
                                  : grayishBlue_alpha_55,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10))),
                          child: Text("OTP",
                              style: poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14)),
                        ),
                      ),
                    ),
                    widthSpace_20,
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if(controller.dashboardController.balanceResponse.value.isGoogle2FAEnable==true){
                            controller.otpType.value = 2;
                          }else{
                            Utility.INSTANCE.dialogIconTwoButtonWithCallback("error_exclamation", "", "Your Google Authenticator is not enable", "Enable", "Cancel", (value){
                              if(value==1){
                                controller.sendOTPApi(false, (Google2FAResponse response) {
                                  if((response.referenceId??0 )> 0){
                                    showOTPDialog(true, response);
                                  }else{
                                    controller.getGoogleAuthData(false,"", 0, (Google2FAResponse response) {
                                      Get.toNamed(AppRoutes.gAuthSetup,arguments:[false.obs,response.obs] )!.then((value) {
                                        if(value==true){
                                          controller.otpType.value=2;
                                          controller.dashboardController.balanceResponse.value.isGoogle2FAEnable=true;
                                          controller.dashboardController.balanceResponse.value.isGoogle2FARegister=true;
                                        }
                                      });
                                    });
                                  }

                                });
                              }
                            });
                          }

                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: controller.otpType.value == 2
                                  ? primaryColor
                                  : grayishBlue_alpha_55,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10))),
                          child: Text("Google TOTP",
                              style: poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14)),
                        ),
                      ),
                    )
                  ],
                ),
              ],
              heightSpace_35,
              InkWell(
                onTap: () async {

                  controller.addressError.value = "";
                  controller.amountError.value = "";

                  if (controller.addressController.text.trim().isEmpty) {
                    controller.addressError.value = "Please enter valid address";
                    return;
                  }else if (controller.addressController.text.trim().length<20) {
                    controller.addressError.value = "Please enter valid address";
                    return;
                  } else if (controller.amountController.text.trim().isEmpty) {
                    controller.amountError.value = "Please enter amount";
                    return;
                  }

                  if(controller.otpType.value==1){

                    controller.sendOTPApi(false, (Google2FAResponse response) async {
                      if((response.referenceId??0 )> 0){
                        showOTPDialog(false, response);
                      }else{
                        await controller.transfer(false,"",0,(ActivateUserResponse response){
                          Utility.INSTANCE.dialogIconTwoButtonWithCallback("error_exclamation", "", response.msg??"Your Google Authenticator is not register", "Register", "Cancel", (value){
                            if(value==1){
                              controller.sendOTPApi(false, (Google2FAResponse response) {
                                if((response.referenceId??0 )> 0){
                                  showOTPDialog(true, response);
                                }else{
                                  controller.getGoogleAuthData(false,"", 0, (Google2FAResponse response) {
                                    Get.toNamed(AppRoutes.gAuthSetup,arguments:[false.obs,response.obs] )!.then((value) {
                                      if(value==true){
                                        /*controller.otpType.value=2;*/
                                        controller.dashboardController.balanceResponse.value.isGoogle2FAEnable=true;
                                        controller.dashboardController.balanceResponse.value.isGoogle2FARegister=true;
                                      }
                                    });
                                  });
                                }

                              });
                            }
                          });
                        });
                      }

                    });
                  }else if(controller.otpType.value==2){
                    showGauthTOTPDialog();
                  }else{
                    await controller.transfer(false,"",0,(ActivateUserResponse response){
                      Utility.INSTANCE.dialogIconTwoButtonWithCallback("error_exclamation", "", response.msg??"Your Google Authenticator is not register", "Register", "Cancel", (value){
                        if(value==1){
                          controller.sendOTPApi(false, (Google2FAResponse response) {
                            if((response.referenceId??0 )> 0){
                              showOTPDialog(true, response);
                            }else{
                              controller.getGoogleAuthData(false,"", 0, (Google2FAResponse response) {
                                Get.toNamed(AppRoutes.gAuthSetup,arguments:[false.obs,response.obs] )!.then((value) {
                                  if(value==true){
                                    /*controller.otpType.value=2;*/
                                    controller.dashboardController.balanceResponse.value.isGoogle2FAEnable=true;
                                    controller.dashboardController.balanceResponse.value.isGoogle2FARegister=true;
                                  }
                                });
                              });
                            }

                          });
                        }
                      });
                    });
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
                    ),child: Text("Submit",
                      style: poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                  ),
                ),
              )
            ],

          )),
        ));
  }

  void showOTPDialog(bool isGAuth,Google2FAResponse response){

    var res=response;
    if(Get.isDialogOpen==false) {
      Get.bottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          OTPPage(isGauth: false,callBack: (OTPController controllerOTP,String otp) async {
            if(otp.isNotEmpty&& otp.length==6){
              if(isGAuth==true){
                await controller.getGoogleAuthData(true,otp, res.referenceId??0, (Google2FAResponse response) {
                  Get.toNamed(AppRoutes.gAuthSetup,arguments:[false.obs,response.obs] )!.then((value) {
                    if(value==true){
                      controller.otpType.value=2;
                      controller.dashboardController.balanceResponse.value.isGoogle2FAEnable=true;
                      controller.dashboardController.balanceResponse.value.isGoogle2FARegister=true;
                    }
                  });
                });
              }else{
                await controller.transfer(true,otp, res.referenceId??0,(ActivateUserResponse response){
                  Utility.INSTANCE.dialogIconTwoButtonWithCallback("error_exclamation", "", response.msg??"Your Google Authenticator is not register", "Register", "Cancel", (value){
                    if(value==1){
                      controller.sendOTPApi(false, (Google2FAResponse response) {
                        if((response.referenceId??0 )> 0){
                          showOTPDialog(true, response);
                        }else{
                          controller.getGoogleAuthData(false,"", 0, (Google2FAResponse response) {
                            Get.toNamed(AppRoutes.gAuthSetup,arguments:[false.obs,response.obs] )!.then((value) {
                              if(value==true){
                                controller.otpType.value=2;
                                controller.dashboardController.balanceResponse.value.isGoogle2FAEnable=true;
                                controller.dashboardController.balanceResponse.value.isGoogle2FARegister=true;
                              }
                            });
                          });
                        }

                      });
                    }
                  });
                });
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

  void showGauthTOTPDialog(){


    if(Get.isDialogOpen==false) {
      Get.bottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          OTPPage(isGauth: true,callBack: (OTPController controllerOTP,String otp) async {
            if(otp.isNotEmpty&& otp.length==6){
                await controller.transfer(true,otp, 0,(ActivateUserResponse response){
                  Utility.INSTANCE.dialogIconTwoButtonWithCallback("error_exclamation", "", response.msg??"Your Google Authenticator is not register", "Register", "Cancel", (value){
                    if(value==1){
                      controller.sendOTPApi(false, (Google2FAResponse response) {
                        if((response.referenceId??0 )> 0){
                          showOTPDialog(true, response);
                        }else{
                          controller.getGoogleAuthData(false,"", 0, (Google2FAResponse response) {
                            Get.toNamed(AppRoutes.gAuthSetup,arguments:[false.obs,response.obs] )!.then((value) {
                              if(value==true){
                               /* controller.otpType.value=2;*/
                                controller.dashboardController.balanceResponse.value.isGoogle2FAEnable=true;
                                controller.dashboardController.balanceResponse.value.isGoogle2FARegister=true;
                              }
                            });
                          });
                        }

                      });
                    }
                  });
                });

            }


          }));
    }
  }
}
