import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../themes/AppTextTheme.dart';
import '../../../themes/ThemeColor.dart';
import '../../../utils/Utility.dart';
import '../../../widgets/AppBarView.dart';
import '../../../widgets/DataNotFoundView.dart';
import '../../../widgets/ShimmerLoaderView.dart';
import 'TeamReportController.dart';

class TeamReportPage extends StatelessWidget {
  TeamReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: controller.leg == "L" ? "Left Team" : controller.leg == "R" ? "Right Team" : "Total Team",
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
                                .where((element) => ((element.userName ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.sponserName ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.leg ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                (element.parentName ?? "").toLowerCase().contains(value.toLowerCase()) ||
                                "${element.introducedBy ?? 0}".toLowerCase().contains(value.toLowerCase()) ||
                                "${element.userId ?? 0}".toLowerCase().contains(value.toLowerCase()) ||
                                "${element.referalID ?? 0}".toLowerCase().contains(value.toLowerCase())))
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
                          border: InputBorder.none,
                        )),
                  ),
                ),
                if (controller.leg == "All")
                  GestureDetector(
                    onTap: () => Utility.INSTANCE.showBottomSheet("Select Leg", controller.legList,false, (String value) {
                      controller.filterLeg.value = value.contains("Left") ? "L" : value.contains("Right") ? "R" : "All";
                      controller.getTotalTeam(true);
                    }),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(11, 13, 6, 13),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                      child: Row(
                        children: [
                          Text(
                              controller.filterLeg.value == "L" ? "Left" : controller.filterLeg.value == "R" ? "Right" : "All",
                              style: poppins(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 18,
                            color: primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
             Expanded(child: (controller.searchTeamList.isNotEmpty && controller.isApiCalled.value == true)?
             ListView.builder(
                 itemCount: controller.searchTeamList.length,
                 padding: const EdgeInsets.only(bottom: 10),
                 itemBuilder: (context, index) {
                   var item = controller.searchTeamList[index];
                   return Container(
                     margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
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
                                 child: Text(item.userName ?? "",
                                     style: poppins(
                                         color: Colors.white,
                                         fontSize: 13,
                                         fontWeight: FontWeight.w600)),
                               ),
                               if(item.leg!=null && item.leg!.isNotEmpty)
                                 Container(
                                     margin: const EdgeInsets.only(left: 5),
                                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                     decoration:  BoxDecoration(
                                         color: item.leg=="Left"?green_3:orange_2,
                                         borderRadius: const BorderRadius.all(Radius.circular(8))),
                                     child: Text(item.leg ?? "",
                                         style: poppins(
                                             color: Colors.white,
                                             fontSize: 12,
                                             fontWeight: FontWeight.w600))),
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(10),
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
                           padding: const EdgeInsets.all(10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Referral Id : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                               Flexible(child: Text("${item.referalID??0}",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                             ],
                           ),
                         ),
                         const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                         Padding(
                           padding: const EdgeInsets.all(10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Parent Name : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                               Flexible(child: Text(item.parentName??"",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                             ],
                           ),
                         ),
                         const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                         Padding(
                           padding: const EdgeInsets.all(10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Sponsor Name : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                               Flexible(child: Text(item.sponserName??"",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                             ],
                           ),
                         ),
                         const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                         Padding(
                           padding: const EdgeInsets.all(10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Introduced By : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                               Flexible(child: Text("${item.introducedBy??0}",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
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
                   padding: const EdgeInsets.only(bottom: 10),
                   itemBuilder: (context, index) {
                     return Container(
                       margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                       height: 230,
                       decoration: const BoxDecoration(
                           color: primaryColorLight,
                           borderRadius: BorderRadius.all(Radius.circular(20))),
                     );
                   },
                 )):
             DataNotFoundView(
                 text: controller.filterLeg.value == "L"
                     ? "Left team is not available"
                     : controller.filterLeg.value == "R"
                     ? "Right team is not available"
                     : "Team is not available"))
          ],
        )));
  }
}
