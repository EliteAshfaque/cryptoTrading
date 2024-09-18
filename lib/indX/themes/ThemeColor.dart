import 'dart:ui';
import 'package:flutter/material.dart';

const Color accentColor = Color(0xffF5BC04);
const Color primaryColorDark = Color(0xff095ea4);
const Color primaryColor = Color(0xff1B7AC8);
const Color primaryColorLight = Color(0xff47BCF7);
const Color primaryColorMoreLight = Color(0xff96d9fc);
const Color grayishBlue = Color(0xff8084AD);
const Color grayishBlue_alpha_55 = Color(0x8c8084ad);
const Color grayishBlue_alpha_22 = Color(0x388084ad);
const Color lightPurple = Color(0xffBFABFF);
const Color primaryColor_alpha_54 = Color(0x8a191b28);
const Color primaryBlack = Color(0xff141915);
const Color primaryShadowGrey = Color(0xffC9C9C9);
const Color gray_1 = Color(0xFFF2F2F2);
const Color gray_2 = Color(0xFFE5E5E5);
const Color gray_3 = Color(0xFFBCBCBC);
const Color gray_4 = Color(0xFFA4A4A4);
const Color gray_5 = Color(0xFF727272);
const Color gray_6 = Color(0xFF40413B);
const Color yellow_alpha = Color(0x2EF5BC04);
const Color yellow_1 = Color(0xFFF5DE0E);
const Color yellow_2 = Color(0xFFFCBC04);
const Color orange_1 = Color(0xFFE59730);
const Color orange_2 = Color(0xFFE56000);
const Color greenMoreLight = Color(0xFFECFFEB);
const Color greenLight = Color(0xFF96EC92);
const Color green_1 = Color(0xFF5E955F);
const Color green_2 = Color(0xFF468D4B);
const Color green_3 = Color(0xFF326F36);
const Color green_4 = Color(0xFF275F2B);
const Color green_5 = Color(0xFFA1D51C);
const Color green_6 = Color(0xFF46730E);
const Color green_7 = Color(0xFF027769);
const Color red_1 = Color(0xFFFF0000);
const Color red_2 = Color(0xFFE10000);
const Color red_3 = Color(0xFFAD0303);
const Color blue_1 = Color(0xFF0025E1);
const Color blue_2 = Color(0xFF011477);
const Color blue_3 = Color(0xFF00BFE1);

ThemeData get themeData {
  ColorScheme colorSchemeMovieApp = const ColorScheme(
    // primary green
    primary: primaryColor,
    // primary blue
    primaryContainer: Color(0xff239DD1),
    // gradient 1
    surface: gray_1,
    // gradient 2
    background: gray_2,
    // secondary grey
    //secondary: Color(0xffF1F3F4),
    secondary: Color(0xff2E2739),
    // secondary dark grey
    secondaryContainer: Color(0xff606260),
    // secondary red
    error: Color(0xffE2173A),
    // primary green
    onPrimary: Color(0xFFFFFFFF),
    // primary blue
    onSecondary: Color(0xff239DD1),
    // secondary grey
    onSurface: Color(0xff2E2739),
    // secondary dark grey
    onBackground: Color(0xff606260),
    // secondary red
    onError: Color(0xffE2173A),
    // white
    brightness: Brightness.light,
  );

  return ThemeData.from(colorScheme: colorSchemeMovieApp);
}
