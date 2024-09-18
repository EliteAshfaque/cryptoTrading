import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../api/model/activateUser/PackageList.dart';
import '../../api/model/activateUser/TopupDataByUserId.dart';
import '../../api/model/activateUser/TopupDataByUserIdResponse.dart';
import '../../api/model/activateUser/WalletTypeList.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import '../../widgets/CachePlaceHolderImage.dart';
import 'StakeNowByPackageController.dart';

class StakeNowByPackagePage extends StatelessWidget {

  StakeNowByPackageController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    if(controller.dashboardController.displayBalCryptoList.isEmpty){
      controller.dashboardController.currencyList(false,null);
    }
    return AppBarView(
        titleText: "Stake Now",
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
                        controller.stakeType=="2"? Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: List.generate(controller.dashboardController.displayBalCryptoList.length, (index) {
                            var item =controller.dashboardController.displayBalCryptoList[index];
                            if(item.isBalanceFromDB==false && !controller.dashboardController.currencyBalanceMap.containsKey(item.id??0)){
                              controller.dashboardController.getCryptoBalanceApi(item.id??0,true,false);
                            }
                            return Container(
                              height: 70,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration( color: grayishBlue_alpha_55,borderRadius: BorderRadius.all(Radius.circular(7))),
                              width: controller.dashboardController.displayBalCryptoList.length%2==0?(size.width-57)/2:
                              index==(controller.dashboardController.displayBalCryptoList.length-1)?(size.width-52):(size.width-57)/2,
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
                        ):Wrap(
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
                            onPressed: () =>  Get.toNamed(AppRoutes.stakeHistory),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)))),
                            child: Text("View History",
                                style: poppins(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600)))
                      ],
                    ),
                  ),
                  Text("User Id",
                      style: poppins(
                          color: Colors.black,
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
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    cursorColor: primaryColor,
                    onChanged: (value) {
                      if (value.isEmpty ||
                          value != controller.inputReferrralId) {
                        controller.topupDataByUserIdResponse.value =
                            TopupDataByUserIdResponse();
                      }
                    },
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
                                    const Icon(Icons.search, color: primaryColor),
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
                            color: Colors.grey[500]!,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        hintText: "Enter User Id",
                        fillColor: Colors.white),
                  ),
                  if (controller.topupDataByUserIdResponse.value.name != null &&
                          controller.topupDataByUserIdResponse.value.name!.isNotEmpty ||
                      controller.topupDataByUserIdResponse.value.mobileNo != null &&
                          controller.topupDataByUserIdResponse.value.mobileNo!.isNotEmpty ||
                      controller.topupDataByUserIdResponse.value.emailID != null &&
                          controller.topupDataByUserIdResponse.value.emailID!.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 15),
                      decoration:  BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: primaryColor,width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.person,
                                color: primaryColor,
                              ),
                              widthSpace_10,
                              Text(
                                "User Details",
                                style: poppins(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              )
                            ],
                          ),
                          const Divider(color: primaryColor),
                          if (controller.topupDataByUserIdResponse.value.name != null && controller.topupDataByUserIdResponse.value.name!.isNotEmpty) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Name : ",
                                    style: poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13)),
                                Flexible(
                                  child: Text(
                                      controller.topupDataByUserIdResponse.value.name ?? "-",
                                      style: poppins(
                                          color: gray_5,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                )
                              ],
                            )
                          ],
                          if (controller.topupDataByUserIdResponse.value.mobileNo != null &&
                              controller.topupDataByUserIdResponse.value.mobileNo!.isNotEmpty) ...[
                            heightSpace_7,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mobile No : ",
                                    style: poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13)),
                                Flexible(
                                  child: Text(
                                      controller.topupDataByUserIdResponse.value.mobileNo ?? "-",
                                      style: poppins(
                                          color: gray_5,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                )
                              ],
                            ),
                          ],
                          if (controller.topupDataByUserIdResponse.value.emailID != null &&
                              controller.topupDataByUserIdResponse.value.emailID!.isNotEmpty) ...[
                            heightSpace_7,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Email Id : ",
                                    style: poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13)),
                                Flexible(
                                  child: Text(
                                      controller.topupDataByUserIdResponse.value.emailID ?? "-",
                                      style: poppins(
                                          color: gray_5,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                )
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                    heightSpace_25,
                   if(controller.typeList.isNotEmpty && controller.typeList.length>1)...[
                      Text("Stake Type",
                          style: poppins(
                              color: Colors.black,
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
                            errorText: controller.typeError.value.isNotEmpty
                                ? controller.typeError.value
                                : null,
                            errorStyle: poppins(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                            hintStyle: poppins(
                                color: Colors.grey[500]!,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            hintText: "Select Type",
                            fillColor: Colors.white),
                      ),

                    ],
                    if(controller.packageList.isNotEmpty && controller.packageList.length>1)...[
                      heightSpace_25,
                    Text("Package",
                        style: poppins(
                            color: Colors.black,
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
                          errorText: controller.packageError.value.isNotEmpty
                              ? controller.packageError.value
                              : null,
                          errorStyle: poppins(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                          hintStyle: poppins(
                              color: Colors.grey[500]!,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          hintText: "Select Package",
                          fillColor: Colors.white),
                    ),
                    heightSpace_5,
                    Center(
                      child: RichText(textAlign: TextAlign.center,
                          text: TextSpan(
                        text: "Package Amount : ",
                          style: poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        children: [
                          TextSpan(
                            text: "${Utility.INSTANCE.getCurrencySymbol(controller.selectedPackage.value.packageCurrency??"")} ${Utility.INSTANCE.formatedAmountWithOutRupees(controller.selectedPackage.value.packageCost??0.0)}",
                              style: poppins(
                                  color: orange_2,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)
                          )
                        ]
                      )),
                    ),
                   ],
                    if(controller.walletList.isNotEmpty && controller.walletList.length>1)...[
                      heightSpace_25,
                      Text(controller.stakeType=="1"?"Wallet":"Coin",
                          style: poppins(
                              color: Colors.black,
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
                            errorText: controller.walletError.value.isNotEmpty
                                ? controller.walletError.value
                                : null,
                            errorStyle: poppins(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                            hintStyle: poppins(
                                color: Colors.grey[500]!,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            hintText: controller.stakeType=="1"?"Select Wallet":"Select Coin",
                            fillColor: Colors.white),
                      ),
                     /* heightSpace_5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Wallet Balance : ",
                              style: poppins(
                                  color: lightPurple,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)),
                          Text("${Utility.INSTANCE.getCurrencySymbol(controller.selectedWallet.value.symbol??"")} ${Utility.INSTANCE.formatedAmountWithOutRupees(controller.selectedWallet.value.userBalance??0.0)}",
                              style: poppins(
                                  color: gray_1,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14))
                        ],
                      ),*/
                    ],


                    if(controller.selectedPackage.value.isRangePackageCost==true)...[
                    heightSpace_25,
                    Text("Amount (${Utility.INSTANCE.getCurrencySymbol(controller.selectedPackage.value.defaultCurrency??"")})",
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

                              if (controller.selectedPackage.value.isRangePackageCost == true) {
                                if (controller.inputAmount.value > (controller.selectedPackage.value.rangePackageCost ?? 0) || controller.inputAmount.value < (controller.selectedPackage.value.packageCost ?? 0)) {
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
                    )],
                    if (controller.selectedPackage.value.defaultCurrencyId != controller.selectedWallet.value.displayConversionCurrId &&
                        (controller.selectedWallet.value.displayConversionCurrId??0) > 0) ...[
                      heightSpace_25,
                      Row(
                        children: [
                          Text("Convert Amount (${Utility.INSTANCE.getCurrencySymbol(controller.selectedWallet.value.displayConversionCurrSymbol??"")})",
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
                          CachePlaceHolderImage(imageUrl: controller.selectedWallet.value.displayConversionCurrImage??"",
                              imageHeight: 14,
                              imgaeWidth: 14,
                              errorColorBackground: Colors.transparent,
                              errorIconHeight: 14),
                          Text(" = ${Utility.INSTANCE.getCurrencySymbol(controller.selectedPackage.value.defaultCurrency??"")} ${Utility.INSTANCE.formatedAmountWithOutRupees(controller.liveRateResponse.value.liveRate??0.0)}",
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

                    heightSpace_40,
                    InkWell(
                      onTap: () => controller.submitDetail(),
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
                ],
              )),
        ));
  }
}
