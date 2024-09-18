

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import 'DepositQrController.dart';

class DepositQrPage extends StatelessWidget {

  DepositQrController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    if(controller.dashboardController.allCryptoList.isEmpty){
      controller.dashboardController.currencyList(false,null);
    }

    return AppBarView(
        titleText: "Deposit ${controller.currencyItem.currencyName??""}",
        bodyWidget: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child:  Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              if (controller.technologyQrResponse.value.address != null && controller.technologyQrResponse.value.address!.isNotEmpty) ...[
                QrImageView(
                  backgroundColor: Colors.white,
                  data: controller.technologyQrResponse.value.address??"",
                  version: QrVersions.auto,
                  size: size.width-80,
                  gapless: true,
                ),
                heightSpace_15,
                if (controller.technologyQrResponse.value.techCode != null &&
                    controller
                        .technologyQrResponse.value.techCode!.isNotEmpty) ...[
                  Text(
                      "Send only ${controller.currencyItem.currencyName ?? ""} (${controller.technologyQrResponse.value.techCode ?? ""}) to this deposit address",
                      textAlign: TextAlign.center,
                      style: poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 12))
                ] else ...[
                  Text(
                      "Send only ${controller.currencyItem.currencyName ?? ""} to this deposit address",
                      textAlign: TextAlign.center,
                      style: poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 12))
                ],
                Container(
                  margin: const EdgeInsets.only(bottom: 5,top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text("Network",
                      style: poppins(color: Colors.black,fontWeight: FontWeight.w400,
                          fontSize: 10)),
                ),

                if (controller.technologyQrResponse.value.techName != null && controller.technologyQrResponse.value.techName!.isNotEmpty &&
                    controller.technologyQrResponse.value.techCode != null && controller.technologyQrResponse.value.techCode!.isNotEmpty) ...[
                  _networkWidget("${controller.technologyQrResponse.value.techName ?? ""} (${controller.technologyQrResponse.value.techCode})")
                ] else if (controller.technologyQrResponse.value.techName != null && controller.technologyQrResponse.value.techName!.isNotEmpty) ...[
                  if (controller.technologyQrResponse.value.technologyId == 1) ...[
                    _networkWidget("${controller.technologyQrResponse.value.techName ?? ""} (BEP20)")
                  ] else if (controller.technologyQrResponse.value.technologyId == 2) ...[
                    _networkWidget("${controller.technologyQrResponse.value.techName ?? ""} (TRC20)")
                  ] else ...[
                    _networkWidget(controller.technologyQrResponse.value.techName ?? "")
                  ]
                ] else if (controller.technologyQrResponse.value.techCode != null && controller.technologyQrResponse.value.techCode!.isNotEmpty) ...[
                  if (controller.technologyQrResponse.value.technologyId == 1) ...[
                    _networkWidget("BNB Smart Chain (${controller.technologyQrResponse.value.techCode ?? ""})")
                  ] else if (controller.technologyQrResponse.value.technologyId == 2) ...[
                    _networkWidget("TRON NETWORK (${controller.technologyQrResponse.value.techCode ?? ""})")
                  ] else ...[
                    _networkWidget(controller.technologyQrResponse.value.techCode ?? "")
                  ]
                ] else ...[
                  if (controller.technologyQrResponse.value.technologyName != null && controller.technologyQrResponse.value.technologyName!.isNotEmpty) ...[
                    if (controller.technologyQrResponse.value.technologyId == 1) ...[
                      _networkWidget("BNB Smart Chain (${controller.technologyQrResponse.value.technologyName ?? ""})")
                    ] else ...[
                      _networkWidget(controller.technologyQrResponse.value.technologyName ?? "")
                    ]
                  ] else ...[
                    if (controller.technologyQrResponse.value.technologyId == 1) ...[
                      _networkWidget("BNB Smart Chain (BEP20)")
                    ] else if (controller.technologyQrResponse.value.technologyId == 2) ...[
                      _networkWidget("TRON Network (TRC20)")
                    ]
                  ]
                ],
                Container(
                  margin: const EdgeInsets.only(bottom: 5,top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text("Wallet Address",
                      style: poppins(color: Colors.black,fontWeight: FontWeight.w400,
                          fontSize: 10)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10,5,3,5),
                  decoration: const BoxDecoration(
                      color: primaryColorMoreLight,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.technologyQrResponse.value.address??"",
                            style: poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 10)),
                        IconButton(onPressed: (){
                          Utility.INSTANCE.copyText(controller.technologyQrResponse.value.address??"","Wallet Address");
                        }, icon: const Icon(Icons.copy,color: primaryColor))
                      ]),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 20),
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
                          if(/*item.isBalanceFromDB==false &&*/ !controller.dashboardController.currencyBalanceMap.containsKey(item.id??0)){
                            controller.dashboardController.getCryptoBalanceApi(item.id??0,true,false);
                          }
                          return Container(
                            height: 70,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: const BoxDecoration( color: grayishBlue_alpha_55,borderRadius: BorderRadius.all(Radius.circular(10))),
                            alignment: Alignment.center,
                            width: controller.cryptoBalanceList.length%2==0?(size.width-57)/2:
                            index==(controller.cryptoBalanceList.length-1)?(size.width-52):(size.width-57)/2,
                            child: RichText(textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: item.currencyName??"",
                                    style: poppins(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.black),
                                    children: [
                                      /*if(item.isBalanceFromDB==true)...[
                                        TextSpan(
                                            text: "\n${Utility.INSTANCE.formatedAmountNinePlace(item.balance??0.0)}",
                                            style: poppins(fontSize: 12,fontWeight: FontWeight.w500,color: primaryColor)
                                        )
                                      ]else...[*/
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
                                      /*],*/

                                    ]
                                )),
                          );
                        }),
                      ),
                      heightSpace_10,
                      ElevatedButton(onPressed: () => Get.toNamed(AppRoutes.depositQRReport,arguments: controller.isFromWallet==true?controller.currencyItem.currencyId:controller.currencyItem.id), child: Text("View History",style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),))
                    ],
                  ),
                ),

              ]
            ],



          )),
        ));
  }

  Widget _networkWidget(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: const BoxDecoration(
          color: primaryColorMoreLight,
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Text(text,
            style: poppins(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 10)),

        TextButton(onPressed: () async {
          String url = controller.technologyQrResponse.value.techaddressUrl??"";
          if (url.isURL) {
            if (url.contains("{ADDRESS}")) {
             url = url.replaceAll("{ADDRESS}", controller.technologyQrResponse.value.address??"");
            }
          } else {
            if (controller.technologyQrResponse.value.technologyId == 2) {
              url = "https://tronscan.org/#/address/${controller.technologyQrResponse.value.address??""}";
            } else {
              url = "https://bscscan.com/address/${controller.technologyQrResponse.value.address??""}#tokentxns";
            }

          }
          await Utility.INSTANCE.urlLaunch(url);

        }, child: Text("Go to Explorer",style: poppins(decoration: TextDecoration.underline,fontSize: 10,fontWeight: FontWeight.w600,color: primaryColor),))
      ]),
    );
  }
}
