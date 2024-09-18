import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../pages/bottom_bar.dart';
import '../api/model/activateUser/ActivateUserResponse.dart';
import '../api/model/activateUser/PackageList.dart';
import '../api/model/activateUser/TopupDataByUserId.dart';
import '../api/model/activateUser/WalletTypeList.dart';
import '../api/model/balance/AllowedWallet.dart';
import '../api/model/balance/AllowedWalletToCrypto.dart';
import '../api/model/balance/BalanceData.dart';
import '../api/model/balance/BalanceResponse.dart';
import '../api/model/dashboardData/DashboardData.dart';
import '../api/model/dashboardData/StakeBalanceResponse.dart';
import '../api/model/depositQr/GetTechnologyQrResponse.dart';
import '../api/model/fundRequest/Bank.dart';
import '../api/model/fundRequest/PaymentMode.dart';
import '../api/model/login/LoginResponse.dart';
import '../api/model/recentPinActivity/RecentPinActivityData.dart';
import '../api/model/report/ReportData.dart';
import '../api/model/support/ReferralContentResponse.dart';
import '../api/model/userDetails/UserDetailResponse.dart';
import '../common/ConstantString.dart';
import '../themes/AppTextTheme.dart';
import '../themes/ThemeColor.dart';
import '../themes/ThemeHeightWidth.dart';

enum Utility {
  INSTANCE;


