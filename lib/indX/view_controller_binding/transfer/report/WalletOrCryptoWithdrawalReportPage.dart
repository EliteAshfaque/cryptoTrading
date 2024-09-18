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
import '../../../widgets/DataNotFoundView.dart';
import '../../../widgets/ShimmerLoaderView.dart';
import 'WalletOrCryptoWithdrawalReportController.dart';

class WalletOrCryptoWithdrawalReportPage extends StatelessWidget {
  WalletOrCryptoWithdrawalReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: "Withdrawal Report",
        bodyWidget: Obx(() =>Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(35))),
                    child: TextFormField(
                        controller: controller.searchController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            controller.searchReportList.value = controller.reportList
                                .where((element) =>
                            ((element.entryDate ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.userName ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.fromCurrencyName ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.toCurrencyName ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.toWallet ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.liveId ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.toAddress ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                "${element.userId ??0}".toLowerCase().contains(value.toLowerCase())||
                                "${element.tid ??0}".toLowerCase().contains(value.toLowerCase())))
                                .toList();
                          } else {
                            controller.searchReportList.value = controller.reportList;
                          }
                        },
                        style: poppins(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          prefixIcon:  Padding(
                            padding: const EdgeInsets.only(left: 13, right: 13),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey[500],
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.cancel,
                              color: primaryColor,
                            ),
                            onPressed: () {
                              controller.searchController.text = "";
                              controller.searchReportList.value = controller.reportList;
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          hintText: "Search",
                          hintStyle: poppins(
                              color: Colors.grey[500]!,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          border: InputBorder.none,
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () => showFilterDialog(context),
                  child: Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(right: 10),
                    /*padding: const EdgeInsets.all(11),*/
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.filter_alt_outlined,color: primaryColor,size: 30),
                  ),
                )
              ],
            ),
             Expanded(child: (controller.searchReportList.isNotEmpty && controller.isApiCalled.value == true)?
             ListView.builder(
                 itemCount: controller.searchReportList.length,
                 itemBuilder: (context, index) {
                   var item = controller.searchReportList[index];
                   return Container(
                     margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                     decoration: const BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.all(Radius.circular(20))),
                     child: Column(
                       children: [
                         heightSpace_15,
                         Row(
                             children: [
                               widthSpace_10,
                               RichText(
                                   textAlign: TextAlign.center,
                                   text: TextSpan(
                                       text: item.fromCurrencyName??"-",
                                       style: poppins(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600),
                                       children: [
                                         TextSpan(
                                             text: "\nFrom Currency",
                                             style: poppins(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w500))
                                       ]
                                   )),
                               widthSpace_5,
                               Expanded(
                                 child: RichText(
                                     textAlign: TextAlign.center,
                                     text: TextSpan(
                                         text: "${(item.entryDate??"-").replaceAll("  ", " ")}\n",
                                         style: poppins(color: gray_5,fontSize: 10,fontWeight: FontWeight.w500),
                                         children: [
                                           WidgetSpan(child: SvgPicture.asset("assets/svg/arrow.svg")),
                                   if(item.toWallet!=null && item.toWallet!.isNotEmpty)...[
                                   TextSpan(text: "\n${item.toWallet ?? ""}",style: poppins(color: gray_5,fontWeight: FontWeight.w600,fontSize: 10))
                                   ]
                                         ]
                                     )),
                               ),
                               widthSpace_5,
                               RichText(
                                   textAlign: TextAlign.center,
                                   text: TextSpan(
                                       text: item.toCurrencyName??"-",
                                       style: poppins(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600),
                                       children: [
                                         TextSpan(
                                             text: "\nTo Currency",
                                             style: poppins(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w500))
                                       ]
                                   )),
                               widthSpace_10
                             ]),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Transaction Id : ",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 11)),
                               Container(
                                   padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                                   decoration:  BoxDecoration(
                                       color: primaryColor,
                                       borderRadius: BorderRadius.circular(5)),
                                   child: Text("${item.tid ?? 0}",
                                       style: poppins(
                                           color: Colors.white,
                                           fontWeight:
                                           FontWeight.w600,
                                           fontSize: 11)))
                             ],
                           ),
                         ),
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                               widthSpace_10,
                               Expanded(
                                 child: RichText(
                                     textAlign: TextAlign.center,
                                     text: TextSpan(
                                         text: Utility.INSTANCE.formatedAmountNinePlace(item.requestedAmount??0.0),
                                         style: poppins(color: gray_6,fontSize: 12,fontWeight: FontWeight.w600),
                                         children: [
                                           TextSpan(
                                               text: "\nRequested Amount",
                                               style: poppins(color: gray_4,fontSize: 10,fontWeight: FontWeight.w500))
                                         ]
                                     )),
                               ),
                               widthSpace_5,
                               Expanded(
                                 child: RichText(
                                     textAlign: TextAlign.center,
                                     text: TextSpan(
                                         text: Utility.INSTANCE.formatedAmountNinePlace(item.convsertionRate??0.0),
                                         style: poppins(color: gray_6,fontSize: 12,fontWeight: FontWeight.w600),
                                         children: [
                                           if((item.liveRate??0)>0)...[
                                             TextSpan(
                                               text: ("\n(LR : ${Utility.INSTANCE.formatedAmountSixPlace(item.liveRate??0.0)})"),
                                               style: poppins(color: orange_2,fontWeight: FontWeight.w500,fontSize: 10),
                                             )
                                           ],
                                           TextSpan(
                                               text: "\nConvert Rate",
                                               style: poppins(color: gray_4,fontSize: 10,fontWeight: FontWeight.w500))
                                         ]
                                     )),
                               ),
                               widthSpace_5,
                               Expanded(
                                 child: RichText(
                                     textAlign: TextAlign.center,
                                     text: TextSpan(
                                         text: Utility.INSTANCE.formatedAmountNinePlace(item.transferAmount??0.0),
                                         style: poppins(color: gray_6,fontSize: 12,fontWeight: FontWeight.w600),
                                         children: [
                                           TextSpan(
                                               text: "\nTransfer Amount",
                                               style: poppins(color: gray_4,fontSize: 10,fontWeight: FontWeight.w500))
                                         ]
                                     )),
                               ),
                               widthSpace_10,
                             ]),

                         if((item.liveId??"").isNotEmpty || (item.toAddress??"").isNotEmpty)...[
                           heightSpace_10,
                           SvgPicture.asset("assets/svg/line.svg")
                         ],

                         if((item.liveId??"").isNotEmpty)...[
                           Container(margin: const EdgeInsets.only(left: 10,right: 10,bottom: 3,top: 10),
                               padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                               decoration: const BoxDecoration(
                                   color: orange_2,
                                   borderRadius:
                                   BorderRadius.all(
                                       Radius.circular(8))),
                               child: SelectableText(item.liveId ??"",
                                   style: poppins(
                                       color: Colors.white,
                                       fontWeight:
                                       FontWeight.w500,
                                       fontSize: 11))),
                           Text("Txn Hash",
                               style: poppins(color: Colors.black,fontSize: 11,fontWeight: FontWeight.w500))],
                         if((item.toAddress??"").isNotEmpty)...[
                           Container(margin: const EdgeInsets.only(left: 10,right: 10,bottom: 3,top: 10),
                               padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                               decoration: const BoxDecoration(
                                   color: green_6,
                                   borderRadius:
                                   BorderRadius.all(
                                       Radius.circular(8))),
                               child: SelectableText(item.toAddress ?? "",
                                   style: poppins(
                                       color: Colors.white,
                                       fontWeight:
                                       FontWeight.w500,
                                       fontSize: 11))),
                           Text("Address",
                               style: poppins(color: Colors.black,fontSize: 11,fontWeight: FontWeight.w500))
                         ],

                         heightSpace_10,
                         if((item.status??0)>0)...[
                           Container(
                             alignment: Alignment.center,
                             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                             decoration:  BoxDecoration(
                                 color: item.status==1?orange_2:item.status==2?green_3:item.status==3?red_2:accentColor,
                                 borderRadius: const BorderRadius.vertical(bottom:  Radius.circular(20))),
                             child: Text(item.status==1?"Processing":item.status==2?"Success":item.status==3?"Failed":"Reverted",
                                 style: poppins(
                                     color: Colors.white,
                                     fontSize: 15,
                                     fontWeight: FontWeight.w600)),
                           )
                         ]
                       ],
                     ),
                   );
                 }):
             (controller.searchReportList.isEmpty && controller.isApiCalled.value == false)?
             ShimmerLoaderView(
                 widget: ListView.builder(
                   itemCount: 6,
                   itemBuilder: (context, index) {
                     return Container(
                       margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                       height: 315,
                       decoration: const BoxDecoration(
                           color: primaryColorLight,
                           borderRadius: BorderRadius.all(Radius.circular(20))),
                     );
                   },
                 )):
              const DataNotFoundView(
                 text: "Transaction is not available"))
          ],
        )));
  }




  void showFilterDialog(context){


    controller.filterFromDateController.text = controller.filterFromDate;
    controller.filterToDateController.text = controller.filterToDate;


    Get.bottomSheet(
        isScrollControlled: true,
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(onTap:() =>  Get.back(),child: const Padding(

                padding: EdgeInsets.only(top: 5,bottom: 5),
                child: Icon(Icons.cancel,color: Colors.white,size: 35),
              )),
              Container(
                  padding: const EdgeInsets.fromLTRB(15,25,15,20),
                  decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                      color: Colors.white),
                  child:  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Filter!",
                          style: poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 25)),
                     heightSpace_20,

                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onTap: () => controller.openFromDate(context),
                              controller: controller.filterFromDateController,
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
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                  suffixIcon: Icon(
                                    Icons.calendar_month,
                                    color: Colors.grey[500],
                                  ),

                                  /*errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),*/
                                  hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                                  hintText: "Select From Date",
                                  fillColor: Colors.white),
                            ),
                          ),
                          widthSpace_10,
                          Expanded(
                            child: TextField(
                              onTap: () => controller.openToDate(context),
                              controller: controller.filterToDateController,
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
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                  suffixIcon: Icon(
                                    Icons.calendar_month,
                                    color: Colors.grey[500],
                                  ),

                                  /*errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),*/
                                  hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                                  hintText: "Select To Date",
                                  fillColor: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      heightSpace_25,
                      InkWell(
                        onTap: () async {
                          controller.filterFromDate=controller.filterFromDateController.text.trim();
                          controller.filterToDate=controller.filterToDateController.text.trim();

                          Get.back();
                          if(controller.isFromCrypto==true){
                            controller.getCryptoWithdrawalReport(true);
                          }else{
                            controller.getWalletWithdrawalReport(true);
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
                            ),child: Text("Apply",
                              style: poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18)),
                          ),
                        ),
                      )
                    ],
                  )),


            ],
          ),
        ));
  }
}