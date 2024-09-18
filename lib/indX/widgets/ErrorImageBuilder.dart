import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../themes/ThemeColor.dart';

class ErrorImageBuilder extends StatelessWidget {
  const ErrorImageBuilder(
      {super.key,
      required this.containerHeight,
      required this.containerWidth,
      required this.iconHeight,
      this.colorBackground,
      this.colorIcon});

  final double? containerHeight;
  final double? containerWidth;
  final double? iconHeight;
  final Color? colorBackground;
  final Color? colorIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBackground ?? gray_1,
      height: containerHeight,
      width: containerWidth,
      alignment: Alignment.center,
      child:  SvgPicture.asset("assets/svg/logo.svg",height: iconHeight),
    );
  }
}
