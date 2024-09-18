import 'package:flutter/cupertino.dart';

import 'ThemeColor.dart';

TextStyle poppins({
  Color color = primaryBlack,
  double fontSize = 16,
  double? height,
  TextDecoration decoration=TextDecoration.none,
  FontWeight fontWeight = FontWeight.normal
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    height: height,
    decoration: decoration,
    fontWeight: fontWeight,
    fontFamily: "poppins",
  );
}

TextStyle inter({
  Color color = primaryBlack,
  double fontSize = 16,
  double? height,
  TextDecoration decoration=TextDecoration.none,
  FontWeight fontWeight = FontWeight.normal,
  String fontFamily = 'inter',
}) {
  return TextStyle(
    color: color,
    decoration: decoration,
    height: height,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: fontFamily,
  );
}