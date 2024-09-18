
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../widgets/AppBarView.dart';
import '../../widgets/DataNotFoundView.dart';
import '../../widgets/ShimmerLoaderView.dart';
import 'RecentPinActivityController.dart';

class RecentPinActivityPage extends StatelessWidget {

  RecentPinActivityController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: "Login Activity",
        bodyWidget: Obx(() => controller.list.isNotEmpty && controller.isApiCalled.value==true?
        ListView.builder(
          itemCount: controller.list.length,
            padding: const EdgeInsets.only(bottom: 10),
            itemBuilder: (context, index) {
          var item =controller.list[index];
          return Container(
            margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
           padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            decoration: const BoxDecoration(
                color: primaryColorLight,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Row(
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Login At",
                          style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14)),
                      heightSpace_5,
                      Text(item.entryDate??"",
                          style: poppins(color: gray_2,fontWeight: FontWeight.w500,fontSize: 11)),
                      heightSpace_3,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(height: 15,width:15,
                              margin: const EdgeInsets.only(right: 7),
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(color: grayishBlue,
                                  borderRadius: BorderRadius.all(Radius.circular(30))),child: SvgPicture.asset("assets/svg/gps.svg")),
                          Text("IP : ",
                            style: poppins(color: primaryColorMoreLight,fontWeight: FontWeight.w500,fontSize: 12)),
                          Text(item.ip??"",
                              style: poppins(color: lightPurple,fontWeight: FontWeight.w500,fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                ),
                if((item.lastLoginDate??"").isNotEmpty)...[
                  Container(color: grayishBlue_alpha_55,width: 1,height: 50,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Last Login",
                            style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14)),
                        heightSpace_5,
                        Text(item.lastLoginDate??"",
                            style: poppins(color: gray_2,fontWeight: FontWeight.w500,fontSize: 11)),
                        heightSpace_3,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(height: 15,width:15,
                                margin: const EdgeInsets.only(right: 7),
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(color: grayishBlue,
                                    borderRadius: BorderRadius.all(Radius.circular(30))),child: SvgPicture.asset("assets/svg/gps.svg")),
                            Text("IP : ",
                                style: poppins(color: primaryColorMoreLight,fontWeight: FontWeight.w500,fontSize: 12)),
                            Text(item.lastLoginIP??"",
                                style: poppins(color: lightPurple,fontWeight: FontWeight.w500,fontSize: 12)),
                          ],
                        )
                      ],
                    ),
                  )
                ]

              ],
            ),
          );
        }):
        controller.list.isEmpty && controller.isApiCalled.value==false?
        ShimmerLoaderView(widget: ListView.builder(
         itemCount: 15,
         padding:  const EdgeInsets.only(bottom: 10),
         itemBuilder: (context, index) {
           return Container(
             margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
             height: 83,
             decoration: const BoxDecoration(
                 color: primaryColorLight,
                 borderRadius: BorderRadius.all(Radius.circular(20))
             ),
           );
         },
       )):
        const DataNotFoundView(text: "Login Activity is not available"))
    );
  }


}