  void dialogSingleButtonNoTitleWithCallback(String msg, bool isDissmisable, String btn, Function callback) {
    Get.defaultDialog(
        titleStyle: const TextStyle(fontSize: 0),
        title: "",
        radius: 15,
        onWillPop: () {
          return Future.value(false);
        },
        barrierDismissible: isDissmisable,
        titlePadding: const EdgeInsets.only(top: 0),
        contentPadding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        middleText: msg,
        middleTextStyle: const TextStyle(
            fontFamily: 'poppins',
            wordSpacing: 2,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w900),
        cancel: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: ElevatedButton(
              onPressed: () {
                Get.back(canPop: true);
                if (callback != null) {
                  callback("Cancel");
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: gray_3)))),
              child: Text(
                btn,
                style: const TextStyle(
                    fontFamily: 'inter',
                    color: gray_3,
                    fontSize: 15,
                    fontWeight: FontWeight.w800),
              )),
        ));
  }

  void dialogSingleButtonWithCallback(String title, String msg, bool isDissmisable, String btn, Function callback) {
    Get.defaultDialog(
        title: title,
        radius: 15,
        onWillPop: () {
          return Future.value(false);
        },
        barrierDismissible: isDissmisable,
        titlePadding: const EdgeInsets.only(top: 18),
        contentPadding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        middleText: msg,
        middleTextStyle: const TextStyle(
            fontFamily: 'poppins',
            wordSpacing: 2,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w900),
        cancel: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: ElevatedButton(
              onPressed: () {
                Get.back(canPop: true);
                if (callback != null) {
                  callback("Cancel");
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: gray_3)))),
              child: Text(
                btn,
                style: const TextStyle(
                    fontFamily: 'inter',
                    color: gray_3,
                    fontSize: 15,
                    fontWeight: FontWeight.w800),
              )),
        ));
  }

  void dialogDoubleButtonWithCallback(dynamic value, String title, String msg, bool isDissmisable, String posBtn, String negBtn, Function callBack) {
    Get.defaultDialog(
        title: title,
        radius: 15,
        onWillPop: () {
          return Future.value(false);
        },
        barrierDismissible: isDissmisable,
        titlePadding: const EdgeInsets.only(top: 18),
        contentPadding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        middleText: msg,
        middleTextStyle: const TextStyle(
            fontFamily: 'poppins',
            wordSpacing: 2,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w900),
        confirm: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: ElevatedButton(
              onPressed: () {
                Get.back(canPop: true);
                if (callBack != null) {
                  callBack(value);
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: green_3)))),
              child: Text(
                posBtn,
                style: const TextStyle(
                    fontFamily: 'inter',
                    color: green_3,
                    fontSize: 15,
                    fontWeight: FontWeight.w800),
              )),
        ),
        cancel: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: ElevatedButton(
              onPressed: () {
                Get.back(canPop: true);
              },
              style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: gray_3)))),
              child: Text(
                negBtn,
                style: const TextStyle(
                    fontFamily: 'inter',
                    color: gray_3,
                    fontSize: 15,
                    fontWeight: FontWeight.w800),
              )),
        ));
  }

  void dialogSingleButtonNoTitle(String msg, String btn) {
    if (Get.isDialogOpen == false) {
      Get.defaultDialog(
          titleStyle: const TextStyle(fontSize: 0),
          title: "",
          radius: 15,
          /* onWillPop: () {
          return Future.value(false);
        },*/
          barrierDismissible: false,
          titlePadding: const EdgeInsets.only(top: 0),
          contentPadding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          middleText: msg,
          middleTextStyle: const TextStyle(
              fontFamily: 'poppins',
              wordSpacing: 2,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w900),
          cancel: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ElevatedButton(
                onPressed: () {
                  Get.back(canPop: true);
                },
                style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll<Color>(Colors.white),
                    minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: green_2)))),
                child: Text(
                  btn,
                  style: const TextStyle(
                      fontFamily: 'inter',
                      color: green_2,
                      fontSize: 15,
                      fontWeight: FontWeight.w800),
                )),
          ));
    }
  }

  void dialogSingleButtonNoTitleBackScreen(String msg, String btn) {
    Get.defaultDialog(
        titleStyle: const TextStyle(fontSize: 0),
        title: "",
        radius: 15,
        onWillPop: () {
          return Future.value(false);
        },
        barrierDismissible: false,
        titlePadding: const EdgeInsets.only(top: 0),
        contentPadding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        middleText: msg,
        middleTextStyle: const TextStyle(
            fontFamily: 'poppins',
            wordSpacing: 2,
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w900),
        cancel: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: ElevatedButton(
              onPressed: () {
                Get.back(canPop: true, closeOverlays: true);
              },
              style: ButtonStyle(
                  backgroundColor:
                  const MaterialStatePropertyAll<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: green_2)))),
              child: Text(
                btn,
                style: const TextStyle(
                    fontFamily: 'inter',
                    color: green_2,
                    fontSize: 15,
                    fontWeight: FontWeight.w800),
              )),
        ));
  }

  void dialogSingleButtonBackScreen(String title, String msg, String btn) {
    Get.defaultDialog(
        title: title,
        radius: 15,
        onWillPop: () {
          return Future.value(false);
        },
        barrierDismissible: false,
        titlePadding: const EdgeInsets.only(top: 18),
        contentPadding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        middleText: msg,
        middleTextStyle: const TextStyle(
            fontFamily: 'poppins',
            wordSpacing: 2,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w900),
        cancel: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: ElevatedButton(
              onPressed: () {
                Get.back(canPop: true, closeOverlays: true);
              },
              style: ButtonStyle(
                  backgroundColor:
                  const MaterialStatePropertyAll<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: green_2)))),
              child: Text(
                btn,
                style: const TextStyle(
                    fontFamily: 'inter',
                    color: green_2,
                    fontSize: 15,
                    fontWeight: FontWeight.w800),
              )),
        ));
  }

  void dialogSingleButton(String title, String msg, String btn) {
    if (Get.isDialogOpen == false) {
      Get.defaultDialog(
          title: title,
          radius: 15,
          /* onWillPop: () {
          return Future.value(false);
        },*/
          barrierDismissible: false,
          titlePadding: const EdgeInsets.only(top: 18),
          contentPadding: const EdgeInsets.only(top: 15, left: 10, right: 10),
          middleText: msg,
          middleTextStyle: const TextStyle(
              fontFamily: 'poppins',
              wordSpacing: 2,
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w900),
          cancel: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ElevatedButton(
                onPressed: () {
                  Get.back(canPop: true);
                },
                style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll<Color>(Colors.white),
                    minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: green_2)))),
                child: Text(
                  btn,
                  style: const TextStyle(
                      fontFamily: 'inter',
                      color: green_2,
                      fontSize: 15,
                      fontWeight: FontWeight.w800),
                )),
          ));
    }
  }

  void dialogDoubleCustomButton(String title, String msg, String positive, String negative, Function callBack) {
    Get.defaultDialog(
        radius: 15,
        title: title,
        titlePadding: const EdgeInsets.only(top: 18),
        contentPadding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        middleText: msg,
        middleTextStyle: const TextStyle(
            fontFamily: 'poppins',
            wordSpacing: 2,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w900),
        cancel: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.back(canPop: true);
                    if (callBack != null) {
                      callBack("");
                    }

                    /* Get.to(LoginRegisterScreen());*/
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll<Color>(Colors.white),
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: green_2)))),
                  child: Text(
                    positive,
                    style: const TextStyle(
                        fontFamily: 'inter',
                        color: green_2,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Get.back(canPop: true);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll<Color>(Colors.white),
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: gray_4)))),
                  child: Text(
                    negative,
                    style: const TextStyle(
                        fontFamily: 'inter',
                        color: gray_4,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                  )),
            ],
          ),
        ));
  }

  void dialogIconWithThreeText(String svgIcon, String msg_1, String msg_2, String msg_3, String btn) {
    if (Get.isDialogOpen == false) {
      Get.dialog(
        Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15,15,15,5),
              margin: const EdgeInsets.only(left: 20,right:  20,top: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(svgIcon.isNotEmpty)
                    SvgPicture.asset("assets/svg/$svgIcon.svg",
                        height: 45, width: 45),
                  heightSpace_15,
                  if(msg_1.isNotEmpty)...[
                    Text(
                      msg_1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'poppins',
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    heightSpace_15
                  ],
                if(msg_2.isNotEmpty)...[
                  Text(
                    msg_2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'poppins',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  heightSpace_15
                  ],
                if(msg_3.isNotEmpty)...[
                  Text(
                    msg_3,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'poppins',
                        fontSize: 13,
                        color: gray_5,
                        fontWeight: FontWeight.w400),
                  ),
                  heightSpace_10,
                  ],
                  GestureDetector(
                    onTap: () => Get.back(canPop: true),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                      child: Text(
                        btn,
                        style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'poppins',
                            fontSize: 15,
                            color: orange_2,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));

    }
  }

  void dialogIconOneButtonBackScreen(String icon, String title, String msg,String btn) {
    if (Get.isDialogOpen == false) {
      Get.dialog(
          Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15,15,15,5),
              margin: const EdgeInsets.only(left: 20,right:  20,top: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(icon.isNotEmpty)
                  SvgPicture.asset("assets/svg/$icon.svg",
                      height: 45, width: 45),
                  heightSpace_15,
                  if(title.isNotEmpty)...[
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'poppins',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    heightSpace_15],
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15),
                    child: Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'poppins',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                  ),

                  GestureDetector(
                    onTap: () =>  Get.back(canPop: true,closeOverlays: true,result: 123),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                      child:  Text(
                        btn,
                        style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'poppins',
                            fontSize: 15,
                            color: gray_4,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  )

                ],
              ),
            ),
          )
      );

    }
  }

  void dialogIconOneButton(String icon, String title, String msg,String btn) {
    if (Get.isDialogOpen == false) {
      Get.dialog(
          Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15,15,15,5),
              margin: const EdgeInsets.only(left: 20,right:  20,top: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(icon.isNotEmpty)
                    SvgPicture.asset("assets/svg/$icon.svg",
                        height: 45, width: 45),
                  heightSpace_15,
                  if(title.isNotEmpty)...[
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'poppins',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    heightSpace_15],
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15),
                    child: Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'poppins',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                  ),

                  GestureDetector(
                    onTap: () =>  Get.back(canPop: true),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                      child:  Text(
                        btn,
                        style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'poppins',
                            fontSize: 15,
                            color: gray_4,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  )

                ],
              ),
            ),
          )
      );

    }
  }

  void dialogIconOneButtonWithCallback(String icon, String title, String msg,bool isDissmisable,String positiveBTn, Function callBack) {
    if (Get.isDialogOpen == false) {
      Future<bool> _onWillPop() async {
        return isDissmisable; //<-- SEE HERE
      }
      Get.dialog(
          barrierDismissible: isDissmisable,
          WillPopScope(
              onWillPop: _onWillPop,
              child: Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15,15,15,5),
              margin: const EdgeInsets.only(left: 20,right:  20,top: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(icon.isNotEmpty)
                    SvgPicture.asset("assets/svg/$icon.svg",
                        height: 45, width: 45),
                  heightSpace_15,

                  if(title.isNotEmpty)...[
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'poppins',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    heightSpace_15],
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15),
                    child: Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'poppins',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.back(canPop: true);
                      if (callBack != null) {
                        callBack("");
                      }},
                    child:  Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                      child:  Text(
                        positiveBTn,
                        style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'poppins',
                            fontSize: 15,
                            color: gray_4,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ))
      );

    }
  }

  void dialogIconTwoButtonWithCallback(String icon, String title, String msg,String positiveBTn,String negativeBTn, Function callBack) {
    if (Get.isDialogOpen == false) {
      Get.dialog(
          Center(

            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15,15,15,5),
              margin: const EdgeInsets.only(left: 20,right:  20,top: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(icon.isNotEmpty)
                    SvgPicture.asset("assets/svg/$icon.svg",
                        height: 45, width: 45),
                  heightSpace_15,

                    if(title.isNotEmpty)...[
                     Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'poppins',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    heightSpace_15],
                     Padding(
                       padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15),
                       child: Text(
                        msg,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'poppins',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                    ),
                     ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {  Get.back(canPop: true);
                        if (callBack != null) {
                          callBack(1);
                        }},
                        child:  Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                          child:  Text(
                            positiveBTn,
                            style: const TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'poppins',
                                fontSize: 15,
                                color: orange_2,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {  Get.back(canPop: true);
                        if (callBack != null) {
                          callBack(0);
                        }},
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                          child:  Text(
                            negativeBTn,
                            style: const TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'poppins',
                                fontSize: 15,
                                color: gray_3,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
          )
      );

    }
  }
  void dialogIconThreeButtonWithCallback(String icon, String title, String msg,String positiveBTn,String neutralBTn,String negativeBTn, Function callBack) {
    if (Get.isDialogOpen == false) {
      Get.dialog(
          Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15,15,15,5),
              margin: const EdgeInsets.only(left: 20,right:  20,top: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(icon.isNotEmpty)
                    SvgPicture.asset("assets/svg/$icon.svg",
                        height: 45, width: 45),
                  heightSpace_15,

                  if(title.isNotEmpty)...[
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'poppins',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    heightSpace_15],
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15),
                    child: Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'poppins',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {  Get.back(canPop: true);
                        if (callBack != null) {
                          callBack(2);
                        }},
                        child:  Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                          child:  Text(
                            neutralBTn,
                            style: const TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'poppins',
                                fontSize: 15,
                                color: red_2,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {  Get.back(canPop: true);
                        if (callBack != null) {
                          callBack(1);
                        }},
                        child:  Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                          child:  Text(
                            positiveBTn,
                            style: const TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'poppins',
                                fontSize: 15,
                                color: orange_2,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {  Get.back(canPop: true);
                        if (callBack != null) {
                          callBack(0);
                        }},
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                          child:  Text(
                            negativeBTn,
                            style: const TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'poppins',
                                fontSize: 15,
                                color: gray_3,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
          )
      );

    }
  }


  void bottomSheetIconTwoButtonWithCallback(String icon, String title, String msg,String positiveBTn,String negativeBTn, Function callBack) {
    if (Get.isDialogOpen == false) {
      Get.bottomSheet(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(15,15,15,5),
            margin: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(icon.isNotEmpty)
                  SvgPicture.asset("assets/svg/$icon.svg",
                      height: 45, width: 45),
                heightSpace_15,
                if(title.isNotEmpty)...[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'poppins',
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  heightSpace_15],
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15),
                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'poppins',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {  Get.back(canPop: true);
                      if (callBack != null) {
                        callBack(1);
                      }},
                      child:  Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                        child:  Text(
                          positiveBTn,
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'poppins',
                              fontSize: 15,
                              color: orange_2,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {  Get.back(canPop: true);
                      if (callBack != null) {
                        callBack(0);
                      }},
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                        child:  Text(
                          negativeBTn,
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'poppins',
                              fontSize: 15,
                              color: gray_3,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    )
                  ],
                )

              ],
            ),
          )
      );

    }
  }


  void showResponseDetailDialog(String title,ActivateUserResponse response) {
    Get.dialog(Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(top: 5),
              child: const Icon(Icons.cancel, color: Colors.white, size: 35),
            ),
          ),
          Flexible(
            child: Container(
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                padding: const EdgeInsets.fromLTRB(15,24,15,15),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if ((response.status ?? 0) > 0) ...[
                        if ((response.status ?? 0) == 1) ...[
                          Text("Pending",
                              textAlign: TextAlign.center,
                              style: poppins(
                                  color: orange_1,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24)),
                          heightSpace_10,
                          SvgPicture.asset("assets/svg/pending_icon.svg", width: 70, height: 70)
                        ]else if ((response.status ?? 0) == 2) ...[
                          Text("Success",
                              textAlign: TextAlign.center,
                              style: poppins(
                                  color: green_5,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25)),
                          heightSpace_10,
                          SvgPicture.asset("assets/svg/approve_icon.svg", width: 70, height: 70)
                        ]else...[
                          Text("Failed",
                              textAlign: TextAlign.center,
                              style: poppins(
                                  color: red_2,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24)),
                          heightSpace_10,
                          SvgPicture.asset("assets/svg/reject_icon.svg", width: 70, height: 70)
                        ]
                      ]
                      else...[
                        if ((response.statuscode ?? 0) == 1) ...[
                          Text("Success",
                              textAlign: TextAlign.center,
                              style: poppins(
                                  color: green_5,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25)),
                          heightSpace_10,
                          SvgPicture.asset("assets/svg/approve_icon.svg", width: 70, height: 70)
                        ]else...[
                          Text("Failed",
                              textAlign: TextAlign.center,
                              style: poppins(
                                  color: red_2,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24)),
                          heightSpace_10,
                          SvgPicture.asset("assets/svg/reject_icon.svg", width: 70, height: 70)
                        ]
                      ],

                      if(response.msg!=null && response.msg!.isNotEmpty)...[
                        heightSpace_10,
                        Text(response.msg??"",
                            textAlign: TextAlign.center,
                            style: poppins(
                                color: gray_4,
                                fontWeight: FontWeight.w600,
                                fontSize: 12)),
                      ],
                      heightSpace_20,

                      Row(
                        children: [
                          const Icon(Icons.verified, color: primaryColor, size: 20),
                          widthSpace_10,
                          Text("$title!",
                              style: poppins(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16)),
                          const Spacer(),
                          if(response.txnHash!=null && response.txnHash!.isNotEmpty)...[
                            TextButton(
                                onPressed: () {
                                  Utility.INSTANCE.urlLaunch("$HASH_URL${response.txnHash??""}");
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                                child: Text("Explore",
                                    style: poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12)))
                          ]

                        ],
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: primaryColor,width: 1)),
                        child: Column(
                          children: [
                             if (response.txnHash != null && response.txnHash!.isNotEmpty) ...[

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Txn Hash : ",
                                      style: poppins(
                                          color: primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  Flexible(
                                    child: SelectableText(response.txnHash ?? "",

                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)),
                                  )
                                ],
                              ),
                                ],
                                if ((response.tid ?? 0) > 0) ...[
                            heightSpace_7,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Txn Id : ",
                                      style: poppins(
                                          color: primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  Flexible(
                                    child: Text("${response.tid}",
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)),
                                  )
                                ],
                              ),
                                ],
                            if (double.parse(response.requestAmount ?? "0.0") > 0) ...[
                            heightSpace_7,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Req. Amount : ",
                                      style: poppins(
                                          color: primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  if(response.requestCurrecny!=null && response.requestCurrecny!.isNotEmpty)...[
                                    Flexible(
                                      child: Text("${Utility.INSTANCE.getCurrencySymbol(response.requestCurrecny??"")} ${ Utility.INSTANCE.formatedAmountWithOutRupees(response.requestAmount??0.0)}",
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11)),
                                    )
                                  ]else...[
                                    Flexible(
                                      child: Text(Utility.INSTANCE.formatedAmountWithOutRupees(response.requestAmount??0.0),
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11)),
                                    )
                                  ]

                                ],
                              ),
                                ],
                            if ((response.transactionAmount ?? 0) > 0) ...[
                            heightSpace_7,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Req. Amount : ",
                                      style: poppins(
                                          color: primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  if(response.requestCurrecny!=null && response.requestCurrecny!.isNotEmpty)...[
                                    Flexible(
                                      child: Text("${Utility.INSTANCE.getCurrencySymbol(response.requestCurrecny??"")} ${ Utility.INSTANCE.formatedAmountWithOutRupees(response.transactionAmount??0.0)}",
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11)),
                                    )
                                  ]else...[
                                    Flexible(
                                      child: Text(Utility.INSTANCE.formatedAmountWithOutRupees(response.transactionAmount??0.0),
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11)),
                                    )
                                  ]
                                ],
                              ),
                            ],
                            if ((response.amountinToWalletCurrency ?? 0) > 0) ...[
                            heightSpace_7,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Txn. Amount : ",
                                      style: poppins(
                                          color: primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  if(response.toCurrencyName!=null && response.toCurrencyName!.isNotEmpty)...[
                                    Flexible(
                                      child: Text("${Utility.INSTANCE.getCurrencySymbol(response.toCurrencyName??"")} ${ Utility.INSTANCE.formatedAmountWithOutRupees(response.amountinToWalletCurrency??0.0)}",
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11)),
                                    )
                                  ]else...[
                                    Flexible(
                                      child: Text(Utility.INSTANCE.formatedAmountWithOutRupees(response.amountinToWalletCurrency??0.0),
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11)),
                                    )
                                  ]
                                ],
                              ),
                            ],
                            if (response.stakeAmount != null && response.stakeAmount!.isNotEmpty) ...[
                            heightSpace_7,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Stake Amount : ",
                                      style: poppins(
                                          color: primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  Flexible(
                                    child: Text(response.stakeAmount??"0",
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)),
                                  )
                                ],
                              ),
                            ],
                            if (response.fromAddress != null && response.fromAddress!.isNotEmpty) ...[
                            heightSpace_7,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("From Address : ",
                                      style: poppins(
                                          color: primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  Flexible(
                                    child: SelectableText(response.fromAddress ?? "",
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)),
                                  )
                                ],
                              ),
                                ],
                                if (response.toAddress != null && response.toAddress!.isNotEmpty) ...[
                            heightSpace_7,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("To Address : ",
                                      style: poppins(
                                          color: primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  Flexible(
                                    child: SelectableText(response.toAddress ?? "",
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)),
                                  )
                                ],
                              ),
                            ],
                                if (double.parse(response.lockingPeriod ?? "0.0") > 0) ...[
                            heightSpace_7,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Locking Period : ",
                                      style: poppins(
                                          color: primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  Flexible(
                                    child: Text(Utility.INSTANCE.formatedAmountWithOutRupees(response.lockingPeriod??0.0),
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)),
                                  )
                                ],
                              ),
                                ],
                                if (double.parse(response.monthlyMinting ?? "0.0") > 0) ...[
                            heightSpace_7,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Monthly Minting : ",
                                      style: poppins(
                                          color: primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  Flexible(
                                    child: Text(Utility.INSTANCE.formatedAmountWithOutRupees(response.monthlyMinting??0.0),
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)),
                                  )
                                ],
                              ),
                                ],
                                if ((response.topUpAmount ?? 0) > 0) ...[
                            heightSpace_7,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Topup Amount : ",
                                      style: poppins(
                                          color: primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  Flexible(
                                    child: Text(Utility.INSTANCE.formatedAmountWithOutRupees(response.topUpAmount??0.0),
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)),
                                  )
                                ],
                              ),
                                ],
                                if (response.topupDate != null && response.topupDate!.isNotEmpty) ...[

                            heightSpace_7,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Topup Date : ",
                                      style: poppins(
                                          color: primaryColorLight,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12)),
                                  Flexible(
                                    child: Text(response.topupDate ?? "",
                                        style: poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11)),
                                  )
                                ],
                              ),
                          ],
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),


        ],
      ),
    ));
  }

  String formatedAmountWithRupees(dynamic value) {
    String num = value.toString();
    if (num.isNotEmpty) {
      if (num.contains(".")) {
        String postfixValue = num.substring(num.indexOf("."));
        if (postfixValue == ".0") {
          return "\u20B9 ${num.replaceAll(".0", "").trim()}";
        } else if (postfixValue == ".00") {
          return "\u20B9 ${num.replaceAll(".00", "").trim()}";
        } else if (postfixValue == ".000") {
          return "\u20B9 ${num.replaceAll(".000", "").trim()}";
        } else if (postfixValue == ".0000") {
          return "\u20B9 ${num.replaceAll(".0000", "").trim()}";
        } else if (postfixValue == ".00000") {
          return "\u20B9 ${num.replaceAll(".00000", "").trim()}";
        } else if (postfixValue == ".000000") {
          return "\u20B9 ${num.replaceAll(".000000", "").trim()}";
        } else if (postfixValue == ".0000000") {
          return "\u20B9 ${num.replaceAll(".0000000", "").trim()}";
        } else if (postfixValue == ".00000000") {
          return "\u20B9 ${num.replaceAll(".00000000", "").trim()}";
        } else if (postfixValue == ".000000000") {
          return "\u20B9 ${num.replaceAll(".000000000", "").trim()}";
        } else {
          try {
            return "\u20B9 ${value.toStringAsFixed(2).replaceAll(RegExp("0*\$"), "")}";
          } catch (e) {
            return "\u20B9 ${num.trim()}";
          }
        }
      } else {
        return "\u20B9 ${num.trim()}";
      }
    } else {
      return "\u20B9 0";
    }
  }



  String formatedAmountWithOutRupees(dynamic value) {
    String num="";
    if(value is double) {
       num = value.toString();
    }else{
       num = value;
    }
    if (num.isNotEmpty) {
      if (num.contains(".")) {
        String postfixValue = num.substring(num.indexOf("."));
        if (postfixValue == ".0") {
          return num.replaceAll(".0", "").trim();
        } else if (postfixValue == ".00") {
          return num.replaceAll(".00", "").trim();
        } else if (postfixValue == ".000") {
          return num.replaceAll(".000", "").trim();
        } else if (postfixValue == ".0000") {
          return num.replaceAll(".0000", "").trim();
        } else if (postfixValue == ".00000") {
          return num.replaceAll(".00000", "").trim();
        } else if (postfixValue == ".000000") {
          return num.replaceAll(".000000", "").trim();
        } else if (postfixValue == ".0000000") {
          return num.replaceAll(".0000000", "").trim();
        } else if (postfixValue == ".00000000") {
          return num.replaceAll(".00000000", "").trim();
        } else if (postfixValue == ".000000000") {
          return num.replaceAll(".000000000", "").trim();
        } else {
          try {
            return value.toStringAsFixed(2).replaceAll(RegExp("0*\$"), "");
          } catch (e) {
            return num.trim();
          }
        }
      } else {
        return num.trim();
      }
    } else {
      return "0";
    }
  }


  String formatedAmountNinePlace(dynamic value) {
    String num="";
    if(value is double) {
      num = value.toString();
    }else{
      num = value;
    }
    if (num.isNotEmpty) {
      if (num.contains(".")) {
        String postfixValue = num.substring(num.indexOf("."));
        if (postfixValue == ".0") {
          return num.replaceAll(".0", "").trim();
        } else if (postfixValue == ".00") {
          return num.replaceAll(".00", "").trim();
        } else if (postfixValue == ".000") {
          return num.replaceAll(".000", "").trim();
        } else if (postfixValue == ".0000") {
          return num.replaceAll(".0000", "").trim();
        } else if (postfixValue == ".00000") {
          return num.replaceAll(".00000", "").trim();
        } else if (postfixValue == ".000000") {
          return num.replaceAll(".000000", "").trim();
        } else if (postfixValue == ".0000000") {
          return num.replaceAll(".0000000", "").trim();
        } else if (postfixValue == ".00000000") {
          return num.replaceAll(".00000000", "").trim();
        } else if (postfixValue == ".000000000") {
          return num.replaceAll(".000000000", "").trim();
        }else if (postfixValue == ".0000000000") {
          return num.replaceAll(".0000000000", "").trim();
        }else if (postfixValue == ".00000000000") {
          return num.replaceAll(".00000000000", "").trim();
        }else if (postfixValue == ".000000000000") {
          return num.replaceAll(".000000000000", "").trim();
        }else if (postfixValue == ".0000000000000") {
          return num.replaceAll(".0000000000000", "").trim();
        }else if (postfixValue == ".00000000000000") {
          return num.replaceAll(".00000000000000", "").trim();
        }else if (postfixValue == ".000000000000000") {
          return num.replaceAll(".000000000000000", "").trim();
        }else if (postfixValue == ".0000000000000000") {
          return num.replaceAll(".0000000000000000", "").trim();
        }else if (postfixValue == ".00000000000000000") {
          return num.replaceAll(".00000000000000000", "").trim();
        }else if (postfixValue == ".000000000000000000") {
          return num.replaceAll(".000000000000000000", "").trim();
        }else if (postfixValue == ".0000000000000000000") {
          return num.replaceAll(".0000000000000000000", "").trim();
        }else if (postfixValue == ".00000000000000000000") {
          return num.replaceAll(".00000000000000000000", "").trim();
        } else {
          try {
            return value.toStringAsFixed(9).replaceAll(RegExp("0*\$"), "");
          } catch (e) {
            return num.trim();
          }
        }
      } else {
        return num.trim();
      }
    } else {
      return "0";
    }
  }
  String formatedAmountSixPlace(double value) {
    String num = value.toString();
    if (num.isNotEmpty) {
      if (num.contains(".")) {
        String postfixValue = num.substring(num.indexOf("."));
        if (postfixValue == ".0") {
          return num.replaceAll(".0", "").trim();
        } else if (postfixValue == ".00") {
          return num.replaceAll(".00", "").trim();
        } else if (postfixValue == ".000") {
          return num.replaceAll(".000", "").trim();
        } else if (postfixValue == ".0000") {
          return num.replaceAll(".0000", "").trim();
        } else if (postfixValue == ".00000") {
          return num.replaceAll(".00000", "").trim();
        } else if (postfixValue == ".000000") {
          return num.replaceAll(".000000", "").trim();
        } else if (postfixValue == ".0000000") {
          return num.replaceAll(".0000000", "").trim();
        } else if (postfixValue == ".00000000") {
          return num.replaceAll(".00000000", "").trim();
        } else if (postfixValue == ".000000000") {
          return num.replaceAll(".000000000", "").trim();
        }else if (postfixValue == ".0000000000") {
          return num.replaceAll(".0000000000", "").trim();
        }else if (postfixValue == ".00000000000") {
          return num.replaceAll(".00000000000", "").trim();
        }else if (postfixValue == ".000000000000") {
          return num.replaceAll(".000000000000", "").trim();
        }else if (postfixValue == ".0000000000000") {
          return num.replaceAll(".0000000000000", "").trim();
        }else if (postfixValue == ".00000000000000") {
          return num.replaceAll(".00000000000000", "").trim();
        }else if (postfixValue == ".000000000000000") {
          return num.replaceAll(".000000000000000", "").trim();
        }else if (postfixValue == ".0000000000000000") {
          return num.replaceAll(".0000000000000000", "").trim();
        }else if (postfixValue == ".00000000000000000") {
          return num.replaceAll(".00000000000000000", "").trim();
        }else if (postfixValue == ".000000000000000000") {
          return num.replaceAll(".000000000000000000", "").trim();
        }else if (postfixValue == ".0000000000000000000") {
          return num.replaceAll(".0000000000000000000", "").trim();
        }else if (postfixValue == ".00000000000000000000") {
          return num.replaceAll(".00000000000000000000", "").trim();
        } else {
          try {
            return value.toStringAsFixed(6).replaceAll(RegExp("0*\$"), "");
          } catch (e) {
            return num.trim();
          }
        }
      } else {
        return num.trim();
      }
    } else {
      return "0";
    }
  }

  String formatedAmountReplaceLastZero(String num) {

    if (num.isNotEmpty) {
      if (num.contains(".")) {
        String postfixValue = num.substring(num.indexOf("."));
        if (postfixValue == ".0") {
          return num.replaceAll(".0", "").trim();
        } else if (postfixValue == ".00") {
          return num.replaceAll(".00", "").trim();
        } else if (postfixValue == ".000") {
          return num.replaceAll(".000", "").trim();
        } else if (postfixValue == ".0000") {
          return num.replaceAll(".0000", "").trim();
        } else if (postfixValue == ".00000") {
          return num.replaceAll(".00000", "").trim();
        } else if (postfixValue == ".000000") {
          return num.replaceAll(".000000", "").trim();
        } else if (postfixValue == ".0000000") {
          return num.replaceAll(".0000000", "").trim();
        } else if (postfixValue == ".00000000") {
          return num.replaceAll(".00000000", "").trim();
        } else if (postfixValue == ".000000000") {
          return num.replaceAll(".000000000", "").trim();
        }else if (postfixValue == ".0000000000") {
          return num.replaceAll(".0000000000", "").trim();
        }else if (postfixValue == ".00000000000") {
          return num.replaceAll(".00000000000", "").trim();
        }else if (postfixValue == ".000000000000") {
          return num.replaceAll(".000000000000", "").trim();
        }else if (postfixValue == ".0000000000000") {
          return num.replaceAll(".0000000000000", "").trim();
        }else if (postfixValue == ".00000000000000") {
          return num.replaceAll(".00000000000000", "").trim();
        }else if (postfixValue == ".000000000000000") {
          return num.replaceAll(".000000000000000", "").trim();
        }else if (postfixValue == ".0000000000000000") {
          return num.replaceAll(".0000000000000000", "").trim();
        }else if (postfixValue == ".00000000000000000") {
          return num.replaceAll(".00000000000000000", "").trim();
        }else if (postfixValue == ".000000000000000000") {
          return num.replaceAll(".000000000000000000", "").trim();
        }else if (postfixValue == ".0000000000000000000") {
          return num.replaceAll(".0000000000000000000", "").trim();
        }else if (postfixValue == ".00000000000000000000") {
          return num.replaceAll(".00000000000000000000", "").trim();
        } else {
          try {
            return num.replaceAll(RegExp("0*\$"), "");
          } catch (e) {
            return num.trim();
          }
        }
      } else {
        return num.trim();
      }
    } else {
      return "0";
    }
  }

  String getTime(int days) {
    if (days == 30) {
      return "MONTH";
    } else if (days > 30) {
      int months = days ~/ 30;
      if (days % 30 == 0 || days % 31 == 0) {
        if (months > 12) {
          int year = months ~/ 30;
          return year == 1 ? "YEAR" : "$year YEARS";
        } else if (months == 12) {
          return "YEAR";
        }
        return months == 1 ? "MONTH" : "$months MONTHS";
      } else {
        int remainDays = days - (months * 30);
        return "$months${months == 1 ? " MONTH " : " MONTHS "}$remainDays DAYS";
      }
    }
    return days == 1 ? "DAY" : "$days DAYS";
  }

  getCurrentDate() {
    String cdate = DateFormat("dd-MMM-yyyy").format(DateTime.now());
    return cdate;
  }

  Future<void> urlLaunch(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
  String formatedDateWithT(String dateStr) {
    if (dateStr.isNotEmpty && !dateStr.contains("1900")) {
      var inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      var outputFormat = DateFormat("dd MMM yyyy hh:mm aa");
      return outputFormat.format(inputFormat.parse(dateStr.replaceAll("T", " ")));
    }
    return "-";
  }
  String formatedDateWithSlash(String dateStr) {
    if (dateStr.isNotEmpty) {
      var inputFormat = DateFormat("MM/dd/yyyy hh:mm:ss aa");
      var outputFormat = DateFormat("dd MMM yyyy hh:mm:ss aa");
      return outputFormat.format(inputFormat.parse(dateStr));
    }
    return "-";
  }

  String formatedDateWithSlashAndMS(String dateStr) {
    if (dateStr.isNotEmpty) {
      var inputFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
      var outputFormat = DateFormat("dd MMM yyyy hh:mm aa");
      return outputFormat.format(inputFormat.parse(dateStr));
    }
    return "-";
  }
  copyText(String tv, String type) async {
    Clipboard.setData(ClipboardData(text: tv)).then((value) => null);
    showSnackbar("Copy", "$type copy to clipboard");
  }

  share(String shareMsg,String? link, String type, String title) async {
    await FlutterShare.share(
        title: type,
        text: shareMsg,
        linkUrl: link,
        chooserTitle: title);
  }

  showSnackbar(String title, String msg) {
    if (Get.isSnackbarOpen) {
      return;
    }

    Get.snackbar(
      title,
      msg,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      titleText: Text(title,
          style: const TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w900)),
      messageText: Text(msg,
          style: const TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700)),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
    );
  }

  String getCurrencySymbol(String symbol) {

    if (symbol.isNotEmpty) {
      if (symbol.toLowerCase()=="usdt"
          || symbol.toLowerCase()=="usd") {
        return "\$";
      } else if (symbol.toLowerCase()=="inr"
          || symbol.toLowerCase()=="rupee"|| symbol.toLowerCase()=="indian rupees") {
        return "\u20B9";
      } else {
        return symbol;
      }
    }
    return symbol;
  }

  Future<void> logout(GetStorage storage, bool isRedirect) async {
    await storage.erase();
    await Get.delete(force: true);
    await Get.delete<LoginResponse>(force: true);
    await Get.delete<BalanceResponse>(tag: BALANCE_DATA,force: true);
    await Get.delete<DashboardData>(tag: DASHBOARD_DATA,force: true);
    await Get.delete<UserDetailResponse>(tag: USER_DATA,force: true);
    await Get.delete<GetTechnologyQrResponse>(force: true);
    await Get.delete<List<RecentPinActivityData>>(tag: RECENT_PIN_ACTIVITY_DATA,force: true);
    await Get.delete<StakeBalanceResponse>(tag: STAKE_BALANCE_DATA,force: true);
    await Get.delete<ReferralContentResponse>(tag: REFERRAL_CONTENT_DATA,force: true);
    /*await Get.delete<BankPaymentModeResponse>(tag: BANK_AND_PAYMENT_MODE, force: true);*/
    if(isRedirect==true) {
      //await Get.offAllNamed(AppRoutes.login);
      Navigator.pushReplacement(Get.context!,
          PageTransition(type: PageTransitionType.fade, child: BottomBar(index: 4)));
    }
  }


  openCalender(context ,DateTime firstDate,DateTime initialDate, DateTime lastDate, Function callBack) async {
    await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: primaryColor,
              dialogTheme: const DialogTheme(backgroundColor: primaryColorMoreLight),
              colorScheme: const ColorScheme.light(primary: primaryColor),
              buttonTheme: const ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child!,
          );
        },
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate).then((value) {
      if(value!=null && callBack!=null) {
        callBack(value);
      }
    });
  }

  String formatDate(DateTime value) {
    return DateFormat("dd MMM yyyy").format(value);
  }



  void showBottomSheet<T>(String title, List<T> list,bool isLevel, Function? callBack) {

    Get.bottomSheet(
        isScrollControlled: true,

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Padding(
                    padding: EdgeInsets.only(top: 5,bottom: 5),
                    child: Icon(Icons.cancel,
                        color: Colors.white, size: 35))),
            Flexible(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 15, right: 15,top: 30,bottom: 15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                    Text("$title!",
                        style: poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20)),
                    heightSpace_15,
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var item = list[index];
                          return GestureDetector(
                            onTap: () {
                              Get.back();
                              if(callBack!=null){
                                callBack(item);
                              }

                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: primaryColorMoreLight,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (item is Bank) ...[
                                    Expanded(
                                      child: Text(item.bankName ?? "",
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    )
                                  ]else if (item is PaymentMode) ...[
                                    Expanded(
                                      child: Text(item.mode ?? "",
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    )
                                  ]else if (item is BalanceData) ...[
                                    Expanded(
                                      child: Text(item.walletType ?? "",
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    )
                                  ]else if (item is AllowedWallet) ...[
                                    Expanded(
                                      child: Text(item.walletName ?? "",
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    )
                                  ]else if (item is ReportData && isLevel==true) ...[
                                    Expanded(
                                      child: Text(item.levelNo==0?"All":"${item.levelNo ?? 0}",
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    )
                                  ]else if (item is ReportData ) ...[
                                    Expanded(
                                      child: Text("${item.name ?? 0}",
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    )
                                  ]else if (item is AllowedWalletToCrypto ) ...[
                                    Expanded(
                                      child: Text(item.symbolName ?? "",
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    )
                                  ] else if (item is WalletTypeList) ...[
                                    Expanded(
                                        child: Text(item.name ?? "",
                                            style: poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14)),
                                      )
                                    ] else if (item is PackageList) ...[
                                    Expanded(
                                        child: Text(item.packageName ?? "",
                                            style: poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14)),
                                      )
                                    ] else if (item is TopupDataByUserId) ...[
                                    Expanded(
                                        child: Text(item.name ?? "",
                                            style: poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14)),
                                      )
                                    ] else...[
                                    Expanded(
                                      child: Text("$item",
                                          style: poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)),
                                    )
                                  ],
                                  widthSpace_5,
                                  const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 14,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) { return heightSpace_10; },
                        itemCount: list.length

                      ),
                    )
                  ])),
            ),

          ],
        ));
  }
}
