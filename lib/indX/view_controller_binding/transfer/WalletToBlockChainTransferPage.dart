
import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../api/model/activateUser/ActivateUserResponse.dart';
import '../../api/model/balance/AllowedWalletToCrypto.dart';
import '../../api/model/support/Google2FAResponse.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import '../../widgets/CachePlaceHolderImage.dart';
import '../otp/OTPController.dart';
import '../otp/OTPPage.dart';
import '../qrScanner/QRScannerPage.dart';
import 'WalletToBlockChainTransferController.dart';

class WalletToBlockChainTransferPage extends StatelessWidget {

  WalletToBlockChainTransferController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    if(controller.dashboardController.displayBalCryptoList.isEmpty){
      controller.dashboardController.currencyList(false,null);
    }
    return AppBarView(
        titleText: "Withdrawal",
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
                          children: List.generate(controller.dashboardController.balanceResponse.value.balanceData!.length, (index) {
                            var item =controller.dashboardController.balanceResponse.value.balanceData![index];

                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration( color: grayishBlue_alpha_55,borderRadius: BorderRadius.all(Radius.circular(7))),
                              width:controller.dashboardController.balanceResponse.value.balanceData!.length%2==0?(size.width-57)/2:
                              index==(controller.dashboardController.balanceResponse.value.balanceData!.length-1)?(size.width-52):(size.width-57)/2,
                              child: RichText(textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: item.walletType??"",
                                      style: poppins(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white),
                                      children: [
                                        TextSpan(
                                            text: "\n${Utility.INSTANCE.getCurrencySymbol(item.walletCurrencySymbol??"\$")} ${item.balance??""}",
                                            style: poppins(fontSize: 12,fontWeight: FontWeight.w600,color: primaryColor)
                                        )


                                      ]
                                  )),
                            );
                          }),
                        ),
                        heightSpace_5,
                        ElevatedButton(
                            onPressed: () =>  Get.toNamed(AppRoutes.walletCryptoWithdrawalReport,arguments: [controller.balanceData.id??0,false]),
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
                  Text("From Wallet",
                      style: poppins(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  heightSpace_5,
                  Container(width:double.infinity,
                      padding: const EdgeInsets.fromLTRB(20,14,14,14),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: const BoxDecoration(
                          color: primaryColorMoreLight,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Text(controller.balanceData.walletType??"", style: poppins(color: primaryColorDark,fontWeight: FontWeight.w600,fontSize: 14))),
                          Container(
                              width: 33,
                              height: 33,
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.all(Radius.circular(25))
                              ),
                              child: SvgPicture.asset("assets/svg/note.svg"))
                        ],
                      )),
                    Text("Amount (${Utility.INSTANCE.getCurrencySymbol(controller.balanceData.walletCurrencySymbol??"")})",
                        style: poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    heightSpace_5,
                    Focus(
                      onFocusChange: (value) => controller.isAmountFocused.value=value,
                      child: TextField(
                        controller: controller.amountController,
                        onChanged: (value) {
                          if (controller.isAmountFocused.value == true) {
                            if (value.trim().isNotEmpty) {

                              controller.inputAmount.value = double.parse(value.trim());
                              controller.convertedAmount.value = controller.inputAmount.value / (controller.liveRateResponse.value.liveRate ?? 0);
                              if (controller.convertedAmount.value.isNaN || controller.convertedAmount.value.isInfinite) {controller.convertAmountController.text = "";
                              } else {
                                controller.convertAmountController.text = Utility.INSTANCE.formatedAmountNinePlace(controller.convertedAmount.value);
                              }
                            } else {
                              controller.convertAmountController.text = "";
                              controller.convertedAmount.value = 0;
                            }
                          }
                        },
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
                    ),

                  if(controller.balanceData.allowedWalletToCripto!=null && controller.balanceData.allowedWalletToCripto!.length>1)...[
                    heightSpace_20,
                    Text("To Coin",
                        style: poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    heightSpace_5,
                    TextField(
                      onTap: () => Utility.INSTANCE.showBottomSheet<AllowedWalletToCrypto>("Select Coin", controller.balanceData.allowedWalletToCripto!,false,(AllowedWalletToCrypto value){
                        controller.selectedCoin.value = value;
                        controller.coinController.text=value.symbolName??"";
                        if(controller.selectedCoin.value.isdoubbleFactor==false){
                          controller.otpType.value=0;
                        }else{
                          controller.otpType.value=1;
                        }
                        controller.getLiveRate(value.symbolId??0, controller.balanceData.walletCurrencyID??0);
                      }),
                      controller: controller.coinController,
                      readOnly: true,
                      style: poppins(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      cursorColor: primaryColor,
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
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey[500],
                          ),
                          errorText: controller.coinError.value.isNotEmpty
                              ? controller.coinError.value
                              : null,
                          errorStyle: poppins(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                          hintStyle: poppins(
                              color: Colors.grey[500]!,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          hintText: "Select Coin",
                          fillColor: Colors.white),
                    ),
                  ],
                  if(controller.selectedCoin.value.symbolId!=controller.balanceData.walletCurrencyID)...[
                        heightSpace_20,
                        Row(
                          children: [
                            Text("Convert Amount (${Utility.INSTANCE.getCurrencySymbol(controller.selectedCoin.value.symbolName??"")})",
                                style: poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                            const Spacer(),
                            Text("1 ",
                                style: poppins(
                                    color: primaryColorLight,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            CachePlaceHolderImage(imageUrl: controller.selectedCoin.value.image??"",
                                imageHeight: 14,
                                imgaeWidth: 14,
                                errorColorBackground: Colors.transparent,
                                errorIconHeight: 14),
                            Text(" = ${Utility.INSTANCE.getCurrencySymbol(controller.balanceData.walletCurrencySymbol??"")} ${Utility.INSTANCE.formatedAmountWithOutRupees(controller.liveRateResponse.value.liveRate??0.0)}",
                                style: poppins(
                                    color: primaryColorLight,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        heightSpace_5,
                        Focus(
                          onFocusChange: (value) => controller.isConvertAmountFocused.value=value,
                          child: TextField(
                            controller: controller.convertAmountController,
                            onChanged: (value) {
                              if(controller.isConvertAmountFocused.value==true) {
                                if (value.trim().isNotEmpty) {
                                  controller.convertedAmount.value = double.parse(value.trim());
                                  controller.inputAmount.value = (controller.liveRateResponse.value.liveRate ?? 0) * controller.convertedAmount.value;
                                  controller.amountController.text = Utility.INSTANCE.formatedAmountNinePlace(controller.inputAmount.value);
                                } else {
                                  controller.amountController.text = "";
                                  controller.inputAmount.value = 0;
                                }
                              }
                            },
                            style: poppins(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            cursorColor: primaryColor,
                            keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
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
                                errorText:
                                controller.convertAmountError.value.isNotEmpty
                                    ? controller.convertAmountError.value
                                    : null,
                                errorStyle: poppins(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                                hintStyle: poppins(
                                    color: Colors.grey[500]!,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                hintText: "Enter Convert Amount",
                                fillColor: Colors.white),
                          ),
                        ),
                      ],
                  if(controller.selectedCoin.value.isExternalAddress==true)...[
                    heightSpace_20,
                    Text("Wallet Address",
                        style: poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    heightSpace_5,
                    TextField(
                      controller: controller.addressController,
                      readOnly: (controller.dashboardController.balanceResponse.value.externalAddress??"").isNotEmpty?true:false,
                      style: poppins(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      cursorColor: primaryColor,
                      maxLength: 42,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
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
                          suffixIcon: (controller.dashboardController.balanceResponse.value.externalAddress??"").isNotEmpty? null:
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: accentColor,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: const Size(50, 40),
                                  padding: EdgeInsets.zero),
                              child:
                              const Icon(Icons.qr_code_scanner, color: Colors.black),
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
                  ],
                  if (controller.selectedCoin.value.isdoubbleFactor == true) ...[
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
                    heightSpace_40,
                  InkWell(
                    onTap: () async {

                      controller.amountError.value = "";
                      controller.addressError.value = "";

                      if (controller.amountController.text.trim().isEmpty) {
                        controller.amountError.value = "Please Enter Amount";
                        return;
                      } else if (controller.selectedCoin.value.isExternalAddress==true && controller.addressController.text.trim().isEmpty) {
                        controller.addressError.value = "Please enter valid address";
                        return;
                      }else if (controller.selectedCoin.value.isExternalAddress==true && controller.addressController.text.trim().length!=42) {
                        controller.addressError.value = "Please enter valid 42 character address";
                        return;
                      }

                      if(controller.otpType.value==1){

                        controller.sendOTPApi(false, (Google2FAResponse response) async {
                          if((response.referenceId??0 )> 0){
                            showOTPDialog(false, response);
                          }else{
                            await controller.transferApi(false,"",0,(ActivateUserResponse response){
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
                      }
                      else if(controller.otpType.value==2){
                        showGauthTOTPDialog();
                      }
                      else{
                        await controller.transferApi(false,"",0,(ActivateUserResponse response){
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
                await controller.transferApi(true,otp, res.referenceId??0,(ActivateUserResponse response){
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
              await controller.transferApi(true,otp, 0,(ActivateUserResponse response){
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
