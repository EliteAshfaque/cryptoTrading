import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../api/model/report/ReportData.dart';
import '../../../themes/AppTextTheme.dart';
import '../../../themes/ThemeColor.dart';
import '../../../themes/ThemeHeightWidth.dart';
import '../../../utils/Utility.dart';
import '../../../widgets/AppBarView.dart';
import '../../../widgets/DataNotFoundView.dart';
import '../../../widgets/ShimmerLoaderView.dart';
import 'IncomeReportController.dart';

class IncomeReportPage extends StatelessWidget {
  IncomeReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: "${controller.incomeDetails.incomeName ?? ""} Report",
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
                            controller.searchIncomeList.value = controller.incomeList
                                .where((element) => ((element.incomeName ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.incomeOPID ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.name ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.entryDate ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.payoutDate ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.levelNo ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                "${element.tid ??0}".toLowerCase().contains(value.toLowerCase())))
                                .toList();
                          } else {
                            controller.searchIncomeList.value = controller.incomeList;
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
                              controller.searchIncomeList.value = controller.incomeList;
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
             Expanded(child: (controller.searchIncomeList.isNotEmpty && controller.isApiCalled.value == true)?
             ListView.builder(
                 itemCount: controller.searchIncomeList.length,
                 itemBuilder: (context, index) {
                   var item = controller.searchIncomeList[index];
                   return Container(
                     margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                     decoration: const BoxDecoration(
                         color: primaryColorLight,
                         borderRadius: BorderRadius.all(Radius.circular(20))),
                     child: Column(
                       children: [
                         Container(
                           padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                           decoration: const BoxDecoration(
                               color: grayishBlue_alpha_22,
                               borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Flexible(
                                 child: Text(item.name ?? "",
                                     style: poppins(
                                         color: Colors.white,
                                         fontSize: 13,
                                         fontWeight: FontWeight.w600)),
                               ),
                               Container(
                                   margin: const EdgeInsets.only(left: 5),
                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                   decoration:  const BoxDecoration(
                                       color: green_3,
                                       borderRadius: BorderRadius.all(Radius.circular(8))),
                                   child: Text("Credit : ${Utility.INSTANCE.formatedAmountWithOutRupees(item.creditedAmount ?? 0.0)}",
                                       style: poppins(
                                           color: Colors.white,
                                           fontSize: 12,
                                           fontWeight: FontWeight.w600))),
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Transaction Id : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                               Flexible(child: Text("${item.tid??0}",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                             ],
                           ),
                         ),
                         if((item.fromName??"").isNotEmpty)...[
                           const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("From User : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                 Flexible(child: Text((item.fromUserId??"").isNotEmpty? "${item.fromName ?? ""} (${item.fromUserId ?? ""})":item.fromName ?? "",
                                       style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)),
                                 )
                               ],
                             ),
                           )
                         ],
                         const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Income : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                               Flexible(
                                 child: Text("${Utility.INSTANCE.getCurrencySymbol(controller.defaultSymbol)} ${Utility.INSTANCE.formatedAmountWithOutRupees(item.binaryIncome??0.0)}",
                                     style: poppins(color: orange_1,fontWeight: FontWeight.w500,fontSize: 11)),
                               )
                             ],
                           ),
                         ),
                         if((item.incomeName??"").isNotEmpty)...[
                           const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("Income Name : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                 Container(
                                     padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                                     decoration: const BoxDecoration(
                                         color: primaryColor,
                                         borderRadius:
                                         BorderRadius.all(
                                             Radius.circular(8))),
                                     child: Text(item.incomeName ?? "",
                                         style: poppins(
                                             color: gray_1,
                                             fontWeight:
                                             FontWeight.w500,
                                             fontSize: 11)))
                               ],
                             ),
                           ),
                         ],
                         if((item.lapsIncome??"").isNotEmpty && double.parse(item.lapsIncome??"0")>0)...[
                           const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("Laps Income : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                 Container(
                                     padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                                     decoration: const BoxDecoration(
                                         color: primaryColor,
                                         borderRadius:
                                         BorderRadius.all(
                                             Radius.circular(8))),
                                     child: Text("${Utility.INSTANCE.getCurrencySymbol(controller.defaultSymbol)} ${Utility.INSTANCE.formatedAmountWithOutRupees(item.lapsIncome??"0.0")}",
                                         style: poppins(
                                             color: gray_1,
                                             fontWeight:
                                             FontWeight.w500,
                                             fontSize: 11)))
                               ],
                             ),
                           )
                         ],
                         if((item.adminCharge??"").isNotEmpty && double.parse(item.adminCharge??"0")>0)...[
                           const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("Admin Charge : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                 Container(
                                     padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                                     decoration: const BoxDecoration(
                                         color: primaryColor,
                                         borderRadius:
                                         BorderRadius.all(
                                             Radius.circular(8))),
                                     child: Text("${Utility.INSTANCE.getCurrencySymbol(controller.defaultSymbol)} ${Utility.INSTANCE.formatedAmountWithOutRupees(item.adminCharge??"0.0")}",
                                         style: poppins(
                                             color: gray_1,
                                             fontWeight:
                                             FontWeight.w500,
                                             fontSize: 11)))
                               ],
                             ),
                           )
                         ],
                         if((item.fromTeamOf??"").isNotEmpty)...[
                           const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("From Team Of : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                 Flexible(
                                   child: Text(item.fromTeamOf ?? "",
                                       style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)),
                                 )
                               ],
                             ),
                           )
                         ],
                         if((item.levelNo??"").isNotEmpty && int.parse(item.levelNo??"0")>0)...[
                           const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("Level : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                 Container(
                                     padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                                     decoration: const BoxDecoration(
                                         color: orange_2,
                                         borderRadius:
                                         BorderRadius.all(
                                             Radius.circular(8))),
                                     child: Text(item.levelNo ?? "",
                                         style: poppins(
                                             color: gray_1,
                                             fontWeight:
                                             FontWeight.w500,
                                             fontSize: 11)))
                               ],
                             ),
                           )
                         ],
                         if (double.parse(item.totalRightBusiness ?? "0") > 0 || double.parse(item.totalLeftBusiness ?? "0") > 0 || double.parse(item.todayMatchBusiness ?? "0") > 0) ...[
                           Container(
                               padding: const EdgeInsets.symmetric(vertical: 8),
                               margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                               decoration: const BoxDecoration(color: primaryColor, borderRadius: BorderRadius.all(Radius.circular(8))),
                               child: Row(children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 2,
                                                          horizontal: 8),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 3),
                                                      decoration: const BoxDecoration(
                                                          color: accentColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                      child: Text(
                                                          "Left Business",
                                                          style: poppins(
                                                              color: gray_1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 10))),
                                                  Text(Utility.INSTANCE.formatedAmountWithOutRupees(item.totalLeftBusiness ??"0.0"),
                                                      style: poppins(
                                                          color: orange_2,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 10)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                color: primaryColorLight,
                                                width: 1,
                                                height: 30),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                                      margin:
                                                          const EdgeInsets.only(bottom: 3),
                                                      decoration: const BoxDecoration(
                                                          color: grayishBlue,
                                                          borderRadius: BorderRadius.all(Radius.circular(8))),
                                                      child: Text(
                                                          "Right Business",
                                                          style: poppins(
                                                              color: gray_1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 10))),
                                                  Text(
                                                      Utility.INSTANCE.formatedAmountWithOutRupees(item.totalRightBusiness ?? "0.0"),
                                                      style: poppins(
                                                          color: green_3,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 10)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                color: primaryColorLight,
                                                width: 1,
                                                height: 30),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 2,
                                                          horizontal: 8),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 3),
                                                      decoration: const BoxDecoration(
                                                          color: green_7,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                      child: Text(
                                                          "Matching Business",
                                                          style: poppins(
                                                              color: gray_1,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 10))),
                                                  Text(
                                                      Utility.INSTANCE.formatedAmountWithOutRupees(item.todayMatchBusiness ?? "0.0"),
                                                      style: poppins(
                                                          color: red_2,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 10)),
                                                ],
                                              ),
                                            )
                                          ])),
                         ],

                         if(item.entryDate==item.payoutDate)...[
                           Container(
                             alignment: Alignment.centerRight,
                             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                             decoration: const BoxDecoration(
                                 color: grayishBlue_alpha_22,
                                 borderRadius: BorderRadius.vertical(bottom:  Radius.circular(20))),
                             child: Container(
                               padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                               decoration: const BoxDecoration(
                                   color: primaryColor,
                                   borderRadius: BorderRadius.all(  Radius.circular(10))),
                               child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   SvgPicture.asset("assets/svg/date_time.svg"),
                                   widthSpace_5,
                                   Text(Utility.INSTANCE.formatedDateWithSlash(item.entryDate ?? ""),
                                       style: poppins(
                                           color: Colors.white,
                                           fontSize: 12,
                                           fontWeight: FontWeight.w400)),
                                 ],
                               ),
                             ),
                           ),
                         ]else...[
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("Entry Date : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                 Flexible(child: Text(Utility.INSTANCE.formatedDateWithSlash(item.entryDate??""),style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                               ],
                             ),
                           ),
                           const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                           Padding(
                             padding: const EdgeInsets.fromLTRB(10,6,10,12),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("Payout Date : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                 Flexible(child: Text(Utility.INSTANCE.formatedDateWithSlash(item.payoutDate??""),style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                               ],
                             ),
                           ),
                         ]


                       ],
                     ),
                   );
                 }):
             (controller.searchIncomeList.isEmpty && controller.isApiCalled.value == false)?
             ShimmerLoaderView(
                 widget: ListView.builder(
                   itemCount: 6,
                   itemBuilder: (context, index) {
                     return Container(
                       margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                       height: 200,
                       decoration: const BoxDecoration(
                           color: primaryColorLight,
                           borderRadius: BorderRadius.all(Radius.circular(20))),
                     );
                   },
                 )):
              DataNotFoundView(
                 text: "${controller.incomeDetails.incomeName ?? ""} is not available"))
          ],
        )));
  }

  void showFilterDialog(context){

    controller.filterFromDateController.text = controller.filterFromDate;
    controller.filterToDateController.text = controller.filterToDate;
    controller.filterLevelController.text = controller.filterLevelNo=="0"?"All":controller.filterLevelNo;


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
                                      child: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30.0),
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
                                      child: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30.0),
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
                          if(controller.incomeDetails.incomeCategoryID==1) ...[
                        heightSpace_10,
                        TextField(
                          onTap: () => Utility.INSTANCE.showBottomSheet("Select Level No", controller.levelList,true, ( ReportData value){
                            controller.filterLevelController.text= value.levelNo==0?"All":"${value.levelNo ?? 0}";
                          }),
                          controller: controller.filterLevelController,
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
                              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey[500],
                              ),

                              /*errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),*/
                              hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                              hintText: "Select Level No",
                              fillColor: Colors.white),
                        )
                      ],

                      heightSpace_15,
                      InkWell(
                          onTap: () async {
                            controller.filterFromDate=controller.filterFromDateController.text.trim();
                            controller.filterToDate=controller.filterToDateController.text.trim();
                            controller.filterLevelNo=controller.filterLevelController.text.trim()=="All"?"0":controller.filterLevelController.text.trim();

                            Get.back();
                            controller.getIncomeReport(true);

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
                          ))
                    ],
                  )),


            ],
          ),
        ));
  }
}
