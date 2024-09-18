import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../routes/AppRoutes.dart';
import '../../../themes/AppTextTheme.dart';
import '../../../themes/ThemeColor.dart';
import '../../../themes/ThemeHeightWidth.dart';
import '../../../widgets/AppBarView.dart';
import '../../otp/OTPController.dart';
import '../../otp/OTPPage.dart';
import 'AddUpdateBankController.dart';

class AddUpdateBankPage extends StatelessWidget {
  AddUpdateBankController controller = Get.find();

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
                  TextField(
                    onTap: () => Get.toNamed(AppRoutes.bank)!.then((value) {
                      controller.selectedBankData =value;
                      controller.bankController.text=value.bankName??"";
                      controller.ifscController.text=value.ifsc??"";
                    }),
                    controller: controller.bankController,
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
                        errorText: controller.bankError.value.isNotEmpty
                            ? controller.bankError.value
                            : null,
                        errorStyle: poppins(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                        hintStyle: poppins(
                            color: Colors.grey[500]!,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        hintText: "Select Bank",
                        fillColor: Colors.white),
                  ),
                  heightSpace_25,
                  TextField(
                    controller: controller.ifscController,
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
                        contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        errorText: controller.ifscError.value.isNotEmpty
                            ? controller.ifscError.value
                            : null,
                        errorStyle: poppins(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                        hintStyle: poppins(
                            color: Colors.grey[500]!,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        hintText: "Enter IFSC",
                        fillColor: Colors.white),
                  ),
                  heightSpace_3,
                  Align(alignment: Alignment.centerRight,child: Text("Verify IFSC Code Before Save.",style: poppins(fontSize: 12,fontWeight: FontWeight.w500,color: green_1))),
                  heightSpace_25,
                  TextField(
                    controller: controller.acNumController,
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
                        contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        errorText: controller.acNumError.value.isNotEmpty
                            ? controller.acNumError.value
                            : null,
                        errorStyle: poppins(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                        hintStyle: poppins(
                            color: Colors.grey[500]!,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        hintText: "Enter Account Number",
                        fillColor: Colors.white),
                  ),
                  heightSpace_25,
                  TextField(
                    controller: controller.acNameController,
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
                        contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        errorText: controller.acNameError.value.isNotEmpty
                            ? controller.acNameError.value
                            : null,
                        errorStyle: poppins(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                        hintStyle: poppins(
                            color: Colors.grey[500]!,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        hintText: "Enter Account Holder Name",
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
                          text:
                              "Bank Account Should Be With the Name of Company or Director or Proprietor, Third-party Account Will Not Be Approved for Settlement.",
                          style: poppins(
                              color: red_2,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        )
                      ])),
                  heightSpace_20,
                  InkWell(
                    onTap: () => controller.submitBankData((int refId){
                      showOTPDialog(refId);
                    }),
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
                        child: Text("Add Bank Account",
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


  void showOTPDialog(int refId){

    int rid=refId;
    if(Get.isDialogOpen==false) {
      Get.bottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          OTPPage(isGauth: false,callBack: (OTPController controllerOTP,String otp) async {
            if(otp.isNotEmpty&& otp.length==6){
              controller.addBank("Adding Account ...",otp,rid,null);
            }else{
              controller.addBank("Resending OTP ...","",0, (int refId) {
                rid=refId;
                controllerOTP.startTimer();
              });
            }


          }));
    }
  }
}
