

import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../themes/AppTextTheme.dart';
import '../../../themes/ThemeColor.dart';
import '../../../themes/ThemeHeightWidth.dart';
import '../../../utils/Utility.dart';
import '../../../widgets/AppBarView.dart';
import '../../../widgets/DataNotFoundView.dart';
import '../../../widgets/ShimmerLoaderView.dart';
import 'FundRequestReportController.dart';


class FundRequestReportPage extends StatelessWidget {

  FundRequestReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: "Fund Request History",
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
                            controller.searchList.value =  controller.list
                                .where((element) => ((element.accountHolder ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.accountNo ?? "").toLowerCase().contains(value.toLowerCase())||
                                (element.bank ?? "").toLowerCase().contains(value.toLowerCase())||
                                (element.amount ?? 0).toString().toLowerCase().contains(value.toLowerCase())))
                                .toList();
                          } else {
                            controller.searchList.value =  controller.list;
                          }

                        },
                        style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          prefixIcon:  Padding(
                            padding: const EdgeInsets.only(left: 13, right: 13),
                            child: Icon(Icons.search,color: Colors.grey[500],),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.cancel,
                              color: primaryColor,
                            ),
                            onPressed: () {
                              controller.searchController.text = "";
                              controller.searchList.value =  controller.list;
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          hintText: "Search",
                          hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
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
            Expanded(child: (controller.searchList.isNotEmpty && controller.isApiCalled.value==true)?
            ListView.builder(
                itemCount: controller.searchList.length,
                  padding: const EdgeInsets.only(bottom: 10),
                  itemBuilder: (context, index) {
                var item =controller.searchList[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                  decoration:  BoxDecoration(
                    border: Border.all(color: Colors.white),
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                        decoration: const BoxDecoration(
                            color: grayishBlue_alpha_22,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                        child: Row(
                          children: [
                            Expanded(child: Text(item.bank??"",style: poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 12))),
                            Text(Utility.INSTANCE.formatedAmountWithRupees(item.amount??0.0),
                              style: poppins(color: (item.status??"")=="Accepted"?green_2:(item.status??"")=="Requested"?orange_1:(item.status??"")=="Rejected"?red_2:Colors.black,fontSize: 13,fontWeight: FontWeight.w600),)
                          ],
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,10,10,5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Transaction Id : ",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 11)),
                            Container(
                                padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                                decoration:  BoxDecoration(
                                    color: primaryColorLight,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(item.transactionId ?? "",
                                    style: poppins(
                                        color: Colors.black,
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: 11)))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 7),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Account No : ",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 11)),
                            Flexible(child: Text(item.accountNo??"",style: poppins(color: gray_6,fontWeight: FontWeight.w600,fontSize: 11)))
                          ],
                        ),
                      ),
                      Row(
                          children: [
                            widthSpace_10,
                            Expanded(
                              child: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                      text: item.entryDate??"",
                                      style: poppins(color: gray_6,fontSize: 11,fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                            text: "\nRequested Date",
                                            style: poppins(color: gray_4,fontSize: 10,fontWeight: FontWeight.w500))
                                      ]
                                  )),
                            ),
                            widthSpace_5,
                            Expanded(
                              child: RichText(
                                  textAlign: TextAlign.right,
                                  text: TextSpan(
                                      text: item.approveDate??"",
                                      style: poppins(color: gray_6,fontSize: 11,fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                            text: "\nApprove Date",
                                            style: poppins(color: gray_4,fontSize: 10,fontWeight: FontWeight.w500))
                                      ]
                                  )),
                            ),

                            widthSpace_10,
                          ]),
                      heightSpace_10,
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        width:double.infinity,
                        decoration:  BoxDecoration(
                          color: (item.status??"")=="Accepted"?Colors.green[300]:(item.status??"")=="Requested"?Colors.orange[300]:(item.status??"")=="Rejected"?Colors.red[300]:gray_4,
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))
                        ),
                        child: Text(item.status??"",style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 12)),
                      ),

                    ],
                  ),
                );
              }):
            (controller.list.isEmpty && controller.isApiCalled.value==false)?
            ShimmerLoaderView(widget: ListView.builder(
         itemCount: 15,
         itemBuilder: (context, index) {
           return Container(
             margin: const EdgeInsets.only(bottom: 10,right: 10,left: 10),
             height: 151,
             decoration: const BoxDecoration(
                 color: primaryColorLight,
                 borderRadius: BorderRadius.all(Radius.circular(20))
             ),
           );
         },
       )):
            DataNotFoundView(text: controller.filterFromDate==controller.filterToDate?"History is not available for\n${controller.filterFromDate}":"History is not available from\n${controller.filterFromDate} to ${controller.filterToDate}")
            )
          ],
        ))
    );
  }


  void showFilterDialog(context){
    controller.filterFromDateController.text = controller.filterFromDate;
    controller.filterToDateController.text = controller.filterToDate;
    controller.filterStatusController.text = controller.filterStatusValue;


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
                      heightSpace_20,
                      TextField(
                        onTap: () => Utility.INSTANCE.showBottomSheet("Select Status", controller.statusList,false,(String value){

                          controller.filterStatusController.text=value??"";
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
                      heightSpace_25,

                      InkWell(
                          onTap: () async {
                            controller.filterFromDate=controller.filterFromDateController.text.trim();
                            controller.filterToDate=controller.filterToDateController.text.trim();
                            controller.filterStatusValue=controller.filterStatusController.text.trim();
                            controller.filterStatusId=controller.statusList.indexOf(controller.filterStatusValue);

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
}