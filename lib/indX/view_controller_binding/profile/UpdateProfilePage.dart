import 'package:control_style/control_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import 'UpdateProfileController.dart';

class UpdateProfilePage extends StatelessWidget {

  UpdateProfileController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return AppBarView(bgColor: gray_1,titleText: "Update Profile", bodyWidget: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Obx(() => Column(
        children: [

          heightSpace_10,
          Container(
            padding: const EdgeInsets.fromLTRB(10,10,10,20),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: primaryColor)
            ),
            child: Column(
              children: [
                Container(
                    color: gray_1,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    transform: Matrix4.translationValues(0, -23, 0),
                    child: Text("Personal Details",style:  poppins(color: primaryColor,fontSize: 16,fontWeight: FontWeight.w700))),
                TextField(
                  controller: controller.nameController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                      border:DecoratedInputBorder(
                          shadow: const [
                            BoxShadow(
                                color: primaryShadowGrey,
                                blurRadius: 2,
                                spreadRadius: 1.0
                            )
                          ],
                          child: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      errorText: controller.nameError.value.isNotEmpty?controller.nameError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Name",
                      fillColor: Colors.white),
                ),
                heightSpace_20,
                TextField(
                  controller: controller.mobileController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                  readOnly: true,
                  cursorColor: primaryColor,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      border:DecoratedInputBorder(
                          shadow: const [
                            BoxShadow(
                                color: primaryShadowGrey,
                                blurRadius: 2,
                                spreadRadius: 1.0
                            )
                          ],
                          child: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      counterText: "",
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      errorText: controller.mobileError.value.isNotEmpty?controller.mobileError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Mobile Number",
                      fillColor: gray_1),
                ),
                heightSpace_20,
                TextField(
                  controller: controller.altMobileController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
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
                                spreadRadius: 1.0
                            )
                          ],
                          child:OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      counterText: "",
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      errorText: controller.altMobileError.value.isNotEmpty?controller.altMobileError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Alternate Mobile Number",
                      fillColor: Colors.white),
                ),
                heightSpace_20,
                TextField(
                  controller: controller.emailController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: primaryColor,
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
                          child:OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      errorText: controller.emailError.value.isNotEmpty?controller.emailError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Email Id",
                      fillColor: Colors.white),
                ),
                heightSpace_20,
                TextField(
                  onTap: () async {
                    await Utility.INSTANCE.openCalender(
                                context,
                                DateTime(2023),
                                DateTime.now(),
                                DateTime.now(), (value) {
                              if (value != null) {
                                controller.dobController.text =
                                    Utility.INSTANCE.formatDate(value);
                              }
                            });
                          },
                          controller: controller.dobController,
                  readOnly: true,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                      border:DecoratedInputBorder(
                          shadow: const [
                            BoxShadow(
                                color: primaryShadowGrey,
                                blurRadius: 2,
                                spreadRadius: 1.0
                            )
                          ],
                          child: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      suffixIcon: Icon(
                        Icons.date_range_outlined,
                        color: Colors.grey[400],
                      ),
                      errorText: controller.dobError.value.isNotEmpty?controller.dobError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Select Date Of Birth",
                      fillColor: Colors.white),
                ),
              ],
            ),
          ),
          heightSpace_30,
          Container(
            padding: const EdgeInsets.fromLTRB(10,10,10,20),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: primaryColor)
            ),
            child: Column(
              children: [
                Container(
                    color: gray_1,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    transform: Matrix4.translationValues(0, -23, 0),
                    child: Text("Address Details",style:  poppins(color: primaryColor,fontSize: 16,fontWeight: FontWeight.w700))),

                TextField(
                  controller: controller.addressController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
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
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      errorText: controller.addressError.value.isNotEmpty?controller.addressError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText:
                      "Enter Address",
                      fillColor: Colors.white),
                ),
                heightSpace_20,
                TextField(
                  controller: controller.landmarkController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
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
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      errorText: controller.landmarkError.value.isNotEmpty?controller.landmarkError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Landmark",
                      fillColor: Colors.white),
                ),
                heightSpace_20,
                TextField(
                  controller: controller.pincodeController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: primaryColor,
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
                          child:OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      counterText: "",
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      errorText: controller.pincodeError.value.isNotEmpty?controller.pincodeError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Pincode",
                      fillColor: Colors.white),
                ),
              ],
            ),
          ),
         //AADHAR PAN Form
         /* heightSpace_30,
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
                    child: Text("KYC Details",style:  poppins(color: grayishBlue,fontSize: 16,fontWeight: FontWeight.w700))),

                TextField(
                  controller: controller.aadharController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: primaryColor,
                  maxLength: 12,
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
                                  child:OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      counterText: "",
                      errorText: controller.aadharError.value.isNotEmpty?controller.aadharError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter AADHAR",
                      fillColor: Colors.white),
                ),
                heightSpace_20,
                TextField(
                  controller: controller.panController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: primaryColor,
                  maxLength: 10,
                  textCapitalization: TextCapitalization.characters,

                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9A-Z]")),
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
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      counterText: "",
                      errorText: controller.panError.value.isNotEmpty?controller.panError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter PAN",
                      fillColor: Colors.white),
                ),

              ],
            ),
          ),*/
         //Bank Form
         /* heightSpace_30,
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
                    child: Text("Bank Details",style:  poppins(color: grayishBlue,fontSize: 16,fontWeight: FontWeight.w700))),
                TextField(
                  onTap: () => Get.toNamed(AppRoutes.bank)!.then((value) {
                    BankData data =value;
                    controller.bankController.text=data.bankName??"";
                    controller.ifscController.text=data.ifsc??"";
                  }),
                  controller: controller.bankController,
                  readOnly: true,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
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
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey[400],
                      ),
                      errorText: controller.bankError.value.isNotEmpty?controller.bankError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Select Bank",
                      fillColor: Colors.white),
                ),
                heightSpace_20,
                TextField(
                  controller: controller.branchController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
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
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      errorText: controller.branchError.value.isNotEmpty?controller.branchError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Branch",
                      fillColor: Colors.white),
                ),
                heightSpace_20,
                TextField(
                  controller: controller.ifscController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                  cursorColor: primaryColor,
                  maxLength: 11,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9A-Z]")),
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
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      counterText: "",
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      errorText: controller.ifscError.value.isNotEmpty?controller.ifscError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter IFSC Code",
                      fillColor: Colors.white),
                ),
                heightSpace_20,
                TextField(
                  controller: controller.acNumController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
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
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      errorText: controller.acNumError.value.isNotEmpty?controller.acNumError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Account Number",
                      fillColor: Colors.white),
                ),
                heightSpace_20,
                TextField(
                  controller: controller.acNameController,
                  style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
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
                        borderRadius:
                        BorderRadius.circular(30.0),
                      )),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      errorText: controller.acNameError.value.isNotEmpty?controller.acNameError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Select Account Name",
                      fillColor: Colors.white),
                ),
              ],
            ),
          ),*/
          //Bank Form
          heightSpace_40,
          InkWell(
            onTap: () =>  controller.updateSubmit(),
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
                ),child: Text("Update Details",
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


  /*String formatDate(DateTime value) {
    return DateFormat("dd MMM yyyy").format(value);
  }*/
}
