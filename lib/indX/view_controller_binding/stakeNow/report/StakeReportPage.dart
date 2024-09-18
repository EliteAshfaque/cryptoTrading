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
import 'StakeReportController.dart';

class StakeReportPage extends StatelessWidget {
  StakeReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: "Staking History",
        bodyWidget: Obx(() =>Column(
          children: [
            Container(
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
                          .where((element) => ((element.symbol ?? "").toLowerCase().contains(value.toLowerCase()) ||
                          "${element.id ??0}".toLowerCase().contains(value.toLowerCase()) ||
                          "${element.stakeAmount ??0}".toLowerCase().contains(value.toLowerCase()) ||
                          (element.entryDate ?? "").toLowerCase().contains(value.toLowerCase()) ||
                          "${element.amountInStakeCurr ??0}".toLowerCase().contains(value.toLowerCase()) ||
                          "${element.roiRate ??0}".toLowerCase().contains(value.toLowerCase()) ||
                          "${element.totalRoiDays ??0}".toLowerCase().contains(value.toLowerCase())))
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
                         heightSpace_10,
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             widthSpace_10,
                             Expanded(
                               child: Text(item.symbol ?? "",
                                   style: poppins(
                                       color: Colors.black,
                                       fontSize: 13,
                                       fontWeight: FontWeight.w600)),
                             ),
                             Container(
                                 margin: const EdgeInsets.only(left: 5,right: 10),
                                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                 decoration:  const BoxDecoration(
                                     color: primaryColorLight,
                                     borderRadius: BorderRadius.all(Radius.circular(8))),
                                 child: Text("Amount : ${Utility.INSTANCE.formatedAmountNinePlace(item.amountInStakeCurr ?? 0.0)}",
                                     style: poppins(
                                         color: Colors.black,
                                         fontSize: 12,
                                         fontWeight: FontWeight.w600))),
                           ],
                         ),

                         Padding(
                           padding: const EdgeInsets.all(10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("In Currency : ",style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 11)),
                               Flexible(child: Text(Utility.INSTANCE.formatedAmountNinePlace(item.stakeAmount ?? 0.0),style: poppins(color: gray_5,fontWeight: FontWeight.w600,fontSize: 11)))
                             ],
                           ),
                         ),
                         Row(
                             children: [
                               widthSpace_10,
                               if((item.totalRoiDays??0.0)>0)...[
                               Expanded(
                                 child: RichText(
                                     textAlign: TextAlign.center,
                                     text: TextSpan(
                                         text: "${item.totalRoiDays ?? 0} Days",
                                         style: poppins(color: gray_6,fontSize: 12,fontWeight: FontWeight.w600),
                                         children: [
                                           TextSpan(
                                               text: "\nTotal Roi Days",
                                               style: poppins(color: gray_4,fontSize: 10,fontWeight: FontWeight.w500))
                                         ]
                                     )),
                               ),
                               widthSpace_5
                               ],
                                if((item.roiRate??0.0)>0)...[
                               Expanded(
                                 child: RichText(
                                     textAlign: TextAlign.center,
                                     text: TextSpan(
                                         text: Utility.INSTANCE.formatedAmountWithOutRupees(item.roiRate ?? 0.0),
                                         style: poppins(color: gray_6,fontSize: 12,fontWeight: FontWeight.w600),
                                         children: [
                                           TextSpan(
                                               text: "\nRoi Rate",
                                               style: poppins(color: gray_4,fontSize: 10,fontWeight: FontWeight.w500))
                                         ]
                                     )),
                               ),
                               widthSpace_5
                               ],
                               Expanded(
                                 child: RichText(
                                     textAlign: TextAlign.center,
                                     text: TextSpan(
                                         text: "${item.tenure ?? 0} Days",
                                         style: poppins(color: gray_6,fontSize: 12,fontWeight: FontWeight.w600),
                                         children: [
                                           TextSpan(
                                               text: "\nTenure",
                                               style: poppins(color: gray_4,fontSize: 10,fontWeight: FontWeight.w500))
                                         ]
                                     )),
                               ),
                               widthSpace_10,
                             ]),
                         Container(
                           margin: const EdgeInsets.symmetric(vertical: 10),
                           padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                           decoration: const BoxDecoration(
                               color: primaryColorLight,
                               borderRadius: BorderRadius.all(  Radius.circular(10))),
                           child: Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               SvgPicture.asset("assets/svg/date_time.svg"),
                               widthSpace_5,
                               Text(Utility.INSTANCE.formatedDateWithSlash(item.entryDate ?? ""),
                                   style: poppins(
                                       color: Colors.black,
                                       fontSize: 12,
                                       fontWeight: FontWeight.w400)),
                             ],
                           ),
                         )



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
                       height: 155,
                       decoration: const BoxDecoration(
                           color: primaryColorLight,
                           borderRadius: BorderRadius.all(Radius.circular(20))),
                     );
                   },
                 )):
              const DataNotFoundView(text: "History is not available"))
          ],
        )));
  }




  
}
