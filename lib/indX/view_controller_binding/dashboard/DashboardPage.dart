import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../api/model/balance/AllowedWithdrawalType.dart';
import '../../api/model/balance/BalanceData.dart';
import '../../api/model/currencyList/AllowTransferMapping.dart';
import '../../api/model/currencyList/LiveRateData.dart';
import '../../common/ConstantString.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/CachePlaceHolderImage.dart';
import 'DashboardController.dart';

class DashboardPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DashboardController controller=Get.find();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            /*automaticallyImplyLeading: false,*/
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: gray_2,
            titleSpacing: /*3*/15,
            title:  SvgPicture.asset("assets/svg/logo.svg", height: 30),
          ),
          body: RefreshIndicator(
            backgroundColor: gray_2,
            onRefresh: () => controller.onRefresh(),
            child:SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.profile),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10,10,10,10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: IntrinsicHeight (
                        child: Row(
                          children: [
                            SizedBox(
                              width: (controller.screenWidth-20)/1.7,
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  SvgPicture.asset("assets/svg/profile_card_bg.svg",fit: BoxFit.fill,height: double.infinity,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10,10,28,7),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        if(controller.liveRateCryptoList.isNotEmpty)...[
                                          Text("Live Price",style: poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600)),
                                          heightSpace_3,
                                          Wrap(
                                            runSpacing: 10,
                                            spacing: 10,
                                            children: List.generate(controller.liveRateCryptoList.length, (index) {
                                              var item =controller.liveRateCryptoList[index];
                                              var fromCurrId=item.id??0;
                                              var toCurrId=controller.balanceResponse.value.defaultCurrencyId??0;
                                              if (!controller.currencyLiveRateMap.containsKey("$fromCurrId-$toCurrId")) {
                                                controller.getLiveRate(fromCurrId, toCurrId);
                                              }
                                              return Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CachePlaceHolderImage(
                                                      imageUrl: item.imageUrls??"",
                                                      imgaeWidth: 35,
                                                      imageHeight: 35,
                                                      errorColorBackground: Colors.transparent,
                                                      errorIconHeight: 35),
                                                  widthSpace_10,
                                                  Flexible(
                                                    child: RichText(
                                                        softWrap: true,
                                                        text:TextSpan(
                                                            text: '${item.currencyName??""} Token Price\n',
                                                            style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w400),
                                                            children: [
                                                              TextSpan(
                                                                text: "${Utility.INSTANCE.getCurrencySymbol(controller.balanceResponse.value.defaultCurrencySymbol??"")} ",
                                                                style: poppins(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),
                                                              ),
                                                              TextSpan(
                                                                text: "${controller.currencyLiveRateMap.containsKey("$fromCurrId-$toCurrId")?
                                                                (Utility.INSTANCE.formatedAmountWithOutRupees(controller.currencyLiveRateMap["$fromCurrId-$toCurrId"]!.liveRate??0.0)):0.0}",
                                                                style: poppins(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),
                                                              ),
                                                            ]
                                                        )

                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ),
                                          heightSpace_5
                                        ],
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(onPressed: () => Get.toNamed(AppRoutes.swap)!.then((value){
                                                if(controller.isBalCryptoApi==false) {
                                                  controller.balance(true);
                                                  controller.currencyList(true, null);
                                                }else{
                                                  controller.isBalCryptoApi=false;
                                                }
                                              }),
                                                  style: ElevatedButton.styleFrom(
                                                      padding: const EdgeInsets.symmetric(horizontal: 3),
                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(5))),
                                                      backgroundColor: Colors.white,
                                                      minimumSize: const Size.fromHeight(30)
                                                 ),
                                                  child: Text("Sell",style: poppins(color: primaryColor,fontSize: 10,fontWeight: FontWeight.w600))),
                                            ),
                                            widthSpace_2,
                                            Expanded(
                                              child: ElevatedButton(onPressed: () => Get.toNamed(AppRoutes.swapReport),
                                                  style: ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(5))),
                                                      backgroundColor: Colors.white,
                                                      minimumSize: const Size.fromHeight(30)
                                                  ),
                                                  child: Text("Sell History",style: poppins(color: primaryColor,fontSize: 10,fontWeight: FontWeight.w600))),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10,right: 10,bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CachePlaceHolderImage(imageUrl: "$BASE_PROFILE_PIC_URL${controller.loginResponse.data!.userID}.png",
                                        imgaeWidth: 50,
                                        imageHeight: 50,
                                        errorColorBackground: Colors.transparent,
                                        errorIconHeight: 50,
                                        errorCustomWidget: SvgPicture.asset("assets/svg/user_pic.svg",width: 40,height: 40,)),
                                    Text(controller.loginResponse.data!=null ?controller.loginResponse.data!.name??"":"",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12)),
                                    heightSpace_3,
                                    if(controller.loginResponse.data!=null)...[
                                      RichText(text: TextSpan(
                                          text: "User Id : ",
                                          style: poppins(
                                              color: gray_5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                          children: [
                                            TextSpan(
                                                text: "${(controller.loginResponse.data!.prefix??"").toUpperCase()}${controller.loginResponse.data!.userID??0}",
                                                style: poppins(
                                                    color: accentColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 13)
                                            )
                                          ]
                                      ))
                                    ],
                                    heightSpace_3,
                                    /* Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                      decoration:  BoxDecoration(
                                          color: controller.balanceResponse.value.isTopup==1?green_2:Colors.red[300],
                                          borderRadius: const BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(controller.balanceResponse.value.isTopup==1?"assets/svg/verify.svg":"assets/svg/unverify.svg",width: 18,height: 18),
                                          widthSpace_5,
                                          Text(controller.loginResponse.data!=null ?"${(controller.loginResponse.data!.prefix??"").toUpperCase()}${controller.loginResponse.data!.userID??0}":"",
                                              style: poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13)),
                                        ],
                                      ),
                                    ),
                                    heightSpace_3,*/
                                    Text(controller.loginResponse.data!=null ?controller.loginResponse.data!.emailID??"":"",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: poppins(
                                            color: gray_4,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10)),

                                    /* RichText(text: TextSpan(text: controller.loginResponse.data!=null ?controller.loginResponse.data!.emailID??"":"",
                                        style: poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                        children: [
                                          if(controller.balanceResponse.value.isEmailVerified==false)
                                            TextSpan(
                                              text: ' Verify',
                                              style: poppins(color: Colors.orange,fontSize: 9,fontWeight: FontWeight.w700),
                                              recognizer: TapGestureRecognizer()..onTap = () {
                                                controller.emailVerify();

                                              },
                                            )
                                        ])),*/
                                    /* heightSpace_10,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Get.toNamed(AppRoutes.addUser);

                                            },
                                            style: ElevatedButton.styleFrom(padding: EdgeInsets.zero,backgroundColor: lightPurple,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset("assets/svg/add_mem_icon.svg",height: 15),
                                                widthSpace_5,
                                                Text("Add Member", style: poppins(color: primaryColor,fontSize: 11,fontWeight: FontWeight.w500))
                                              ],
                                            ),
                                          ),
                                        ),
                                        widthSpace_20,
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller.activateUser();
                                            },
                                            style: ElevatedButton.styleFrom(padding: EdgeInsets.zero,backgroundColor: lightPurple,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset("assets/svg/act_mem_icon.svg",height: 14),
                                                widthSpace_5,
                                                Text("Activate Member", style: poppins(color: primaryColor,fontSize: 11,fontWeight: FontWeight.w500))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )*/
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /*GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.profile),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10,10,10,10),
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xc700BFCE),
                                Color(0x781A59CD)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        children: [
                          CachePlaceHolderImage(imageUrl: "$BASE_PROFILE_PIC_URL${controller.loginResponse.data!.userID}.png",
                              imgaeWidth: 60,
                              imageHeight: 60,
                              errorColorBackground: Colors.transparent,
                              errorIconHeight: 60,
                              errorCustomWidget: SvgPicture.asset("assets/svg/user_pic.svg",width: 40,height: 40,)),
                          Text("Hi, ${controller.loginResponse.data!=null ?controller.loginResponse.data!.name??"":""}!",
                              style: poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15)),
                          heightSpace_3,
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                            decoration:  BoxDecoration(
                              color: controller.balanceResponse.value.isTopup==1?green_2:Colors.red[300],
                              borderRadius: const BorderRadius.all(Radius.circular(5))
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(controller.balanceResponse.value.isTopup==1?"assets/svg/verify.svg":"assets/svg/unverify.svg",width: 18,height: 18),
                                widthSpace_5,
                                Text(controller.loginResponse.data!=null ?"${(controller.loginResponse.data!.prefix??"").toUpperCase()}${controller.loginResponse.data!.userID??0}":"",
                                    style: poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13)),
                              ],
                            ),
                          ),
                          heightSpace_3,
                          RichText(text: TextSpan(text: controller.loginResponse.data!=null ?controller.loginResponse.data!.emailID??"":"",
                              style: poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                              children: [
                                if(controller.balanceResponse.value.isEmailVerified==false)
                                TextSpan(
                                  text: ' Verify',
                                  style: poppins(color: Colors.orange,fontSize: 9,fontWeight: FontWeight.w700),
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                    controller.emailVerify();

                                  },
                                )
                              ])),
                          heightSpace_10,
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.addUser);

                                  },
                                  style: ElevatedButton.styleFrom(padding: EdgeInsets.zero,backgroundColor: lightPurple,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset("assets/svg/add_mem_icon.svg",height: 15),
                                      widthSpace_5,
                                      Text("Add Member", style: poppins(color: primaryColor,fontSize: 11,fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                              ),
                              widthSpace_20,
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.activateUser();
                                  },
                                  style: ElevatedButton.styleFrom(padding: EdgeInsets.zero,backgroundColor: lightPurple,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset("assets/svg/act_mem_icon.svg",height: 14),
                                      widthSpace_5,
                                      Text("Activate Member", style: poppins(color: primaryColor,fontSize: 11,fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),*/

                  if(controller.balanceResponse.value.balanceData!=null && controller.balanceResponse.value.balanceData!.isNotEmpty)...[
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 10,bottom: 5),
                      child: Text("Wallet",style: poppins(
                          color:Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                    ),
                    for(var item in controller.balanceResponse.value.balanceData!)...{
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.ledgerReport,arguments:[item,controller.balanceResponse.value.balanceData!] ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10,bottom: 10,right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: primaryColor,strokeAlign: BorderSide.strokeAlignOutside,width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              heightSpace_10,
                              Row(
                                children: [
                                  widthSpace_15,
                                  if((item.walletCurrencySymbol??"").toLowerCase()=="usdt"||
                                      (item.walletCurrencySymbol??"").toLowerCase()=="usd"||
                                      (item.walletCurrencySymbol??"").toLowerCase()=="inr"||
                                      (item.walletCurrencySymbol??"").toLowerCase()=="rupee"||
                                      (item.walletCurrencySymbol??"").toLowerCase()=="indian rupees"||
                                      (item.walletCurrencySymbol??"").toLowerCase()=="rupees")...[
                                    Container(
                                        width: 50,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            color: primaryColorLight,
                                            borderRadius: BorderRadius.all(Radius.circular(25))
                                        ),
                                        child: Text(Utility.INSTANCE.getCurrencySymbol(item.walletCurrencySymbol??"\$"),
                                            textAlign: TextAlign.center,
                                            style: poppins(color: Colors.white,fontSize: 33,fontWeight: FontWeight.w600))),
                                  ]else...[
                                    Container(
                                        width: 50,
                                        height: 50,
                                        padding: const EdgeInsets.all(9),
                                        decoration: const BoxDecoration(
                                            color: primaryColorLight,
                                            borderRadius: BorderRadius.all(Radius.circular(25))
                                        ),
                                        child: SvgPicture.asset("assets/svg/note.svg"))
                                  ],
                                  Expanded(
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      text: TextSpan(
                                        text: "${item.walletType??""}\n",
                                        style: poppins(color: primaryColorLight,fontSize: 18,fontWeight: FontWeight.w600),
                                        children: [
                                          TextSpan(
                                            text: "${Utility.INSTANCE.getCurrencySymbol(item.walletCurrencySymbol??"\$") } ${Utility.INSTANCE.formatedAmountWithOutRupees(item.balance??0.0)}",
                                            style: poppins(color: accentColor,fontSize: 16,fontWeight: FontWeight.w600),
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                  widthSpace_15
                                ],
                              ),
                              heightSpace_10,
                              if((item.capping??0.0)>0)...[
                                Container(
                                  alignment: Alignment.center,
                                  margin:  const EdgeInsets.fromLTRB(12,0,12,10),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                  decoration: const BoxDecoration(
                                      color: gray_1,
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: Text(
                                    "Lien : ${Utility.INSTANCE.getCurrencySymbol(item.walletCurrencySymbol??"\$") } ${Utility.INSTANCE.formatedAmountWithOutRupees(item.capping??0.0)}",
                                    style: poppins(color: grayishBlue,fontSize: 14,fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                              if (item.isWithdrawal == true && item.allowedWithdrawalType != null && item.allowedWithdrawalType!.isNotEmpty)...[

                                Container(
                                  width: double.infinity,
                                  decoration:  BoxDecoration(
                                      color: primaryColor,
                                      border: Border.all(color: primaryColor,strokeAlign: BorderSide.strokeAlignCenter,width: 1),
                                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10))
                                  ),
                                  child: TextButton(
                                      onPressed: () => controller.withdrawalWallet(item,(){
                                        showPopupWalletWithdrawal(item.allowedWithdrawalType!, item);
                                      }),
                                      style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 0),
                                          visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity,vertical: -2),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                      child: Text(
                                          "Withdrawal",
                                          style: poppins(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600)
                                      )),
                                )
                              ]

                             /* if (item.inFundProcess==true || item.isWithdrawal == true && item.allowedWithdrawalType != null && item.allowedWithdrawalType!.isNotEmpty)...[

                                Container(
                                  decoration:  BoxDecoration(
                                      color: primaryColor,
                                      border: Border.all(color: primaryColor,strokeAlign: BorderSide.strokeAlignCenter,width: 1),
                                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10))
                                  ),
                                  child: Row(
                                    children: [
                                      if (item.isWithdrawal == true && item.allowedWithdrawalType != null && item.allowedWithdrawalType!.isNotEmpty)
                                        Expanded(
                                          child: TextButton(
                                              onPressed: () => controller.withdrawalWallet(item,(){
                                                showPopupWalletWithdrawal(item.allowedWithdrawalType!, item);
                                              }),
                                              style: TextButton.styleFrom(
                                                  padding: const EdgeInsets.symmetric(horizontal: 0),
                                                  visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity,vertical: -2),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                              child: Text(
                                                  "Withdrawal",
                                                  style: poppins(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600)
                                              )),
                                        ),
                                      if (item.inFundProcess==true)
                                        Expanded(
                                          child: TextButton(
                                              onPressed: () {
                                                controller.getWalletDepositCurrencyMapping(item.id??0,(response){
                                                  openDepositScreen(item,response,true);
                                                });
                                              },
                                              style: TextButton.styleFrom(
                                                  padding: const EdgeInsets.symmetric(horizontal: 0),
                                                  visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity,vertical: -2),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                              child: Text(
                                                  "Deposit",
                                                  style: poppins(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600)
                                              )),
                                        )

                                      Expanded(
                                          child:  TextButton(
                                            onPressed: () => Get.toNamed(AppRoutes.fundRequestReport),
                                            style: TextButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                                visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity,vertical: -2),
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                            child: Text(
                                                "History",
                                                style: poppins(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600)
                                            )))
                                    ],
                                  ),
                                )
                              ]*/

                            ],
                          ),
                        ),
                      )
                    }
                  ],

                  if(controller.balanceResponse.value.isStake==true)...[
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.stakeHistory)!.then((value) {
                        if(controller.isBalCryptoApi==false) {
                          controller.balance(true);
                          controller.currencyList(true, null);
                        }else{
                          controller.isBalCryptoApi=false;
                        }
                      }),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10,right: 10),
                        height: 115,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: primaryColor,strokeAlign: BorderSide.strokeAlignOutside,width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 50,
                                        height: 50,
                                        padding: const EdgeInsets.all(9),
                                        decoration: const BoxDecoration(
                                            color: primaryColorLight,
                                            borderRadius: BorderRadius.all(Radius.circular(25))
                                        ),
                                        child: SvgPicture.asset("assets/svg/note.svg")),
                                    Expanded(
                                      child: RichText(
                                        textAlign: TextAlign.right,
                                        text: TextSpan(
                                          text: "Stake Wallet\n",
                                          style: poppins(color: primaryColorLight,fontSize: 18,fontWeight: FontWeight.w600),
                                          children: [
                                            TextSpan(
                                              text: "${Utility.INSTANCE.getCurrencySymbol(controller.stakeBalanceResponse.value.symbol??controller.balanceResponse.value.defaultCurrencySymbol??"\$") } ${Utility.INSTANCE.formatedAmountWithOutRupees(controller.stakeBalanceResponse.value.stakeAmount??0.0)}",
                                              style: poppins(color: accentColor,fontSize: 16,fontWeight: FontWeight.w600),
                                            ),

                                            TextSpan(
                                              text: "\n${Utility.INSTANCE.getCurrencySymbol(controller.stakeBalanceResponse.value.symbol??controller.balanceResponse.value.defaultCurrencySymbol??"\$") } ${Utility.INSTANCE.formatedAmountWithOutRupees(controller.stakeBalanceResponse.value.amountInStakeCurr??0.0)}",
                                              style: poppins(color: accentColor,fontSize: 15,fontWeight: FontWeight.w600),
                                            )


                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              width: double.infinity,
                              decoration:  BoxDecoration(
                                  color: primaryColor,
                                  border: Border.all(color: primaryColor,strokeAlign: BorderSide.strokeAlignCenter,width: 1),
                                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10))
                              ),
                              child: TextButton(
                                  onPressed: () => controller.stakeNow((List<String> list){
                                    showPopupStakeType(list);
                                  }),
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 0),
                                      visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity,vertical: -2),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                  child: Text(
                                      "Stake Now",
                                      style: poppins(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600)
                                  )),
                            )

                          ],
                        ),
                      ),
                    )
                  ],
            if(controller.displayBalCryptoList.isNotEmpty)...[
                 Padding(
                    padding: const EdgeInsets.only(left: 10,right:  10,top: 10,bottom: 5),
                    child: Text("Portfolio",style: poppins(
                        color:Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18)),
                  ),
                 Column(
                  children: List.generate(controller.displayBalCryptoList.length, (index)  {
                    var item =controller.displayBalCryptoList[index];
                    if (item.isBalanceFromDB == false && !controller.currencyBalanceMap.containsKey(item.id ?? 0)) {
                      controller.getCryptoBalanceApi(item.id ?? 0,true,true);
                    }
                    return  Container(
                      margin: const EdgeInsets.only(right: 10,left: 10,bottom: 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heightSpace_10,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                widthSpace_15,
                                CachePlaceHolderImage(imageUrl: item.imageUrls??"",
                                    imgaeWidth: 50,
                                    imageHeight: 50,
                                    errorColorBackground: Colors.transparent,
                                    errorIconHeight: 50),
                                widthSpace_10,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          item.currencyName ?? "",
                                          maxLines: 1,
                                          style: poppins(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600)
                                      ),
                                      Text(Utility.INSTANCE.formatedAmountNinePlace(item.isBalanceFromDB==true?item.balance??0.0:
                                      (controller.currencyBalanceMap.containsKey(item.id??0)? (controller.currencyBalanceMap[item.id??0]!.balance??"0.0"):"0.0")),
                                          style: poppins(color: orange_1,fontSize: 14,fontWeight: FontWeight.w600)
                                      ),

                                    ],
                                  ),
                                ),
                                if(item.isBalanceFromDB==false && !controller.currencyBalanceLoadedId.value.contains("_${item.id ?? 0}"))
                                  const SizedBox(width: 20,height:20,child: CircularProgressIndicator()),
                                widthSpace_15
                              ],
                            ),
                            if(item.isBalanceFromDB==false)...[
                              Container(
                                  margin: const EdgeInsets.only(top: 5,left: 15,right: 15),
                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(color: gray_2,borderRadius: BorderRadius.all(Radius.circular(20))),
                                  child: Text(
                                      "\$${controller.currencyBalanceMap.containsKey(item.id ?? 0) ? Utility.INSTANCE.formatedAmountNinePlace(controller.currencyBalanceMap[item.id ?? 0]!.balanceInUSDT ?? 0) : "0"}",
                                      style: poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 12)))
                            ],
                            heightSpace_10,
                            Row(
                              children: [
                                if (item.isTransferAllowed == true && item.allowedTransferMappings != null && item.allowedTransferMappings!.isNotEmpty)...[
                                Expanded(
                                  child: InkWell(
                                    onTap: () =>  controller.withdrawalCrypto(item,(){
                                      showPopupCryptoWithdrawal(item.allowedTransferMappings!, item);
                                    }),
                                    child: Container(
                                        height: 30,
                                        alignment: Alignment.center,

                                        decoration: BoxDecoration(
                                          color: primaryColorLight,
                                          borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(15),bottomRight:item.isDepositAllowed == true?Radius.zero: const Radius.circular(15))
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.arrow_upward,color: Colors.white,size: 15),
                                            widthSpace_3,
                                            Text("Transfer", style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 10)),
                                          ],
                                        )),
                                  ),
                                )

                               ],
                                if (item.isDepositAllowed == true && item.isTransferAllowed == true && item.allowedTransferMappings != null && item.allowedTransferMappings!.isNotEmpty)...[
                                  widthSpace_3
                                ],
                                if (item.isDepositAllowed == true) ...[
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => controller.openDeposit(BalanceData(),item,false),
                                      child: Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: accentColor,
                                              borderRadius: BorderRadius.only(bottomRight: const Radius.circular(15),
                                                  bottomLeft: (item.isTransferAllowed == true && item.allowedTransferMappings != null && item.allowedTransferMappings!.isNotEmpty)?Radius.zero: const Radius.circular(15))
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.arrow_downward,color: Colors.white,size: 15),
                                              widthSpace_3,
                                              Text("Deposit", style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 10)),
                                            ],
                                          )),
                                    ),
                                  )
                                ]
                              ],
                            )
                          ],
                        ));
                  },
              ) ,
              )
            ],

                  /*if(controller.dashboardDownlineData.value.singleData!=null)...[
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right:  10,top: 10),
                      child: Text("Team",style: poppins(
                          color:Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      height: 70,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                        children: [
                         if(controller.isBinaryOn.value==2)...[
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.teamReport,arguments: "L"),
                              child: Container(
                                width: (controller.screenWidth-50)/2,
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    border: Border.all(color: grayishBlue),
                                    borderRadius: const BorderRadius.all(Radius.circular(10))
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 35,
                                        height: 35,
                                        padding: const EdgeInsets.all(6),

                                        decoration: const BoxDecoration(
                                            color: grayishBlue,
                                            borderRadius: BorderRadius.all(Radius.circular(25))
                                        ),
                                        child: SvgPicture.asset("assets/svg/team.svg")),
                                    Expanded(
                                      child: RichText(
                                        textAlign: TextAlign.right,
                                        maxLines: 2,
                                        text: TextSpan(
                                          text: "Left Team\n",
                                          style: poppins(color: grayishBlue,fontSize: 12,fontWeight: FontWeight.w600),
                                          children: [
                                            TextSpan(
                                              text: "${controller.dashboardDownlineData.value.singleData!.totalLeftTeam??0}",
                                              style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.teamReport,arguments: "R"),
                              child: Container(
                                width: (controller.screenWidth-50)/2,
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    border: Border.all(color: grayishBlue),
                                    borderRadius: const BorderRadius.all(Radius.circular(10))
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 35,
                                        height: 35,
                                        padding: const EdgeInsets.all(6),

                                        decoration: const BoxDecoration(
                                            color: grayishBlue,
                                            borderRadius: BorderRadius.all(Radius.circular(25))
                                        ),
                                        child: SvgPicture.asset("assets/svg/team.svg")),
                                    Expanded(
                                      child: RichText(
                                        textAlign: TextAlign.right,
                                        maxLines: 2,
                                        text: TextSpan(
                                          text: "Right Team\n",
                                          style: poppins(color: grayishBlue,fontSize: 12,fontWeight: FontWeight.w600),
                                          children: [
                                            TextSpan(
                                              text: "${controller.dashboardDownlineData.value.singleData!.totalRightTeam??0}",
                                              style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.teamReport,arguments: "All"),
                              child: Container(
                                width: (controller.screenWidth-50)/2,
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    border: Border.all(color: grayishBlue),
                                    borderRadius: const BorderRadius.all(Radius.circular(10))
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 35,
                                        height: 35,
                                        padding: const EdgeInsets.all(6),

                                        decoration: const BoxDecoration(
                                            color: grayishBlue,
                                            borderRadius: BorderRadius.all(Radius.circular(25))
                                        ),
                                        child: SvgPicture.asset("assets/svg/team.svg")),
                                    Expanded(
                                      child: RichText(
                                        textAlign: TextAlign.right,
                                        maxLines: 2,
                                        text: TextSpan(
                                          text: "Total Team\n",
                                          style: poppins(color: grayishBlue,fontSize: 12,fontWeight: FontWeight.w600),
                                          children: [
                                            TextSpan(
                                              text: "${controller.dashboardDownlineData.value.singleData!.totalTeam??0}",
                                              style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            )
                          ],
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.directTeamReport),
                            child: Container(
                              width: controller.isBinaryOn.value==2?
                              (controller.screenWidth-50)/2:
                              (controller.screenWidth-30)/2,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  border: Border.all(color: grayishBlue),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(6),

                                      decoration: const BoxDecoration(
                                          color: grayishBlue,
                                          borderRadius: BorderRadius.all(Radius.circular(25))
                                      ),
                                      child: SvgPicture.asset("assets/svg/team.svg")),
                                  Expanded(
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                      text: TextSpan(
                                        text: "Direct Team\n",
                                        style: poppins(color: grayishBlue,fontSize: 12,fontWeight: FontWeight.w600),
                                        children: [
                                          TextSpan(
                                            text: "${controller.dashboardDownlineData.value.singleData!.directDownlinelUser??0}",
                                            style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.sponserTeamReport),
                            child: Container(
                                  width: controller.isBinaryOn.value == 2
                                      ? (controller.screenWidth - 50) / 2
                                      : (controller.screenWidth - 30) / 2,
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      border: Border.all(color: grayishBlue),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 35,
                                          height: 35,
                                          padding: const EdgeInsets.all(6),
                                          decoration: const BoxDecoration(
                                              color: grayishBlue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25))),
                                          child: SvgPicture.asset(
                                              "assets/svg/team.svg")),
                                      Expanded(
                                        child: RichText(
                                          textAlign: TextAlign.right,
                                          maxLines: 2,
                                          text: TextSpan(
                                            text: "Sponsor Team\n",
                                            style: poppins(
                                                color: grayishBlue,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                            children: [
                                              TextSpan(
                                                text:
                                                    "${controller.dashboardDownlineData.value.singleData!.totalSponser ?? 0}",
                                                style: poppins(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          )
                            ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right:  10,top: 10),
                      child: Text("Referral Link",style: poppins(
                          color:Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      decoration: const BoxDecoration(
                          color: primaryColorLight,
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                      child:  Column(
                        children:[
                          if(controller.isBinaryOn.value==2)...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  border: Border.all(color: grayishBlue),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                width: 35,
                                                height: 35,
                                                padding: const EdgeInsets.all(6),
                                                margin: const EdgeInsets.only(right: 10),
                                                decoration: const BoxDecoration(
                                                    color: grayishBlue,
                                                    borderRadius: BorderRadius.all(Radius.circular(25))
                                                ),
                                                child: SvgPicture.asset("assets/svg/referral.svg")),
                                            Text("Left Referral Link",style: poppins(color: grayishBlue,fontSize: 14,fontWeight: FontWeight.w600),)
                                          ],
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(top: 15),
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                                color: Color(0x17fcfcfc),
                                                borderRadius: BorderRadius.all(Radius.circular(30))
                                            ),
                                            child: Text(controller.dashboardDownlineData.value.singleData!.leftReferralLink??"",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w400)))
                                      ],
                                    ),
                                  ),
                                  widthSpace_10,
                                  Column(
                                    children: [
                                      TextButton(onPressed: () {
                                        Utility.INSTANCE.copyText(controller.dashboardDownlineData.value.singleData!.leftReferralLink??"", "Left Referral Link");
                                      },
                                          style: TextButton.styleFrom(
                                              backgroundColor: grayishBlue,
                                              minimumSize: const Size(75, 30),
                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                          child: Text("Copy Link",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w600))),
                                      heightSpace_5,
                                      TextButton(onPressed: () {
                                        Utility.INSTANCE.share("Your friend ${controller.loginResponse.data!.name??""} is inviting you to join this app for your fitness",
                                            controller.dashboardDownlineData.value.singleData!.leftReferralLink??"", "Left Referral Link","Refer To Your Friends & Earn");
                                      },
                                          style: TextButton.styleFrom(
                                              minimumSize: const Size(75, 30),
                                              shape: const RoundedRectangleBorder(side: BorderSide(color: grayishBlue),borderRadius: BorderRadius.all(Radius.circular(15)))),
                                          child: Text("Share",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w600)))
                                    ],
                                  )

                                ],
                              ),
                            ),
                            heightSpace_10,
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  border: Border.all(color: grayishBlue),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                width: 35,
                                                height: 35,
                                                padding: const EdgeInsets.all(6),
                                                margin: const EdgeInsets.only(right: 10),
                                                decoration: const BoxDecoration(
                                                    color: grayishBlue,
                                                    borderRadius: BorderRadius.all(Radius.circular(25))
                                                ),
                                                child: SvgPicture.asset("assets/svg/referral.svg")),
                                            Text("Right Referral Link",style: poppins(color: grayishBlue,fontSize: 14,fontWeight: FontWeight.w600),)
                                          ],
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(top: 15),
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                                color: Color(0x17fcfcfc),
                                                borderRadius: BorderRadius.all(Radius.circular(30))
                                            ),
                                            child: Text(controller.dashboardDownlineData.value.singleData!.rightReferralLink??"",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w400)))
                                      ],
                                    ),
                                  ),
                                  widthSpace_10,
                                  Column(
                                    children: [
                                      TextButton(onPressed: () {
                                        Utility.INSTANCE.copyText(controller.dashboardDownlineData.value.singleData!.rightReferralLink??"", "Right Referral Link");
                                      },
                                          style: TextButton.styleFrom(
                                              backgroundColor: grayishBlue,
                                              minimumSize: const Size(75, 30),
                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                          child: Text("Copy Link",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w600))),
                                      heightSpace_5,
                                      TextButton(onPressed: () {
                                        Utility.INSTANCE.share("Your friend ${controller.loginResponse.data!.name??""} is inviting you to join this app for your fitness",
                                            controller.dashboardDownlineData.value.singleData!.rightReferralLink??"", "Right Referral Link","Refer To Your Friends & Earn");
                                      },
                                          style: TextButton.styleFrom(
                                              minimumSize: const Size(75, 30),
                                              shape: const RoundedRectangleBorder(side: BorderSide(color: grayishBlue),borderRadius: BorderRadius.all(Radius.circular(15)))),
                                          child: Text("Share",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w600)))
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ]else...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  border: Border.all(color: grayishBlue),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                width: 35,
                                                height: 35,
                                                padding: const EdgeInsets.all(6),
                                                margin: const EdgeInsets.only(right: 10),
                                                decoration: const BoxDecoration(
                                                    color: grayishBlue,
                                                    borderRadius: BorderRadius.all(Radius.circular(25))
                                                ),
                                                child: SvgPicture.asset("assets/svg/referral.svg")),
                                            Text("Referral Link",style: poppins(color: grayishBlue,fontSize: 14,fontWeight: FontWeight.w600),)
                                          ],
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(top: 15),
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                                color: Color(0x17fcfcfc),
                                                borderRadius: BorderRadius.all(Radius.circular(30))
                                            ),
                                            child: Text(controller.dashboardDownlineData.value.singleData!.singleLink??"",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w400)))
                                      ],
                                    ),
                                  ),
                                  widthSpace_10,
                                  Column(
                                    children: [
                                      TextButton(onPressed: () {
                                        Utility.INSTANCE.copyText(controller.dashboardDownlineData.value.singleData!.singleLink??"", "Referral Link");
                                      },
                                          style: TextButton.styleFrom(
                                              backgroundColor: grayishBlue,
                                              minimumSize: const Size(75, 30),
                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                          child: Text("Copy Link",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w600))),
                                      heightSpace_5,
                                      TextButton(onPressed: () {
                                        Utility.INSTANCE.share("Your friend ${controller.loginResponse.data!.name??""} is inviting you to join this app for your fitness",
                                            controller.dashboardDownlineData.value.singleData!.singleLink??"", "Referral Link","Refer To Your Friends & Earn");
                                      },
                                          style: TextButton.styleFrom(
                                              minimumSize: const Size(75, 30),
                                              shape: const RoundedRectangleBorder(side: BorderSide(color: grayishBlue),borderRadius: BorderRadius.all(Radius.circular(15)))),
                                          child: Text("Share",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w600)))
                                    ],
                                  )

                                ],
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                  ],*/
                  if(controller.dashboardDownlineData.value.incomeDetails!=null && controller.dashboardDownlineData.value.incomeDetails!.isNotEmpty)...[
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right:  10,top: 10),
                    child: Text("Income",style: poppins(
                        color:Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18)),
                  ),
                    for(var item in controller.dashboardDownlineData.value.incomeDetails!)...{
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.incomeReport,arguments: [controller.defaultCurrencySymbol.value,item]),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                          decoration:  BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: primaryColor),
                              borderRadius: const BorderRadius.all(Radius.circular(15))
                          ),
                          child: Row(
                            children: [
                              widthSpace_15,
                              RichText(
                                text: TextSpan(
                                  text: "${item.incomeName}\n",
                                  style: poppins(color: primaryColor,fontSize: 13,fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                      text: "${Utility.INSTANCE.getCurrencySymbol(controller.defaultCurrencySymbol.value)} ${Utility.INSTANCE.formatedAmountWithOutRupees(item.incomeFigure??0.0)}",
                                      style: poppins(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: const BoxDecoration(
                                      color: grayishBlue,
                                      borderRadius: BorderRadius.all(Radius.circular(25))
                                  ),
                                  child: SvgPicture.asset("assets/svg/wallet.svg")),

                            ],
                          ),
                        ),
                      )
                    }
                  ],
                 /* if(controller.dashboardDownlineData.value.singleData!=null)...[
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right:  10,top: 10),
                    child: Text("Business",style: poppins(
                        color:Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18)),
                  ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      height: 70,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                        children: [
                          if(controller.isBinaryOn.value==2)...[
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.binaryBusinessReport,arguments: "Left"),
                            child: Container(
                              width: (controller.screenWidth-50)/2,
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                border: Border.all(color: grayishBlue),
                                borderRadius: const BorderRadius.all(Radius.circular(10))
                            ),
                            child: Row(
                              children: [
                                Container(
                                    width: 35,
                                    height: 35,
                                    padding: const EdgeInsets.all(6),

                                    decoration: const BoxDecoration(
                                        color: grayishBlue,
                                        borderRadius: BorderRadius.all(Radius.circular(25))
                                    ),
                                    child: SvgPicture.asset("assets/svg/business.svg")),
                                Expanded(
                                  child: RichText(
                                    textAlign: TextAlign.right,
                                    maxLines: 2,
                                    text: TextSpan(
                                      text: "Left Business\n",
                                      style: poppins(color: grayishBlue,fontSize: 11,fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text: Utility.INSTANCE.formatedAmountWithOutRupees(controller.dashboardDownlineData.value.singleData!.leftBusiness??0.0),
                                          style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                        ),
                          ),
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.binaryBusinessReport,arguments: "Right"),
                            child: Container(
                              width: (controller.screenWidth-50)/2,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  border: Border.all(color: grayishBlue),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(6),

                                      decoration: const BoxDecoration(
                                          color: grayishBlue,
                                          borderRadius: BorderRadius.all(Radius.circular(25))
                                      ),
                                      child: SvgPicture.asset("assets/svg/business.svg")),
                                  Expanded(
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                      text: TextSpan(
                                        text: "Right Business\n",
                                        style: poppins(color: grayishBlue,fontSize: 11,fontWeight: FontWeight.w600),
                                        children: [
                                          TextSpan(
                                            text: Utility.INSTANCE.formatedAmountWithOutRupees(controller.dashboardDownlineData.value.singleData!.rightBusiness??0.0),
                                            style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.binaryBusinessReport,arguments: "All"),
                            child: Container(
                              width: (controller.screenWidth-50)/2,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  border: Border.all(color: grayishBlue),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(6),

                                      decoration: const BoxDecoration(
                                          color: grayishBlue,
                                          borderRadius: BorderRadius.all(Radius.circular(25))
                                      ),
                                      child: SvgPicture.asset("assets/svg/business.svg")),
                                  Expanded(
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                      text: TextSpan(
                                        text: "Total Business\n",
                                        style: poppins(color: grayishBlue,fontSize: 11,fontWeight: FontWeight.w600),
                                        children: [
                                          TextSpan(
                                            text: Utility.INSTANCE.formatedAmountWithOutRupees(controller.dashboardDownlineData.value.singleData!.totalBusiness??0.0),
                                            style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          )],
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.selfBusinessReport),
                            child: Container(
                              width: (controller.screenWidth-50)/2,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  border: Border.all(color: grayishBlue),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(6),

                                      decoration: const BoxDecoration(
                                          color: grayishBlue,
                                          borderRadius: BorderRadius.all(Radius.circular(25))
                                      ),
                                      child: SvgPicture.asset("assets/svg/business.svg")),
                                  Expanded(
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                      text: TextSpan(
                                        text: "Self Business\n",
                                        style: poppins(color: grayishBlue,fontSize: 11,fontWeight: FontWeight.w600),
                                        children: [
                                          TextSpan(
                                            text: Utility.INSTANCE.formatedAmountWithOutRupees(controller.dashboardDownlineData.value.singleData!.selfBusiness??0.0),
                                            style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.directBusinessReport),
                            child: Container(
                              width: (controller.screenWidth-50)/2,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  border: Border.all(color: grayishBlue),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(6),

                                      decoration: const BoxDecoration(
                                          color: grayishBlue,
                                          borderRadius: BorderRadius.all(Radius.circular(25))
                                      ),
                                      child: SvgPicture.asset("assets/svg/business.svg")),
                                  Expanded(
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                      text: TextSpan(
                                        text: "Direct Business\n",
                                        style: poppins(color: grayishBlue,fontSize: 11,fontWeight: FontWeight.w600),
                                        children: [
                                          TextSpan(
                                            text: Utility.INSTANCE.formatedAmountWithOutRupees(controller.dashboardDownlineData.value.singleData!.directBusiness??0.0),
                                            style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.sponserBusinessReport),
                            child: Container(
                              width: (controller.screenWidth-50)/2,
                              height: 70,
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  border: Border.all(color: grayishBlue),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(6),

                                      decoration: const BoxDecoration(
                                          color: grayishBlue,
                                          borderRadius: BorderRadius.all(Radius.circular(25))
                                      ),
                                      child: SvgPicture.asset("assets/svg/business.svg")),
                                  Expanded(
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                      text: TextSpan(
                                        text: "Sponsor Business\n",
                                        style: poppins(color: grayishBlue,fontSize: 11,fontWeight: FontWeight.w600),
                                        children: [
                                          TextSpan(
                                            text: Utility.INSTANCE.formatedAmountWithOutRupees(controller.dashboardDownlineData.value.singleData!.sponserBusiness??0.0),
                                            style: poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          )]
                    ),
                  ),
                  ],*/

                  if(controller.dashboardDownlineData.value.singleData!=null && (controller.dashboardDownlineData.value.singleData!.singleLink??"").isNotEmpty)...[

                    heightSpace_10,
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 42),
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(20,50,20,20),
                            child: Column(
                              children: [
                                Text(
                                  "Refer and introduce the ${controller.api.packageInfo.appName} to your contacts!",
                                  textAlign: TextAlign.center,
                                  style: poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                heightSpace_15,
                                Container(
                                  padding: const EdgeInsets.fromLTRB(15,5,5,5),
                                  decoration: const BoxDecoration(
                                      color: grayishBlue_alpha_22,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(controller.dashboardDownlineData.value.singleData!.singleLink??"",
                                              style: poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12)),
                                        ),
                                        IconButton(onPressed: (){
                                          Utility.INSTANCE.copyText(controller.dashboardDownlineData.value.singleData!.singleLink??"","Invite Link");
                                        }, icon: const Icon(Icons.copy,color: primaryColor,))
                                      ]),
                                ),
                                heightSpace_15,
                                TextButton(onPressed: () {
                                  Utility.INSTANCE.share('Refer To Your Friends & Earn',
                                      controller.dashboardDownlineData.value.singleData!.singleLink??"",
                                      'Refer & Earn',
                                      "Choose any one");
                                },style: TextButton.styleFrom(backgroundColor: primaryColor,minimumSize: const Size(150, 42),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))), child: Text("Refer",style: poppins(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),))
                              ],
                            )),
                        SvgPicture.asset("assets/svg/gift_box.svg"),
                      ],
                    ),
                  ]else...[
                    heightSpace_10
                  ],

                          ]
              ))
            )
          )
         /* drawer:  DashboardDrawer()*/),
    );
  }

  void openDepositScreen(BalanceData balanceData,List<LiveRateData> list,bool isFromWallet){
    if(list!=null && list.isNotEmpty){
      if(list.length==1){
        controller.openDeposit(balanceData,list[0],isFromWallet);
      }else{
        Get.bottomSheet(
            Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(onTap:() =>  Get.back(),child: const Padding(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              child: Icon(Icons.cancel,color: Colors.white,size: 35),
            ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.white),
                child: Obx(() => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Select Currency!",
                        style: poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 25)),
                   heightSpace_30,
                    Wrap(
                      spacing: 10, runSpacing: 10,
                      children: List.generate(list.length, (index) {
                        var item=list[index];
                        return GestureDetector(
                          onTap: () => controller.openDeposit(balanceData,item, isFromWallet),
                          child: Container(
                            color: Colors.transparent,
                            width: (controller.screenWidth-70)/2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CachePlaceHolderImage(imageUrl: item.imageUrls??"",imgaeWidth: 70,imageHeight: 70,errorColorBackground: Colors.transparent,
                                    errorIconHeight: 70),
                                heightSpace_10,
                                Text(item.currencyName??"",
                                    style: poppins(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600))

                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 15),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: grayishBlue_alpha_55,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Text("You can select any one currency to make deposit.",
                          style: poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 10)),
                    ),


                  ],
                ))),

          ],
        ));
      }

    }else{
      Get.toNamed(AppRoutes.fundRequest,arguments:balanceData.obs)!.then((value) {
       /* if(value==123){
          controller.balance(true);
        }*/
        if(controller.isBalCryptoApi==false) {
          controller.balance(true);
          controller.currencyList(true, null);
        }else{
          controller.isBalCryptoApi=false;
        }
      });
    }
  }

  void showPopupWalletWithdrawal(List<AllowedWithdrawalType> dataList, BalanceData mBalanceData){
        Get.bottomSheet(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(onTap:() =>  Get.back(),child: const Padding(
                  padding: EdgeInsets.only(top: 5,bottom: 5),
                  child: Icon(Icons.cancel,color: Colors.white,size: 35),
                ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        color: Colors.white),
                    child:  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Select Type!",
                            style: poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 25)),
                        heightSpace_30,
                        Wrap(
                          spacing: 10, runSpacing: 10,
                          children: List.generate(dataList.length, (index) {
                            var item=dataList[index];
                            return GestureDetector(
                              onTap: () {
                                Get.back();
                                controller.openWalletWithdrawal(item, mBalanceData);
                              },
                              child: Container(
                                color: Colors.transparent,
                                width: (controller.screenWidth-70)/2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset( item.serviceId == 2?"assets/svg/dialog_money_transfer.svg":
                                    item.serviceId == 42?"assets/svg/dialog_bank_transfer.svg":
                                    item.serviceId == 62?"assets/svg/dialog_upi_payment.svg":
                                    item.serviceId == 76?"assets/svg/dialog_crypto_coin_transfer.svg":
                                    "assets/svg/dialog_wallet_to_wallet.svg",width: 70,height: 70),

                                    heightSpace_10,
                                    Text(item.serviceName??"",
                                        style: poppins(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600))

                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 15),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: grayishBlue_alpha_55,
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          child: Text("You can select any one type to make withdrawal.",
                              style: poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10)),
                        ),


                      ],
                    )),

              ],
            ));

  }

  void showPopupCryptoWithdrawal(List<AllowTransferMapping> dataList, LiveRateData mLiveRateData){
    Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(onTap:() =>  Get.back(),child: const Padding(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              child: Icon(Icons.cancel,color: Colors.white,size: 35),
            ),
            ),
            Container(

                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.white),
                child: Obx(() => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Select Type!",
                        style: poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 25)),
                    heightSpace_30,
                    Wrap(
                      spacing: 10, runSpacing: 10,
                      children: List.generate(dataList.length, (index) {
                        var item=dataList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.back();
                            controller.openCryptoTransfer(item, mLiveRateData);
                          },
                          child: Container(
                            color: Colors.transparent,
                            width: (controller.screenWidth-70)/2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset( item.serviceId == 2?"assets/svg/dialog_money_transfer.svg":
                                item.serviceId == 42?"assets/svg/dialog_bank_transfer.svg":
                                item.serviceId == 62?"assets/svg/dialog_upi_payment.svg":
                                item.serviceId == 76?"assets/svg/dialog_crypto.svg":
                                "assets/svg/dialog_internal_wallet.svg",width: 70,height: 70),

                                heightSpace_10,
                                Text(item.serviceName??"",
                                    style: poppins(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600))

                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 15),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: grayishBlue_alpha_55,
                          borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Text("You can select any one type to make withdrawal.",
                          style: poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 10)),
                    ),


                  ],
                ))),

          ],
        ));

  }


  void showPopupStakeType(List<String> dataList){
    Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(onTap:() =>  Get.back(),child: const Padding(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              child: Icon(Icons.cancel,color: Colors.white,size: 35),
            ),
            ),
            Container(

                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.white),
                child:  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Select Type!",
                        style: poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 25)),
                    heightSpace_30,
                    Wrap(
                      spacing: 10, runSpacing: 10,
                      children: List.generate(dataList.length, (index) {
                        var item=dataList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.toNamed(AppRoutes.stakeNowByPackage,arguments: item)!.then((value) {
                              if(controller.isBalCryptoApi==false) {
                                controller.balance(true);
                                controller.currencyList(true, null);
                              }else{
                                controller.isBalCryptoApi=false;
                              }
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            width: (controller.screenWidth-70)/2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset( item == "2"?"assets/svg/dialog_crypto.svg":
                                "assets/svg/dialog_internal_wallet.svg",width: 70,height: 70),

                                heightSpace_10,
                                Text(item == "2"?"From Coin":"From Wallet",
                                    style: poppins(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600))

                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 15),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: grayishBlue_alpha_55,
                          borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Text("You can select any one type to stake.",
                          style: poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 10)),
                    ),


                  ],
                )),

          ],
        ));

  }

}
