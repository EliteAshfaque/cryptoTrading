

import 'dart:io';

import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../api/model/balance/BalanceData.dart';
import '../../api/model/fundRequest/Bank.dart';
import '../../api/model/fundRequest/PaymentMode.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import 'FundRequestController.dart';

class FundRequestPage extends StatelessWidget {

  FundRequestController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return AppBarView(titleText: "Deposit", bodyWidget: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Obx(() => Column(
        children: [

          heightSpace_10,

          if(controller.balanceWithFundProcessList.length>1)...[
            TextField(
              onTap: () => Utility.INSTANCE.showBottomSheet("Select Wallet", controller.balanceWithFundProcessList, false, (BalanceData item){

                if(controller.selectedWallet.value!=item) {
                  controller.selectedWallet.value = item;
                  controller.walletController.text=item.walletType??"";
                }
              }),
              controller: controller.walletController,
              style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
              cursorColor: primaryColor,
              readOnly: true,
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
                    Icons.arrow_drop_down,
                    color: Colors.grey[500],
                  ),
                  errorText: controller.walletError.value.isNotEmpty?controller.walletError.value:null,
                  errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                  hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                  hintText: "Select Wallet",
                  fillColor: Colors.white),
            ),
            heightSpace_20
          ],

         /* TextField(
            controller: controller.rqstToController,
            style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
            readOnly: true,
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
                  Icons.arrow_drop_down,
                  color: Colors.grey[500],
                ),
                errorText: controller.rqstToError.value.isNotEmpty?controller.rqstToError.value:null,
                errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                hintText: "Select Request To",
                fillColor: Colors.white),
          ),
          heightSpace_20,*/
          TextField(
            onTap: () => Utility.INSTANCE.showBottomSheet("Select Bank", controller.bankModeList, false, (Bank item){
              controller.setBank(item);
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
                  color: Colors.grey[500],
                ),
                errorText: controller.bankError.value.isNotEmpty?controller.bankError.value:null,
                errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                hintText: "Select Bank",
                fillColor: Colors.white),
          ),
          heightSpace_20,
          TextField(
            controller: controller.acNumController,
            style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
            cursorColor: primaryColor,
            readOnly: true,
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
          if((controller.selectedBank.value.ifscCode??"").trim().isNotEmpty)...[
            heightSpace_3,
          Align(
            alignment: Alignment.centerRight,
            child: Text("IFSC Code : ${controller.selectedBank.value.ifscCode??""}",
              style: poppins(color: primaryColorDark,fontSize: 14,fontWeight: FontWeight.w500),),
          )],
          heightSpace_20,
          TextField(
            controller: controller.acNameController,
            style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
            cursorColor: primaryColor,
            readOnly: true,
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
                hintText: "Enter Account Name",
                fillColor: Colors.white),
          ),

          /*if((controller.selectedBank.value.branchName??"").trim().isNotEmpty)...[
            heightSpace_20,
            TextField(
              controller: controller.branchNameController,
              style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
              cursorColor: primaryColor,
              readOnly: true,
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
                  errorText: controller.branchNameError.value.isNotEmpty?controller.branchNameError.value:null,
                  errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                  hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                  hintText: "Enter Branch Name",
                  fillColor: Colors.white),
            )
          ],*/
          /*if((controller.selectedBank.value.ifscCode??"").trim().isNotEmpty)...[
            heightSpace_20,
            TextField(
              controller: controller.ifscController,
              style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
              cursorColor: primaryColor,
              readOnly: true,
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
                  errorText: controller.ifscError.value.isNotEmpty?controller.ifscError.value:null,
                  errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                  hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                  hintText: "Enter IFSC Code",
                  fillColor: Colors.white),
            )
          ],*/
          heightSpace_20,
          TextField(
            onTap: () => Utility.INSTANCE.showBottomSheet("Select Mode", controller.selectedBank.value.mode!, false, (PaymentMode item){
              controller.setMode(item);
            }),
            controller: controller.modeController,
            style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
            cursorColor: primaryColor,
            readOnly: true,
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
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[500],
                ),
                errorText: controller.modeError.value.isNotEmpty?controller.modeError.value:null,
                errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                hintText: "Select Payment Mode",
                fillColor: Colors.white),
          ),
          heightSpace_20,
          TextField(
            controller: controller.amountController,
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
                filled: true,
                counterText: "",
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                errorText: controller.amountError.value.isNotEmpty?controller.amountError.value:null,
                errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                hintText: "Enter Amount",
                fillColor: Colors.white),
          ),
          if((controller.selectedMode.value.isAccountHolderRequired??false)==true)...[
            heightSpace_20,
            TextField(
              controller: controller.acHolderNameController,
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
                  errorText: controller.acHolderNameError.value.isNotEmpty?controller.acHolderNameError.value:null,
                  errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                  hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                  hintText: "Enter Account Holder Name",
                  fillColor: Colors.white),
            )
          ],
          if((controller.selectedMode.value.isTransactionIdAuto??false)==false)...[
                heightSpace_20,
                TextField(
                  controller: controller.txnIdController,
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
                      errorText: controller.txnIdError.value.isNotEmpty?controller.txnIdError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter Bank UTR/RRN",
                      fillColor: Colors.white),
                )
          ],

                if((controller.selectedMode.value.isChequeNoRequired??false)==true)...[
                  heightSpace_20,
                  TextField(
                    controller: controller.chequeNoController,
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
                        errorText: controller.chequeNoError.value.isNotEmpty?controller.chequeNoError.value:null,
                        errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                        hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                        hintText: "Enter Cheque Number",
                        fillColor: Colors.white),
                  )
                ],
                if ((controller.selectedMode.value.isCardNumberRequired ?? false) == true)...[
                  heightSpace_20,
                  TextField(
                    controller: controller.cardNoController,
                    style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                    cursorColor: primaryColor,
                    maxLength: 16,
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
                        errorText: controller.cardNoError.value.isNotEmpty?controller.cardNoError.value:null,
                        errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                        hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                        hintText: "Enter Card Number",
                        fillColor: Colors.white),
                  )
                ],
              if ((controller.selectedMode.value.isBranchRequired ?? false) == true)...[
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
                      hintText: "Enter Branch Name",
                      fillColor: Colors.white),
                )
              ],
              if ((controller.selectedMode.value.isUPIID ?? false) == true)...[
                heightSpace_20,
                TextField(
                  controller: controller.upiController,
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
                      errorText: controller.upiError.value.isNotEmpty?controller.upiError.value:null,
                      errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                      hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                      hintText: "Enter UPI Id",
                      fillColor: Colors.white),
                )
              ],
                if ((controller.selectedMode.value.isMobileNoRequired ?? false) == true)...[
                  heightSpace_20,
                  TextField(
                    controller: controller.mobileController,
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
                        errorText: controller.mobileError.value.isNotEmpty?controller.mobileError.value:null,
                        errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                        hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                        hintText: "Enter Mobile Number",
                        fillColor: Colors.white),
                  )
                ],
          heightSpace_20,
          GestureDetector(
            onTap: () => pickImage(),
            child: Container(
              width: double.infinity,
              height: 170,
              padding:  EdgeInsets.fromLTRB(15,15,15,controller.selectedImage.value.path.isNotEmpty?10:15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: primaryShadowGrey,
                      blurRadius: 2,
                      spreadRadius: 1.0
                  )
                ]
              ),
              child: Column(
                children: [
                  Text("Choose Image",style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500)),
                  heightSpace_5,
                  Expanded(child: controller.selectedImage.value.path.isNotEmpty?Image.file(controller.selectedImage.value):const Icon(Icons.image,size:50,color: gray_4)),
                  if(controller.selectedImage.value.path.isNotEmpty)...[
                  TextButton(onPressed: () => controller.selectedImage.value=File(""),
                      style: TextButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap,visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity)),
                      child: Text("Remove",style: poppins(color: red_2,fontSize: 11,fontWeight: FontWeight.w500)))],
                ],
              ),
            ),
          ),
          heightSpace_40,
          InkWell(
            onTap: () =>  controller.submit(),
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


  pickImage(){
    Get.bottomSheet(
        isScrollControlled: true,

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Padding(
                    padding: EdgeInsets.only(top: 5,bottom: 5),
                    child: Icon(Icons.cancel,
                        color: Colors.white, size: 35))),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 15, right: 15,top: 30,bottom: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Select Type",
                          style: poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20)),
                      heightSpace_25,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {
                              if(await Permission.camera.isGranted==false){
                                await Permission.camera.request().then((value) {
                                  if(value.isDenied){
                                    Utility.INSTANCE.bottomSheetIconTwoButtonWithCallback("camera","Permission Required","Please Allow camera permission for your app. If you deny permissions will not be able to use functionality of this app.","Setting","Cancel",(value) async {
                                      if(value==1){
                                        openAppSettings();
                                      }
                                    });
                                  }
                                  else if(value.isPermanentlyDenied){
                                    Utility.INSTANCE.bottomSheetIconTwoButtonWithCallback("camera","Permission Required","Please Allow camera permission for your app. If you deny permissions will not be able to use functionality of this app.","Setting","Cancel",(value) async {
                                      if(value==1){
                                        openAppSettings();
                                      }
                                    });
                                  }else{
                                    Get.back();
                                    controller.pickImage(ImageSource.camera);
                                  }
                                });
                              }else{
                                Get.back();
                                controller.pickImage(ImageSource.camera);
                              }

                            },
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Icon(Icons.camera_alt,size: 60),
                                ),
                                heightSpace_5,
                                Text("Camera",style: poppins(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 14),)
                              ],

                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if(Platform.isIOS ){
                                if(await Permission.photos.isGranted==false){
                                  await Permission.photos.request().then((value) {
                                    if(value.isDenied){
                                      Utility.INSTANCE.bottomSheetIconTwoButtonWithCallback("photo","Permission Required","Please Allow photos permission for your app. If you deny permissions will not be able to use functionality of this app.","Setting","Cancel",(value) async {
                                        if(value==1){
                                          openAppSettings();
                                        }
                                      });
                                    }
                                    else if(value.isPermanentlyDenied){
                                      Utility.INSTANCE.bottomSheetIconTwoButtonWithCallback("photo","Permission Required","Please Allow photos permission for your app. If you deny permissions will not be able to use functionality of this app.","Setting","Cancel",(value) async {
                                        if(value==1){
                                          openAppSettings();
                                        }
                                      });
                                    }else{
                                      Get.back();
                                      controller.pickImage(ImageSource.gallery);
                                    }
                                  });
                                }else{
                                  Get.back();
                                  controller.pickImage(ImageSource.gallery);
                                }
                              }else{
                                Get.back();
                                controller.pickImage(ImageSource.gallery);
                              }

                            },
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Icon(Icons.image,size: 60),
                                ),
                                heightSpace_5,
                                Text("Gallery",style: poppins(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 14))
                              ],

                            ),
                          )
                        ],
                      ),
                      heightSpace_10,
                    ])),

          ],
        ));
  }
  /*String formatDate(DateTime value) {
    return DateFormat("dd MMM yyyy").format(value);
  }*/
}
