
import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../api/model/balance/AllowedWallet.dart';
import '../../api/model/transfer/DetailsByUserIdResponse.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import 'WalletToWalletTransferController.dart';

class WalletToWalletTransferPage extends StatelessWidget {

  WalletToWalletTransferController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
   /* if(controller.dashboardController.displayBalCryptoList.isEmpty){
      controller.dashboardController.currencyList(false,null);
    }*/
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
                    Text("User Id",
                        style: poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    heightSpace_5,
                    TextField(
                      controller: controller.receiverIdController,
                      readOnly: controller.balanceData.walletTransferType == 1?true:false,
                      style: poppins(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      cursorColor: primaryColor,
                      onChanged: (value) {
                        if (value.isEmpty || value != controller.inputReceiverId) {
                          controller.dataByUserIdResponse.value = DetailsByUserIdResponse();
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
                          suffixIcon: controller.balanceData.walletTransferType == 1?null:
                          IconButton(
                            style: IconButton.styleFrom(
                                tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                                padding: EdgeInsets.zero),
                            icon:
                            const Icon(Icons.search, color: primaryColor),
                            onPressed: () {
                              controller.receiverIdError.value = "";
                              if (controller.receiverIdController.text
                                  .trim()
                                  .isEmpty) {
                                controller.receiverIdError.value =
                                "Enter valid user id.";
                                return;
                              }
                              controller.getUserData(controller.receiverIdController.text.trim());
                            },
                          ),
                          errorText: controller.receiverIdError.value.isNotEmpty
                              ? controller.receiverIdError.value
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
                    if (controller.dataByUserIdResponse.value.name != null && controller.dataByUserIdResponse.value.name!.isNotEmpty ||
                        controller.dataByUserIdResponse.value.mobile != null && controller.dataByUserIdResponse.value.mobile!.isNotEmpty ||
                        controller.dataByUserIdResponse.value.emailId != null && controller.dataByUserIdResponse.value.emailId!.isNotEmpty) ...[

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
                            if (controller.dataByUserIdResponse.value.name != null && controller.dataByUserIdResponse.value.name!.isNotEmpty) ...[
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
                                        controller.dataByUserIdResponse.value.name ?? "-",
                                        style: poppins(
                                            color: gray_5,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                  )
                                ],
                              )
                            ],
                            if (controller.dataByUserIdResponse.value.mobile != null &&
                                controller.dataByUserIdResponse.value.mobile!.isNotEmpty) ...[
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
                                        controller.dataByUserIdResponse.value.mobile ?? "-",
                                        style: poppins(
                                            color: gray_5,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                  )
                                ],
                              ),
                            ],
                            if (controller.dataByUserIdResponse.value.emailId != null &&
                                controller.dataByUserIdResponse.value.emailId!.isNotEmpty) ...[
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
                                        controller.dataByUserIdResponse.value.emailId ?? "-",
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
                      )],
                     if(controller.balanceData.allowedWallet!=null && controller.balanceData.allowedWallet!.length>1)...[
                        heightSpace_20,
                        Text("Destination",
                            style: poppins(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        heightSpace_5,
                        TextField(
                          onTap: () => Utility.INSTANCE.showBottomSheet<AllowedWallet>("Select Destination", controller.balanceData.allowedWallet!,false,(AllowedWallet item){
                            controller.destinationController.text = item.walletName??"";
                            controller.selectedDestination.value=item;
                          }),
                          controller: controller.destinationController,
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
                              errorText: controller.destinationError.value.isNotEmpty
                                  ? controller.destinationError.value
                                  : null,
                              errorStyle: poppins(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                              hintStyle: poppins(
                                  color: Colors.grey[500]!,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              hintText: "Select Destination",
                              fillColor: Colors.white),
                        ),
                      ],



                    heightSpace_20,
                    Text("Amount",
                        style: poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    heightSpace_5,
                  TextField(
                    controller: controller.amountController,
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



                    heightSpace_40,
                  InkWell(
                    onTap: () {
                      if((controller.dataByUserIdResponse.value.userId??0)==0){
                        controller.receiverIdError.value="Enter valid receiver Id";
                        return;
                      }else if(controller.amountController.text.trim().isEmpty){
                        controller.amountError.value="Enter valid amount";
                        return;
                      }
                      controller.transferApi();
                      /*  controller.submitDetail((ActivateUserResponse response){
                            Utility.INSTANCE.showResponseDetailDialog(response);
                          });*/
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
                  ,
                ],
              )),
        ));
  }
}
