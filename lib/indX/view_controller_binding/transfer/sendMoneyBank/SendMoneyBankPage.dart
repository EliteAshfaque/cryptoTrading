import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../themes/AppTextTheme.dart';
import '../../../themes/ThemeColor.dart';
import '../../../themes/ThemeHeightWidth.dart';
import '../../../utils/Utility.dart';
import '../../../widgets/AppBarView.dart';
import 'SendMoneyBankController.dart';

class SendMoneyBankPage extends StatelessWidget {
  SendMoneyBankController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: "Add Bank Account",
        bodyWidget: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Obx(() => Column(
                children: [
                  heightSpace_20,
                  SvgPicture.asset("assets/svg/logo.svg",height: 60),
                  heightSpace_20,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(15, 14, 15, 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: const [
                        BoxShadow(
                            color: primaryShadowGrey,
                            blurRadius: 2,
                            spreadRadius: 1.0)
                      ],
                    ),
                    child: Text(controller.bankData.accountHolder??"",style: poppins(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                  ),
                  heightSpace_25,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(15, 14, 15, 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: const [
                        BoxShadow(
                            color: primaryShadowGrey,
                            blurRadius: 2,
                            spreadRadius: 1.0)
                      ],
                    ),
                    child: Text(controller.bankData.bankName??"",style: poppins(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                  ),
                  heightSpace_25,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(15, 14, 15, 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: const [
                        BoxShadow(
                            color: primaryShadowGrey,
                            blurRadius: 2,
                            spreadRadius: 1.0)
                      ],
                    ),
                    child: Text(controller.bankData.accountNumber??"",style: poppins(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                  ),
                  heightSpace_25,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(15, 14, 15, 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: const [
                        BoxShadow(
                            color: primaryShadowGrey,
                            blurRadius: 2,
                            spreadRadius: 1.0)
                      ],
                    ),
                    child: Text(controller.bankData.ifsc??"",style: poppins(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                  ),
                  heightSpace_25,
                  TextField(
                    onTap: () => Utility.INSTANCE.showBottomSheet("Select Payment Mode", controller.modeList, false, (String value){
                      controller.modeController.text=value;
                      controller.selectedModeOID=controller.modeOIDList[controller.modeList.indexOf(value)];
                    }),
                    controller: controller.modeController,
                    readOnly: true,
                    maxLines: null,
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
                                  spreadRadius: 1.0)
                            ],
                            child: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                        filled: true,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey[500],
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        errorText: controller.modeError.value.isNotEmpty
                            ? controller.modeError.value
                            : null,
                        errorStyle: poppins(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                        hintStyle: poppins(
                            color: Colors.grey[500]!,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        hintText: "Select Payment Mode",
                        fillColor: Colors.white),
                  ),
                  heightSpace_25,
                  TextField(
                    controller: controller.amountController,
                    style: poppins(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    cursorColor: primaryColor,
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
                                  spreadRadius: 1.0)
                            ],
                            child: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                        filled: true,
                        counterText: "",
                        contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                  heightSpace_40,
                  RichText(
                      text: TextSpan(
                          text: "Note: ",
                          style: poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                          children: [
                        TextSpan(
                          text: "Always make sure your Account Number & IFSC Code is correct. Company will not be liable for any wrong transactions.",
                          style: poppins(
                              color: red_2,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        )
                      ])),
                  heightSpace_20,
                  InkWell(
                    onTap: () {
                      controller.amountError.value = "";
                      if (controller.amountController.text.trim().isEmpty) {
                        controller.amountError.value = "Enter Amount";
                        return;
                      }
                      showConfirmDialog();
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
                                colors: [primaryColorLight, primaryColor],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Text("Send Money",
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


 void showConfirmDialog(){


    if(Get.isDialogOpen==false) {
      Get.bottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(onTap:() {
                  Get.back();

                },
                  child: const Padding(
                  padding: EdgeInsets.only(top: 5,bottom: 5),
                  child: Icon(Icons.cancel,color: Colors.white,size: 35),
                ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        color: Colors.white),
                    child:  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Confirmation!",
                            style: poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 25)),
                        heightSpace_20,

                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "Bank : ",
                                  style: poppins(
                                      color: gray_5,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                  children: [
                                    TextSpan(
                                        text: controller.bankData.bankName??"",
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)
                                    ),
                                    TextSpan(
                                        text: "\nAc Holder : ",
                                        style: poppins(
                                            color: gray_5,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)
                                    ),
                                    TextSpan(
                                        text: controller.bankData.accountHolder??"",
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12)
                                    ),
                                    TextSpan(
                                        text: "\nAc No : ",
                                        style: poppins(
                                            color: gray_5,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)
                                    ),
                                    TextSpan(
                                        text: controller.bankData.accountNumber ?? "",
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12)
                                    ),
                                    TextSpan(
                                        text: "\nIFSC Code : ",
                                        style: poppins(
                                            color: gray_5,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)
                                    ),
                                    TextSpan(
                                        text: controller.bankData.ifsc ?? "",
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12)
                                    ),
                                    TextSpan(
                                        text: "\nPayment Mode : ",
                                        style: poppins(
                                            color: gray_5,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)
                                    ),TextSpan(
                                        text: controller.modeController.text.trim(),
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12)
                                    ),
                                    TextSpan(
                                        text: "\nAmount : ",
                                        style: poppins(
                                            color: gray_5,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13)
                                    ),
                                    TextSpan(
                                        text: Utility.INSTANCE.formatedAmountWithRupees(controller.amountController.text.trim()),
                                        style: poppins(
                                            color: green_2,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)
                                    )
                                  ]
                              )),


                        heightSpace_20,



                        InkWell(
                          onTap: () async {
                            Get.back();
                            controller.submitTransaction();

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
                              ),child: Text("Submit Details",
                                style: poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18)),
                            ),
                          ),
                        ),

                      ],
                    )),

              ],
            ),
          ));
    }
  }
}
