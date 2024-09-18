import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../api/model/BasicResponse.dart';
import '../../../api/model/transfer/SendMoneyBankReport.dart';
import '../../../themes/AppTextTheme.dart';
import '../../../themes/ThemeColor.dart';
import '../../../themes/ThemeHeightWidth.dart';
import '../../../utils/Utility.dart';
import '../../../widgets/AppBarView.dart';
import '../../../widgets/DataNotFoundView.dart';
import '../../../widgets/ShimmerLoaderView.dart';
import '../../otp/OTPController.dart';
import '../../otp/OTPPage.dart';
import 'SendMoneyBankReportController.dart';

class SendMoneyBankReportPage extends StatelessWidget {
  SendMoneyBankReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: "Transfer Report",
        bodyWidget: Obx(() => Column(
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
                                    .where((element) => ((element.operator ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                        (element.type_ ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                        (element.transactionID ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                        (element.requestMode ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                        (element.account ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                        (element.optional1 ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                        (element.optional2 ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                        (element.optional3 ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                        (element.optional4 ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                        (element.customerNo ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                        (element.liveID ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                        "${element.amount ?? 0}".toLowerCase().contains(value.toLowerCase()) ||
                                        "${element.tid ?? 0}".toLowerCase().contains(value.toLowerCase())))
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
                              prefixIcon: Padding(
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
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                        alignment: Alignment.center,
                        child: const Icon(
                            Icons.filter_alt_outlined,
                            color: primaryColor,
                            size: 30),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: (controller.searchReportList.isNotEmpty && controller.isApiCalled.value == true)
                        ? ListView.builder(
                            itemCount: controller.searchReportList.length,
                            itemBuilder: (context, index) {
                              var item = controller.searchReportList[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                                decoration:  BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: grayishBlue_alpha_22,
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: RichText(text: TextSpan(
                                              text: item.optional1 ?? "",
                                              style: poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13),
                                              children: [
                                                TextSpan(
                                                    text: "\nAc No : ",
                                                    style: poppins(
                                                        color: gray_6,
                                                        
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 11),
                                                   ),
                                                TextSpan(
                                                    text: item.account ?? "",
                                                    style: poppins(
                                                        color: Colors.black,
                                                        
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12)),
                                              ]
                                            )),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            decoration: BoxDecoration(
                                                color: item.intType==1?orange_1:item.intType==2?green_2:item.intType==3?red_2:item.intType==4?blue_3:gray_5,
                                                borderRadius: const BorderRadius.all(Radius.circular(5))
                                            ),
                                            child: Text(
                                                item.type_ ?? "",
                                                style: poppins(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700)
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    heightSpace_5,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: RichText(
                                          text: TextSpan(
                                              text: "Transaction Id : ",
                                              style: poppins(
                                                  color: gray_5,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 11),
                                              children: [
                                            TextSpan(
                                                text: item.transactionID ?? "",
                                                style: poppins(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12))
                                          ])),
                                    ),
                                    if (item.liveID != null && (item.liveID ?? "").isNotEmpty) ...[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: RichText(
                                            text: TextSpan(
                                                text: "Reference No : ",
                                                style: poppins(
                                                    color: gray_5,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 11),
                                                children: [
                                              TextSpan(
                                                  text: item.liveID ?? "",
                                                  style: poppins(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12))
                                            ])),
                                      )
                                    ],

                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                      decoration: const BoxDecoration(
                                          color: yellow_alpha,
                                          borderRadius: BorderRadius.all( Radius.circular(7))),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (item.optional3 != null && (item.optional3 ?? "").isNotEmpty) ...[
                                              Expanded(
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: "IFSC Code\n",
                                                      style: poppins(
                                                          color: gray_5,
                                                          
                                                          fontWeight: FontWeight.w600,fontSize: 11),
                                                      children: [
                                                          TextSpan(
                                                              text: item.optional3 ?? "",
                                                              style: poppins(
                                                                  color: Colors.black,
                                                                  
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 12)),
                                                      ])),
                                            ),
                                              widthSpace_2 ],
                                            if (item.operator != null && (item.operator ?? "").isNotEmpty) ...[
                                              Expanded(
                                              child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                      text: "Payment Mode\n",
                                                      style: poppins(
                                                          color: gray_5,
                                                          
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 11),
                                                      children: [
                                                          TextSpan(
                                                              text: item.operator ?? "",
                                                              style: poppins(
                                                                  color: Colors.black,
                                                                  
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 12))

                                                      ])),
                                            ),
                                              widthSpace_2
                                            ],
                                            Expanded(
                                              child: RichText(
                                                  textAlign: TextAlign.right,
                                                  text: TextSpan(
                                                      text: "Amount\n",
                                                      style: poppins(
                                                          color: gray_5,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 11),
                                                      children: [
                                                        TextSpan(
                                                            text: Utility.INSTANCE.formatedAmountWithRupees(item.amount ?? 0.0),
                                                            style: poppins(
                                                                color: Colors.green,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 14))

                                                      ])),
                                            )
                                          ]),
                                    ),
                                    heightSpace_5,
                                    Row(children: [
                                      widthSpace_10,
                                      Expanded(
                                        child: RichText(
                                            textAlign: TextAlign.left,
                                            text: TextSpan(
                                                text: item.entryDate ?? "-",
                                                style: poppins(
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600),
                                                children: [
                                                  TextSpan(
                                                      text: "\nRequested Date",
                                                      style: poppins(
                                                          color: gray_5,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w500))
                                                ])),
                                      ),
                                      widthSpace_5,
                                      Expanded(
                                        child: RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                                text: item.modifyDate ?? "-",
                                                style: poppins(
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600),
                                                children: [
                                                  TextSpan(
                                                      text:  item.intType==1?"\nAccepted Date":item.intType==2?"\nSuccess Date":item.intType==3?"\nFailed Date":item.intType==4?"\nRefunded Date":"\nModify Date",
                                                      style: poppins(
                                                          color: gray_5,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w500))
                                                ])),
                                      ),
                                      widthSpace_10
                                    ]),
                                    heightSpace_10,
                                    if (item.intType == 2 || item.intType == 4) ...[
                                      if (item.refundStatus == 1)...[
                                        GestureDetector(
                                          onTap: () =>  Utility.INSTANCE.dialogIconTwoButtonWithCallback("error_exclamation", "", "Are you sure you want to dispute?", "Dispute", "Cancel", (value){
                                            if(value==1){

                                              controller.submitDispute(item.tid, item.transactionID, "","", false, (BasicResponse response){
                                                showOTPDialog(item,response.refID??"");
                                              });
                                            }
                                          }),
                                          child: Container(
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            decoration: const BoxDecoration(
                                                color: red_2,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: primaryShadowGrey,
                                                    blurRadius: 2.5,
                                                    spreadRadius: 1.5,
                                                  ),
                                                ],

                                                borderRadius: BorderRadius.vertical(
                                                    bottom:  Radius.circular(20))),
                                            child: Text("Dispute",
                                                style: poppins(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600)),
                                          ),
                                        )
                                      ]else...[
                                        Container(
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          decoration:  BoxDecoration(
                                              color: item.refundStatus == 2?Colors.orange[300]:item.refundStatus == 3?Colors.green[300]:Colors.red[300],
                                              borderRadius: const BorderRadius.vertical(
                                                  bottom:  Radius.circular(20))),
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Dispute Status : ",
                                                style: poppins(
                                                    color: gray_1,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600),
                                                children: [
                                                  TextSpan(
                                                      text: item.refundStatus_??"",
                                                      style: poppins(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w700))
                                                ]

                                            ),
                                          ),
                                        )
                                      ]
                                    ]
                                  ],
                                ),
                              );
                            })
                        : (controller.searchReportList.isEmpty && controller.isApiCalled.value == false)
                            ? ShimmerLoaderView(
                                widget: ListView.builder(
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                                    height: 170,
                                    decoration: const BoxDecoration(
                                        color: primaryColorLight,
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                  );
                                },
                              ))
                            : const DataNotFoundView(text: "Transaction is not available"))
              ],
            )));
  }

  void showFilterDialog(context){


    controller.filterFromDateController.text = controller.filterFromDate;
    controller.filterToDateController.text = controller.filterToDate;
    controller.filterTxnIdController.text = controller.filterTransactionId;
    controller.filterAcNOController.text = controller.filterAccountNo;
    controller.filterTopRowController.text = controller.filterTopRows;
    controller.filterStatusController.text = controller.filterStatus;

    Get.bottomSheet(
        isScrollControlled: true,
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(onTap:() =>  Get.back(),child: const Padding(
                padding: EdgeInsets.only(top: 5,bottom: 5),
                child: Icon(Icons.cancel,color: Colors.white,size: 35),
              ),
              ),
              Container(

                  padding: const EdgeInsets.fromLTRB(15,25,15,20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                                      child: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30.0),
                                      )),
                                  filled: true,
                                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                                      child: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30.0),
                                      )),
                                  filled: true,
                                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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


                      heightSpace_15,
                      TextField(
                        controller: controller.filterTxnIdController,
                        style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                        cursorColor: primaryColor,
                        maxLength: 10,
                        decoration: InputDecoration(
                            border: DecoratedInputBorder(
                                shadow: const [
                                  BoxShadow(
                                      color: primaryShadowGrey,
                                      blurRadius: 2,
                                      spreadRadius: 1.0
                                  )
                                ],
                                child: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            counterText: "",
                            filled: true,
                            contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            /* errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),*/
                            hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                            hintText: "Enter Transaction Id",
                            fillColor: Colors.white),
                      ),
                      heightSpace_15,
                      TextField(
                        controller: controller.filterAcNOController,
                        style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                        cursorColor: primaryColor,
                        maxLength: 10,
                        decoration: InputDecoration(
                            border: DecoratedInputBorder(
                                shadow: const [
                                  BoxShadow(
                                      color: primaryShadowGrey,
                                      blurRadius: 2,
                                      spreadRadius: 1.0
                                  )
                                ],
                                child: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            counterText: "",
                            filled: true,
                            contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),

                            /* errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),*/
                            hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                            hintText: "Enter Account No",
                            fillColor: Colors.white),
                      ),
                      heightSpace_15,
                      TextField(
                        onTap: () => Utility.INSTANCE.showBottomSheet("Select Status", controller.statusList,false,(String value){
                          controller.filterStatusController.text=value;
                        }),
                        controller: controller.filterStatusController,
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
                                child: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            filled: true,
                            contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey[500],
                            ),

                            /*errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),*/
                            hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                            hintText: "Select Wallet",
                            fillColor: Colors.white),
                      ),
                      heightSpace_15,
                      TextField(
                        onTap: () => Utility.INSTANCE.showBottomSheet("Select Top Count", controller.topCountList,false,(String value){
                          controller.filterTopRowController.text=value;
                        }),
                        controller: controller.filterTopRowController,
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
                                child: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            filled: true,
                            contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey[500],
                            ),

                            /*errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),*/
                            hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                            hintText: "Select Top Count",
                            fillColor: Colors.white),
                      ),
                      InkWell(
                          onTap: () async {
                            controller.filterFromDate=controller.filterFromDateController.text.trim();
                            controller.filterToDate=controller.filterToDateController.text.trim();
                            controller.filterTransactionId=controller.filterTxnIdController.text.trim();
                            controller.filterAccountNo=controller.filterAcNOController.text.trim();
                            controller.filterStatus=controller.filterStatusController.text.trim();
                            controller.filterStatusId=controller.statusList.indexOf(controller.filterStatus);
                            controller.filterTopRows=controller.filterTopRowController.text.trim();

                            Get.back();
                            controller.getReport(true);

                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 20),
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
                            ),
                            child: Text("Apply",
                                style: poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18)),
                          )),
                    ],
                  )),

            ],
          ),
        ));
  }


  void showOTPDialog(SendMoneyBankReport item, String refId){
    String rfId =refId;
    if(Get.isDialogOpen==false) {
      Get.bottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          OTPPage(isGauth: false,callBack: (OTPController controllerOTP,String otp) async {
            if(otp.isNotEmpty&& otp.length==6){
              controller.submitDispute(item.tid, item.transactionID, otp,rfId, false,null);
            }else{
              controller.submitDispute(item.tid, item.transactionID, "","", true,(BasicResponse response){
                rfId=response.refID??"";
                controllerOTP.startTimer();
              });
            }


          }));
    }
  }
}
