import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final TextAlign textAlign;

  const CustomText({
    Key? key,
    this.text = '',
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.fontColor = Colors.black,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
      ),
      textAlign: textAlign,
    );
  }
}
