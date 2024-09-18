import 'dart:async';
import 'dart:io';

import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/profile/verifyEmailSms.dart';
import 'package:cryptox/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:upgrader/upgrader.dart';

import '../common/check_internet_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? apiTimer;


  @override
  void initState() {

    apiTimer = Timer(Duration(seconds: 3), () {
      apiTimer!.cancel();
      Navigator.pushReplacement(context,
          PageTransition(type: PageTransitionType.fade, child: BottomBar()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              child: Text(
                'ONEFX',
                style: white44BoldTextStyle,
              ),
            ),
            Positioned(
              bottom: 30.0,
              child: Container(
                width: width,
                child: SpinKitRing(
                  color: whiteColor,
                  size: 50.0,
                  lineWidth: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
