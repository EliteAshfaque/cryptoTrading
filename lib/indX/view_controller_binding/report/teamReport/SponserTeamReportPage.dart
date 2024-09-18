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
import 'SponserTeamReportController.dart';


class SponserTeamReportPage extends StatelessWidget {
  SponserTeamReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: "Sponsor Team",
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
                            controller.searchTeamList.value = controller.teamList
                                .where((element) => ((element.username ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.status ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.registerDate ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.activationDate ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                "${element.levelNo ?? 0}".toLowerCase().contains(value.toLowerCase()) ||
                                "${element.userId ?? 0}".toLowerCase().contains(value.toLowerCase())))
                                .toList();
                          } else {
                            controller.searchTeamList.value = controller.teamList;
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
                              controller.searchTeamList.value = controller.teamList;
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          hintText: "Search",
                          hintStyle: poppins(
                              color: Colors.grey[500]!,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          border: InputBorder.none
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
             Expanded(child: (controller.searchTeamList.isNotEmpty && controller.isApiCalled.value == true)?
             ListView.builder(
                 itemCount: controller.searchTeamList.length,
                 itemBuilder: (context, index) {
                   var item = controller.searchTeamList[index];
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
                                 child: Text(item.username ?? "",
                                     style: poppins(
                                         color: Colors.white,
                                         fontSize: 13,
                                         fontWeight: FontWeight.w600)),
                               ),
                                 Container(
                                     margin: const EdgeInsets.only(left: 5),
                                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                     decoration:  BoxDecoration(
                                         color: item.status=="Deactive"?red_2:green_3,
                                         borderRadius: const BorderRadius.all(Radius.circular(8))),
                                     child: Text(item.status ?? "",
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
                               Text("User Id : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                               Flexible(child: Text("${item.userId??0}",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                             ],
                           ),
                         ),
                         const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Level No : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                               Container(
                                   padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                                   decoration: const BoxDecoration(
                                       color: primaryColor,
                                       borderRadius:
                                       BorderRadius.all(
                                           Radius.circular(8))),
                                   child: Text("${item.levelNo??0}",
                                       style: poppins(
                                           color: gray_1,
                                           fontWeight:
                                           FontWeight.w500,
                                           fontSize: 11)))
                             ],
                           ),
                         ),
                         const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Package : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                               Container(
                                 padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                                   decoration: const BoxDecoration(
                                                  color: green_1,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                   child: Text(Utility.INSTANCE.formatedAmountWithOutRupees(item.packageCost ?? 0),
                                       style: poppins(
                                           color: gray_1,
                                           fontWeight:
                                           FontWeight.w500,
                                           fontSize: 11)))
                                        ],
                           ),
                         ),
                         const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Register Date : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                               Flexible(child: Text(Utility.INSTANCE.formatedDateWithSlash(item.registerDate??""),style: poppins(color: red_2,fontWeight: FontWeight.w500,fontSize: 11)))
                             ],
                           ),
                         ),
                         const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                         Padding(
                           padding: const EdgeInsets.fromLTRB(10,6,10,12),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Activate Date : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                               Flexible(child: Text(Utility.INSTANCE.formatedDateWithSlash(item.activationDate??""),style: poppins(color: green_2,fontWeight: FontWeight.w500,fontSize: 11)))
                             ],
                           ),
                         ),
                       ],
                     ),
                   );
                 }):
             (controller.searchTeamList.isEmpty && controller.isApiCalled.value == false)?
             ShimmerLoaderView(
                 widget: ListView.builder(
                   itemCount: 6,
                   itemBuilder: (context, index) {
                     return Container(
                       margin:
                       const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                       height: 195,
                       decoration: const BoxDecoration(
                           color: primaryColorLight,
                           borderRadius:
                           BorderRadius.all(Radius.circular(20))),
                     );
                   },
                 )):
             const DataNotFoundView(
                 text: "Direct team is not available"))
          ],
        )));
  }




  void showFilterDialog(context){

   /* controller.filterFromDateController.text = controller.filterFromDate;
    controller.filterToDateController.text = controller.filterToDate;*/
    controller.filterLevelController.text = controller.filterLevelNo=="0"?"All":controller.filterLevelNo;
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
                            ),
                          ),
                          widthSpace_10,
                          Expanded(
                            child: TextField(
                              onTap: () =>Utility.INSTANCE.showBottomSheet("Select Status", controller.statusList,false, ( String value){
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
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                  suffixIcon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey[500],
                                  ),

                                  /*errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),*/
                                  hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                                  hintText: "Select Status",
                                  fillColor: Colors.white),
                            ),
                          ),
                        ],
                      ),




                      heightSpace_15,
                      InkWell(
                          onTap: () async {
                            /* controller.filterFromDate=controller.filterFromDateController.text.trim();
                            controller.filterToDate=controller.filterToDateController.text.trim();*/
                            controller.filterLevelNo=controller.filterLevelController.text.trim()=="All"?"0":controller.filterLevelController.text.trim();
                            controller.filterStatus=controller.filterStatusController.text.trim();

                            Get.back();
                            controller.getSponserTeam(true);

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
