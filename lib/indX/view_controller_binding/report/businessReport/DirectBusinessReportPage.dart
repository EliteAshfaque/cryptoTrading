import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'DirectBusinessReportController.dart';

class DirectBusinessReportPage extends StatelessWidget {
  DirectBusinessReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: "Direct Business Report",
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
                            controller.searchBusinessList.value = controller.businessList
                                .where((element) => ((element.businessType ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.businessDate ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                "${element.userId ??0}".toLowerCase().contains(value.toLowerCase())||
                                "${element.amount ??0}".toLowerCase().contains(value.toLowerCase())))
                                .toList();
                          } else {
                            controller.searchBusinessList.value = controller.businessList;
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
                              controller.searchBusinessList.value = controller.businessList;
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
             Expanded(child: (controller.searchBusinessList.isNotEmpty && controller.isApiCalled.value == true)?
             ListView.builder(
                 itemCount: controller.searchBusinessList.length,
                 itemBuilder: (context, index) {
                   var item = controller.searchBusinessList[index];
                   return Container(
                     margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                     decoration: const BoxDecoration(
                         color: primaryColorLight,
                         borderRadius: BorderRadius.all(Radius.circular(20))),
                     child: Column(
                       children: [
                         Container(
                           width: double.infinity,
                           padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                           decoration: const BoxDecoration(
                               color: grayishBlue_alpha_22,
                               borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                           child: Text(item.businessType ?? "",
                               style: poppins(
                                   color: Colors.white,
                                   fontSize: 13,
                                   fontWeight: FontWeight.w600)),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               RichText(textAlign: TextAlign.center,text: TextSpan(
                                 text: "Date\n",
                                 style: poppins(color: grayishBlue,fontWeight: FontWeight.w600,fontSize: 10),
                                 children: [
                                   TextSpan(
                                       text: item.activationDate??"",
                                       style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 11),
                                   )
                                 ]
                               )),
                               RichText(textAlign: TextAlign.center,text: TextSpan(
                                   text: "Business\n",
                                   style: poppins(color: grayishBlue,fontWeight: FontWeight.w600,fontSize: 10),
                                   children: [
                                     TextSpan(
                                       text: Utility.INSTANCE.formatedAmountWithOutRupees(item.amount??0.0),
                                       style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 11),
                                     )
                                   ]
                               ))
                             ],
                           ),
                         ),



                       ],
                     ),
                   );
                 }):
             (controller.searchBusinessList.isEmpty && controller.isApiCalled.value == false)?
             ShimmerLoaderView(
                 widget: ListView.builder(
                   itemCount: 6,
                   itemBuilder: (context, index) {
                     return Container(
                       margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                       height: 90,
                       decoration: const BoxDecoration(
                           color: primaryColorLight,
                           borderRadius: BorderRadius.all(Radius.circular(20))),
                     );
                   },
                 )):
              const DataNotFoundView(
                 text: "Business is not available"))
          ],
        )));
  }

  void showFilterDialog(context){
    int selectedOPID=controller.filterOPID;
    controller.filterFromDateController.text = controller.filterFromDate;
    controller.filterToDateController.text = controller.filterToDate;
    controller.filterBusinessTypeController.text = controller.filterBusinessType;

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

                        heightSpace_10,
                        TextField(
                          onTap: () => Utility.INSTANCE.showBottomSheet("Select Business Type", controller.opidList,false, ( ReportData value){
                            controller.filterBusinessTypeController.text= "${value.name ?? 0}";
                            selectedOPID=value.oid??0;
                          }),
                          controller: controller.filterBusinessTypeController,
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
                              hintText: "Select Business Type",
                              fillColor: Colors.white),
                        ),

                      heightSpace_15,
                      InkWell(
                          onTap: () async {
                            controller.filterFromDate=controller.filterFromDateController.text.trim();
                            controller.filterToDate=controller.filterToDateController.text.trim();
                            controller.filterBusinessType=controller.filterBusinessTypeController.text.trim();
                            controller.filterOPID=selectedOPID;

                            Get.back();
                            controller.getBusinessReport(true);

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
