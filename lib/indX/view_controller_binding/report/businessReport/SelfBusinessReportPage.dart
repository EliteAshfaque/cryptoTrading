import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../themes/AppTextTheme.dart';
import '../../../themes/ThemeColor.dart';
import '../../../utils/Utility.dart';
import '../../../widgets/AppBarView.dart';
import '../../../widgets/DataNotFoundView.dart';
import '../../../widgets/ShimmerLoaderView.dart';
import 'SelfBusinessReportController.dart';

class SelfBusinessReportPage extends StatelessWidget {
  SelfBusinessReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: "Self Business Report",
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
                      controller.searchBusinessList.value = controller.businessList
                          .where((element) => ((element.businessType ?? "").toLowerCase().contains(value.toLowerCase()) ||
                          (element.businessDate ?? "").toLowerCase().contains(value.toLowerCase()) ||
                          "${element.packageCost ??0}".toLowerCase().contains(value.toLowerCase())))
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
                                       text: item.businessDate??"",
                                       style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 11),
                                   )
                                 ]
                               )),
                               RichText(textAlign: TextAlign.center,text: TextSpan(
                                   text: "Business\n",
                                   style: poppins(color: grayishBlue,fontWeight: FontWeight.w600,fontSize: 10),
                                   children: [
                                     TextSpan(
                                       text: "${Utility.INSTANCE.getCurrencySymbol(item.businessCurrency??"")} ${Utility.INSTANCE.formatedAmountWithOutRupees(item.packageCost??0.0)}",
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


}
