import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../api/model/balance/BalanceData.dart';
import '../../../themes/AppTextTheme.dart';
import '../../../themes/ThemeColor.dart';
import '../../../themes/ThemeHeightWidth.dart';
import '../../../utils/Utility.dart';
import '../../../widgets/AppBarView.dart';
import '../../../widgets/DataNotFoundView.dart';
import '../../../widgets/ShimmerLoaderView.dart';
import 'LedgerReportController.dart';


class LedgerReportPage extends StatelessWidget {

  LedgerReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: "Account Statement",
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
                                .where((element) => ((element.user ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.description ?? "").toLowerCase().contains(value.toLowerCase())||
                                (element.remark ?? "").toLowerCase().contains(value.toLowerCase())||
                                (element.tid ?? "").toLowerCase().contains(value.toLowerCase())))
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
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,10,10,10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Transaction Id : ",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 11)),
                            Container(
                                padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                                decoration:  BoxDecoration(
                                    color: primaryColorLight,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(item.tid ?? "",
                                    style: poppins(
                                        color: Colors.black,
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: 11)))
                          ],
                        ),
                      ),
                      Row(
                          children: [
                            widthSpace_10,
                            Expanded(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: Utility.INSTANCE.formatedAmountNinePlace(item.lastAmount??0.0),
                                      style: poppins(color: gray_6,fontSize: 12,fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                            text: "\nOpening Balance",
                                            style: poppins(color: gray_4,fontSize: 10,fontWeight: FontWeight.w500))
                                      ]
                                  )),
                            ),
                            widthSpace_5,
                            Expanded(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: Utility.INSTANCE.formatedAmountNinePlace((item.debit??0.0)>0?item.debit??0.0:item.credit??0.0),
                                      style: poppins(color: (item.debit??0)>0?red_2:green_2,fontSize: 12,fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                            text: "\n${(item.debit??0)>0?"Debit Amount":"Credit Amount"}",
                                            style: poppins(color: gray_4,fontSize: 10,fontWeight: FontWeight.w500))
                                      ]
                                  )),
                            ),
                            widthSpace_5,
                            Expanded(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: Utility.INSTANCE.formatedAmountNinePlace(item.curentBalance??0.0),
                                      style: poppins(color: gray_6,fontSize: 12,fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                            text: "\nClosing Balance",
                                            style: poppins(color: gray_4,fontSize: 10,fontWeight: FontWeight.w500))
                                      ]
                                  )),
                            ),
                            widthSpace_10,
                          ]),
                     heightSpace_10,
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Remark : ",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 11)),
                            Flexible(child: Text(item.remark??"",style: poppins(color: gray_6,fontWeight: FontWeight.w600,fontSize: 11)))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Description : ",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 11)),
                            Flexible(child: Text(item.description??"",style: poppins(color: gray_6,fontWeight: FontWeight.w600,fontSize: 11)))
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                        margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        decoration: const BoxDecoration(
                            color: primaryColorLight,
                            borderRadius: BorderRadius.all(  Radius.circular(10))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset("assets/svg/date_time.svg"),
                            widthSpace_5,
                            Text(item.entryDate ?? "",
                                style: poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      )
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
             height: 175,
             decoration: const BoxDecoration(
                 color: primaryColorLight,
                 borderRadius: BorderRadius.all(Radius.circular(20))
             ),
           );
         },
       )):
            const DataNotFoundView(text: "Report is not available")
            )
          ],
        ))
    );
  }


  void showFilterDialog(context){
    BalanceData selectedWallet = controller.parentItem;
    String selectedTop="50";
    controller.filterFromDateController.text = controller.filterFromDate;
    controller.filterToDateController.text = controller.filterToDate;
    controller.filterTxnIdController.text = controller.filterTxnId;
    controller.filterWalletTypeController.text = controller.filterWalletType;
    controller.filterTopRowController.text = controller.filterTopRow;

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
                            suffixIcon: Icon(
                              Icons.person_outlined,
                              color: Colors.grey[500],
                            ),

                           /* errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),*/
                            hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                            hintText: "Enter Transaction Id",
                            fillColor: Colors.white),
                      ),
                      heightSpace_15,
                      TextField(
                        onTap: () => Utility.INSTANCE.showBottomSheet("Select Wallet", controller.walletList,false,(BalanceData value){
                          selectedWallet=value;
                          controller.filterWalletTypeController.text=value.walletType??"";
                        }),
                        controller: controller.filterWalletTypeController,
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
                          selectedTop=value;
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
                            controller.filterTxnId=controller.filterTxnIdController.text.trim();
                            controller.filterWalletType=selectedWallet.walletType??"";
                            controller.filterWalletTypeId=selectedWallet.id??0;
                            controller.filterTopRow=selectedTop;

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
