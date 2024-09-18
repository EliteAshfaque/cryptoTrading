
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import '../../widgets/BannerPageView.dart';
import '../../widgets/ShimmerLoaderView.dart';
import 'InviteReferralController.dart';

class InviteReferralPage extends StatelessWidget {

  InviteReferralController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: AppBarView(
        titleText: "Refer & Earn",
        isImageTitle: false,
        bodyWidget: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Obx(() =>  Column(
            children: [
              if(controller.loginResponse.isReferral==true)...[
                if(controller.isApiCalled.value==true && (controller.referralData.value.refferalLink??"").isNotEmpty)...[
                  if(controller.referralData.value.refferalImage!=null && controller.referralData.value.refferalImage!.isNotEmpty)...[
                    BannerPageView(bannerList: controller.referralData.value.refferalImage!,height: 220,isSiteUrl: true,)
                  ]else...[
                    SvgPicture.asset("assets/svg/referral_bg.svg",fit: BoxFit.fitWidth,width: size.width-30),
                  ],
                  heightSpace_30,
                  if(controller.referralData.value.refferalContent!=null && controller.referralData.value.refferalContent!.isNotEmpty)...[
                    Text(controller.referralData.value.refferalContent??"",
                        textAlign: TextAlign.center,
                        style: poppins(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700))
                  ]else...[
                    Text(controller.content1,
                        textAlign: TextAlign.center,
                        style: poppins(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700)),
                    heightSpace_10,
                    Text(controller.content2,
                        textAlign: TextAlign.center,
                        style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500)),
                  ]

                ]else...[
                  ShimmerLoaderView(widget: Column(
                    children: [
                      Container(color: primaryColorLight,
                        width: double.infinity,
                        height: 220,),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        color: primaryColorLight,
                        width: 250,
                        height: 20,),
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        color: primaryColorLight,
                        width: 190,
                        height: 20,),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        color: primaryColorLight,
                        width: 280,
                        height: 10,),
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        color: primaryColorLight,
                        width: 220,
                        height: 10,)
                    ],
                  ),)
                ]
              ]
              else...[
                SvgPicture.asset("assets/svg/referral_bg.svg",fit: BoxFit.fitWidth,width: size.width-30),
                heightSpace_30,
                Text(controller.content1,
                    textAlign: TextAlign.center,
                    style: poppins(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700)),
                heightSpace_10,
                Text(controller.content2,
                    textAlign: TextAlign.center,
                    style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500)),
              ],
              if(controller.isApiCalled.value==true)...[
                heightSpace_20,
                Text("Share",
                    textAlign: TextAlign.center,
                    style: poppins(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w700)),
                heightSpace_10,
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  GestureDetector(
                    onTap: () => Utility.INSTANCE.urlLaunch("https://www.facebook.com/sharer/sharer.php?u=${controller.shareLink}&quote=${controller.shareMsg}"),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: SvgPicture.asset("assets/svg/facebook.svg",width: 35,height: 35),),
                  ),
                  GestureDetector(
                    onTap: () => Utility.INSTANCE.urlLaunch("https://wa.me?text=${controller.shareMsg}\n${controller.shareLink}"),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: SvgPicture.asset("assets/svg/whatsapp.svg",width: 35,height: 35),),
                  ),
                  GestureDetector(
                    onTap: () => Utility.INSTANCE.urlLaunch("https://telegram.me/share/url?url=${controller.shareLink}&text=${controller.shareMsg}"),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: SvgPicture.asset("assets/svg/telegram.svg",width: 35,height: 35),),
                  ),
                  GestureDetector(
                    onTap: () => Utility.INSTANCE.urlLaunch("https://twitter.com/intent/tweet?text=${controller.shareMsg}\n${controller.shareLink}"),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: SvgPicture.asset("assets/svg/twitter.svg",width: 35,height: 35),),
                  ),
                  GestureDetector(
                    onTap: () async =>  await FlutterShare.share(
                        title: 'Refer & Earn',
                        text: controller.shareMsg,
                        linkUrl: controller.shareLink,
                        chooserTitle: 'Refer To Your Friends & Earn'),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: primaryColorLight,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: SvgPicture.asset("assets/svg/share.svg",width: 35,height: 35)),
                  ),
                ],)
              ],

            ],
          )),
        ),
      ),
    );
  }

  List <Widget> listWidget(String first, String second, int type) {
   /* type =1 call;
    type =2 whatsapp;
    type =3 email;*/
    var list = controller.stringToList(first, second);
    return List.generate(list.length, (index) {
      var item =list[index];
      return InkWell(
        onTap: () {
          if(type==1){
            Utility.INSTANCE.urlLaunch("tel:$item");
          }else if(type==2){
            Utility.INSTANCE.urlLaunch("https://api.whatsapp.com/send?phone=$item");
          }else{
            Utility.INSTANCE.urlLaunch("mailto:$item");
          }
        } ,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(item,style: poppins(fontWeight: FontWeight.w500,fontSize: 14,color: grayishBlue)),
        ),
      );
    });
  }

}
