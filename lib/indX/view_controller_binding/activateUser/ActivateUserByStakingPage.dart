
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../api/model/activateUser/ActivateUserResponse.dart';
import '../../api/model/activateUser/PackageList.dart';
import '../../api/model/activateUser/TopupDataByUserId.dart';
import '../../api/model/activateUser/TopupDataByUserIdResponse.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import '../../widgets/CachePlaceHolderImage.dart';
import 'ActivateUserByStakingController.dart';

class ActivateUserByStakingPage extends StatelessWidget {

  ActivateUserByStakingController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    if(controller.dashboardController.displayBalCryptoList.isEmpty){
      controller.dashboardController.currencyList(false,null);
    }
    return AppBarView(
        titleText: "Activate Member",
        bodyWidget: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    decoration: const BoxDecoration(
                        color: grayishBlue_alpha_22,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25))),
                    child:
                    SvgPicture.asset("assets/svg/logo.svg",
                        height: 75),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                        color: primaryColorLight,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(25))),
                    child: Column(
                      children: [

                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          color: primaryColor,
                          child: Wrap(
                            spacing: 1,
                            runSpacing: 1,
                            children: List.generate(controller.dashboardController.displayBalCryptoList.length, (index) {
                              var item =controller.dashboardController.displayBalCryptoList[index];
                              if(item.isBalanceFromDB==false && !controller.dashboardController.currencyBalanceMap.containsKey(item.id??0)){
                                controller.dashboardController.getCryptoBalanceApi(item.id??0,true,false);
                              }
                              return Container(
                                height: 70,
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                color: primaryColorLight,
                                alignment: Alignment.center,
                              width: controller.dashboardController.displayBalCryptoList.length%2==0?(size.width-51)/2:
                              index==(controller.dashboardController.displayBalCryptoList.length-1)?(size.width-50):(size.width-51)/2,
                                child: RichText(textAlign: TextAlign.center,
                                    text: TextSpan(
                                  text: item.currencyName??"",
                                  style: poppins(fontSize: 13,fontWeight: FontWeight.w500,color: lightPurple),
                                  children: [
                                    if(item.isBalanceFromDB==true)...[
                                      TextSpan(
                                          text: "\n${Utility.INSTANCE.formatedAmountNinePlace(item.balance??0.0)}",
                                          style: poppins(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white)
                                      )
                                    ]else...[
                                      TextSpan(
                                          text: "\n${controller.dashboardController.currencyBalanceMap.containsKey(item.id??0)?
                                          controller.dashboardController.currencyBalanceMap[item.id??0]!.balance??"":"0"}",
                                          style: poppins(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white)
                                      ),
                                      TextSpan(
                                          text: "\n\$${controller.dashboardController.currencyBalanceMap.containsKey(item.id??0)?
                                          Utility.INSTANCE.formatedAmountNinePlace(controller.dashboardController.currencyBalanceMap[item.id??0]!.balanceInUSDT??0):"0"}",
                                          style: poppins(fontSize: 10,fontWeight: FontWeight.w500,color: Colors.white)
                                      )
                                    ],

                                  ]
                                )),
                              );
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,10,15,15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                    "You have to maintain minimum 2\$ BNB in your blockchain address for smooth transaction.",
                                    style: poppins(
                                        color: red_2,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600)),
                              ),
                              TextButton(
                                  onPressed: () =>  Get.toNamed(AppRoutes.myStakeHistory,arguments: controller.dashboardController.balanceResponse.value.balanceData!),
                                  style: TextButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                  child: Text("View Stack History",
                                      style: poppins(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600)))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  heightSpace_20,
                  Text("User Id",
                      style: poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  heightSpace_5,
                  TextField(
                    controller: controller.userIdController,
                    readOnly: (controller.dashboardController.userTopupType.value == 1 &&
                            controller.topupDataByUserIdResponse.value.data != null &&
                            controller.topupDataByUserIdResponse.value.data!.isNotEmpty)
                        ? true
                        : false,
                    style: poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    cursorColor: Colors.white,
                    onChanged: (value) {
                      if (value.isEmpty ||
                          value != controller.inputReferrralId) {
                        controller.topupDataByUserIdResponse.value =
                            TopupDataByUserIdResponse();
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        filled: true,
                        suffixIcon: (controller.dashboardController.userTopupType.value == 1 &&
                                controller.topupDataByUserIdResponse.value.data != null &&
                                controller.topupDataByUserIdResponse.value.data!.isNotEmpty)
                            ? null
                            : IconButton(
                                style: IconButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    padding: EdgeInsets.zero),
                                icon:
                                    Icon(Icons.search, color: Colors.grey[400]),
                                onPressed: () {
                                  controller.userIdError.value = "";
                                  if (controller.userIdController.text
                                      .trim()
                                      .isEmpty) {
                                    controller.userIdError.value =
                                        "Enter valid user id.";
                                    return;
                                  }
                                  controller.getUserData(
                                      controller.userIdController.text.trim(),
                                      true);
                                },
                              ),
                        errorText: controller.userIdError.value.isNotEmpty
                            ? controller.userIdError.value
                            : null,
                        errorStyle: poppins(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                        hintStyle: poppins(
                            color: Colors.grey[400]!,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        hintText: "Enter User Id",
                        fillColor: grayishBlue_alpha_22),
                  ),
                  if (controller.topupDataByUserIdResponse.value.name != null &&
                          controller.topupDataByUserIdResponse.value.name!.isNotEmpty ||
                      controller.topupDataByUserIdResponse.value.mobileNo != null &&
                          controller.topupDataByUserIdResponse.value.mobileNo!.isNotEmpty ||
                      controller.topupDataByUserIdResponse.value.emailID != null &&
                          controller.topupDataByUserIdResponse.value.emailID!.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(top: 15),
                      decoration: const BoxDecoration(
                          color: grayishBlue_alpha_22,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25))),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          widthSpace_10,
                          Text(
                            "User Details",
                            style: poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                          color: primaryColorLight,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(25))),
                      child: Column(
                        children: [
                          if (controller.topupDataByUserIdResponse.value.name !=
                                  null &&
                              controller.topupDataByUserIdResponse.value.name!
                                  .isNotEmpty) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Name : ",
                                    style: poppins(
                                        color: lightPurple,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                                Text(
                                    controller.topupDataByUserIdResponse.value
                                            .name ??
                                        "-",
                                    style: poppins(
                                        color: gray_1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12))
                              ],
                            )
                          ],
                          if (controller.topupDataByUserIdResponse.value
                                      .mobileNo !=
                                  null &&
                              controller.topupDataByUserIdResponse.value
                                  .mobileNo!.isNotEmpty) ...[
                            const Divider(color: primaryColor, height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mobile No : ",
                                    style: poppins(
                                        color: lightPurple,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                                Text(
                                    controller.topupDataByUserIdResponse.value
                                            .mobileNo ??
                                        "-",
                                    style: poppins(
                                        color: gray_1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12))
                              ],
                            ),
                          ],
                          if (controller.topupDataByUserIdResponse.value
                                      .emailID !=
                                  null &&
                              controller.topupDataByUserIdResponse.value
                                  .emailID!.isNotEmpty) ...[
                            const Divider(color: primaryColor, height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Email Id : ",
                                    style: poppins(
                                        color: lightPurple,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                                Text(
                                    controller.topupDataByUserIdResponse.value
                                            .emailID ??
                                        "-",
                                    style: poppins(
                                        color: gray_1,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12))
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                    heightSpace_25,
                    if(controller.typeList.isNotEmpty && controller.typeList.length>1)...[
                      Text("Activation Type",
                          style: poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      heightSpace_5,
                      TextField(
                        onTap: () => Utility.INSTANCE.showBottomSheet<TopupDataByUserId>("Select Type", controller.typeList, false, ( TopupDataByUserId value){
                          if(controller.selectedType.value !=value) {
                            controller.setTypeData(value,true);
                          }
                        }),
                        controller: controller.typeController,
                        readOnly: true,
                        style: poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            contentPadding: const EdgeInsets.all(20),
                            filled: true,
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey[400],
                            ),
                            errorText: controller.typeError.value.isNotEmpty
                                ? controller.typeError.value
                                : null,
                            errorStyle: poppins(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                            hintStyle: poppins(
                                color: Colors.grey[400]!,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            hintText: "Select Type",
                            fillColor: grayishBlue_alpha_22),
                      ),
                      heightSpace_25
                    ],
                    Text("Package",
                        style: poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    heightSpace_5,
                    TextField(
                      onTap: () => Utility.INSTANCE.showBottomSheet<PackageList>("Select Package", controller.packageList, false, ( PackageList value){
                        if (controller.selectedPackage.value != value) {
                          controller.setPackage(value);
                        }
                      }),
                      controller: controller.packageController,
                      readOnly: true,
                      maxLines: null,
                      style: poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                          filled: true,
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey[400],
                          ),
                          errorText: controller.packageError.value.isNotEmpty
                              ? controller.packageError.value
                              : null,
                          errorStyle: poppins(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                          hintStyle: poppins(
                              color: Colors.grey[400]!,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          hintText: "Select Package",
                          fillColor: grayishBlue_alpha_22),
                    ),
                    heightSpace_5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Package Amount : ",
                            style: poppins(
                                color: lightPurple,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)),
                        Text("${Utility.INSTANCE.getCurrencySymbol(controller.selectedPackage.value.packageCurrency??"")} ${Utility.INSTANCE.formatedAmountWithOutRupees(controller.selectedPackage.value.packageCost??0.0)}",
                            style: poppins(
                                color: gray_1,
                                fontWeight: FontWeight.w500,
                                fontSize: 14))
                      ],
                    ),
                    /*heightSpace_25,
                    Text("Wallet",
                        style: poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    heightSpace_5,
                    TextField(
                      onTap: () => Utility.INSTANCE.showBottomSheet<WalletTypeList>("Select Wallet", controller.walletList, false, ( WalletTypeList value){
                        if (controller.selectedWallet.value != value) {
                          controller.setWallet(value);
                        }
                      }),
                      controller: controller.walletController,
                      readOnly: true,
                      style: poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                          filled: true,
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey[400],
                          ),
                          errorText: controller.walletError.value.isNotEmpty
                              ? controller.walletError.value
                              : null,
                          errorStyle: poppins(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                          hintStyle: poppins(
                              color: Colors.grey[400]!,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          hintText: "Select Wallet",
                          fillColor: grayishBlue_alpha_22),
                    ),
                    heightSpace_5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Wallet Balance : ",
                            style: poppins(
                                color: lightPurple,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)),
                        Text("${Utility.INSTANCE.getCurrencySymbol(controller.selectedWallet.value.symbol??"")}${Utility.INSTANCE.formatedAmountWithOutRupees(controller.selectedWallet.value.userBalance??0.0)}",
                            style: poppins(
                                color: gray_1,
                                fontWeight: FontWeight.w500,
                                fontSize: 14))
                      ],
                    ),*/
                    if(controller.currencyList.isNotEmpty && controller.currencyList.length>1)...[
                      heightSpace_25,
                      Text("Currency",
                          style: poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      heightSpace_5,
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(controller.currencyList.length, (index) {
                          var item =controller.currencyList[index];
                          return GestureDetector(
                            onTap: () => controller.setBusinessCurrency(item),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 7),
                              decoration:  BoxDecoration(
                                  color: controller.selectedCurrency.value==item?lightPurple:grayishBlue_alpha_22,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                              child: Text(item.currencyName??"",
                                  style: poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                          );
                        }),
                      )
                    ],
                    if(controller.selectedPackage.value.isRangePackageCost==true)...[
                    heightSpace_25,
                    Text("Amount (${Utility.INSTANCE.getCurrencySymbol(controller.selectedPackage.value.defaultCurrency??"")})",
                        style: poppins(
                            color: Colors.white,
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

                              if (controller.selectedPackage.value.isRangePackageCost == true) {
                                if (controller.inputAmount.value > (controller.selectedPackage.value.rangePackageCost ?? 0) ||
                                    controller.inputAmount.value < (controller.selectedPackage.value.packageCost ?? 0)) {
                                  controller.amountError.value = "Amount should be between  ${Utility.INSTANCE.formatedAmountWithOutRupees(controller.selectedPackage.value.packageCost ?? 0.0)}  to  ${Utility.INSTANCE.formatedAmountWithOutRupees(controller.selectedPackage.value.rangePackageCost ?? 0.0)}";
                                  return;
                                }
                              }

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
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        cursorColor: Colors.white,
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
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            contentPadding: const EdgeInsets.all(20),
                            filled: true,
                            errorText: controller.amountError.value.isNotEmpty
                                ? controller.amountError.value
                                : null,
                            errorStyle: poppins(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                            hintStyle: poppins(
                                color: Colors.grey[400]!,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            hintText: "Enter Amount",
                            fillColor: grayishBlue_alpha_22),
                      ),
                    )],
                    if (controller.selectedPackage.value.defaultCurrencyId != controller.selectedCurrency.value.displayConversionCurrId &&
                        (controller.selectedCurrency.value.displayConversionCurrId??0) > 0) ...[
                      heightSpace_25,
                      Row(
                        children: [
                          Text("Convert Amount (${Utility.INSTANCE.getCurrencySymbol(controller.selectedCurrency.value.displayConversionCurrSymbol??"")})",
                              style: poppins(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                          const Spacer(),
                          Text("1 ",
                              style: poppins(
                                  color: accentColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          CachePlaceHolderImage(imageUrl: controller.selectedCurrency.value.displayConversionCurrImage??"",
                              imageHeight: 14,
                              imgaeWidth: 14,
                              errorColorBackground: Colors.transparent,
                              errorIconHeight: 14),
                          Text(" = ${Utility.INSTANCE.getCurrencySymbol(controller.selectedPackage.value.defaultCurrency??"")} ${Utility.INSTANCE.formatedAmountWithOutRupees(controller.liveRateResponse.value.liveRate??0.0)}",
                              style: poppins(
                                  color: accentColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      heightSpace_5,
                      Focus(
                        onFocusChange: (value) => controller.isConvertAmountFocused.value=value,
                        child: TextField(
                          controller: controller.convertAmountController,
                          readOnly: controller.selectedPackage.value.isRangePackageCost==true?false:true,
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
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          cursorColor: Colors.white,
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
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              contentPadding: const EdgeInsets.all(20),
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
                                  color: Colors.grey[400]!,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              hintText: "Enter Convert Amount",
                              fillColor: grayishBlue_alpha_22),
                        ),
                      ),
                    ],

                    heightSpace_40,
                    ElevatedButton(
                        onPressed: () {
                         controller.submitDetail((ActivateUserResponse response){
                            Utility.INSTANCE.showResponseDetailDialog("Activation Details",response);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size(double.infinity, 50)),
                        child: Text("Submit",
                            style: poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18)))
                  ],
                ],
              )),
        ));
  }

}
