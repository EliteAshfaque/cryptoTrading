
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../themes/ThemeColor.dart';
import '../../widgets/LoadingIndicator.dart';
import 'SplashController.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) => SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [primaryColorLight,primaryColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Obx(() => controller.isShowLoader.value==true?
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset("assets/svg/logo.svg",width: MediaQuery.of(context).size.width-100),
              const Positioned(
                bottom: 0,
                child: LoadingIndicator(
                    heading: '',
                    text: '',
                    textColor: Colors.black,
                    loadingColor: accentColor),
              )
            ],
          ):
          Center(child: SvgPicture.asset("assets/svg/logo.svg",width: MediaQuery.of(context).size.width-100),)),
        ),
      ),
    );
  }


}
