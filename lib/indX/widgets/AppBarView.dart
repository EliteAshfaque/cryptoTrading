import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AppBarView extends StatelessWidget {
  const AppBarView(
      {super.key, required this.titleText,required this.bodyWidget,this.titleImagePath, this.isImageTitle, this.bgColor, this.action});

  final String titleText;
  final String? titleImagePath;
  final Widget bodyWidget;
  final bool? isImageTitle;
  final Color? bgColor;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          actions: [action??Container()],
           /* toolbarHeight: 44,*/
            iconTheme: const IconThemeData(color: Colors.white),
           /* backgroundColor: gray_2,*/
           title: isImageTitle==true?
    ((titleImagePath!=null && titleImagePath!.isNotEmpty)?
    Image.asset(titleImagePath??"",height: 23):
    SvgPicture.asset("assets/svg/app_logo_color.svg",height: 23)):
    Text(titleText, style: const TextStyle(color: Colors.white))),

        body: bodyWidget);
  }
}
