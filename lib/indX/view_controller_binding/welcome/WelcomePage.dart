import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [primaryColorLight, primaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svg/logo.svg",
                  width: size.width - 150),
              heightSpace_30,
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.login);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      side: const BorderSide(color: Colors.white),
                      minimumSize: Size((size.width - 150), 50)),
                  child: Text("Login",
                      style: poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 24))),
              heightSpace_30,
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.signup,arguments: false);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      elevation: 0,
                      minimumSize: Size((size.width - 150), 50)),
                  child: Text("Signup",
                      style: poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 24)))
            ]),
      ),
    );
  }
}
