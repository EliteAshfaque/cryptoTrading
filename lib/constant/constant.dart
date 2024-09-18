import 'package:flutter/material.dart';

const String _ClickOnVerified = "ClickOnVerified";
const String email = "email";
const String name = "name";
const String token = "token";
const String countryCode = "countryCode";
const String phone = "phone";
const String isAdmin = "isAdmin";
const String userId = "UserId";
const String mobileTokenKey = "mobileToken";
const String formFilledStatus = "FormFilledStatus";
const String userSavedCoinList = "userSavedCoinList";
const String isDeleteApproval = "isDeleteApproval";
const String isUserVerified = "userVerified";
const String sessionId = "sessionId";
const double inrVal = 80.05;
const int decimal = 6;
const Duration timerDuration = Duration(seconds: 60);

// const Color primaryColor = const Color(0xFF4B6AFF);
// const Color primaryColor = const Color(0xFFE6B508);
const Color primaryColor = const Color(0xFFE4B328);
const Color primaryColor2 = const Color(0xFF272727);
const Color blue = const Color(0xFF1A8FAF);
const Color green = const Color(0xFF86D9AB);
const Color goldenYellow = const Color(0xFFFFC000);
const Color brickRed = const Color(0xFFFA2256);






// const Color primaryColor2 = const Color(0xFF6666FF);
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const Color greyColor = const Color(0xFF8F8F8F);
const Color redColor = const Color(0xFFFF0000);
const Color orangeColor = const Color(0xFFFFA500);
const Color greenColor = const Color(0xFF006400);
const Color scaffoldBgColor = const Color(0xFFF2F4F6);
// const Color scaffoldBgColor = const Color(0xFF241720);

RegExp numberRegExp = RegExp(r'\d');
RegExp networkRegExp =
    RegExp(r'^(0x[a-fA-F0-9]{40}|T[1-9A-HJ-NP-Za-km-z]{33})$');

const double fixPadding = 10.0;

const defaultPadding = 16.0;

const SizedBox heightSpace = const SizedBox(height: 10.0);

const SizedBox height5Space = const SizedBox(height: 5.0);

const SizedBox height20Space = const SizedBox(height: 20.0);

const SizedBox height30Space = const SizedBox(height: 30.0);

const SizedBox widthSpace = const SizedBox(width: 10.0);

const SizedBox width5Space = const SizedBox(width: 5.0);

const SizedBox width20Space = const SizedBox(width: 20.0);

const usdtInr = 'USDTINR';

const TextStyle appBarTextStyle = const TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: blackColor,
);

const TextStyle appBarWhiteTextStyle = const TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: whiteColor,
);

const TextStyle black12RegularTextStyle = const TextStyle(
  fontSize: 12.0,
  color: blackColor,
);

const TextStyle buySellPercentagesTextStyle =
    const TextStyle(color: blackColor, fontWeight: FontWeight.w700);

const TextStyle black14RegularTextStyle = const TextStyle(
  fontSize: 14.0,
  color: blackColor,
);

const TextStyle black16RegularTextStyle = const TextStyle(
  fontSize: 16.0,
  color: blackColor,
);

const TextStyle black14BoldTextStyle = const TextStyle(
  fontSize: 14.0,
  color: blackColor,
  fontWeight: FontWeight.bold,
);

const TextStyle black12MediumTextStyle = const TextStyle(
  fontSize: 12.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

const TextStyle black13MediumTextStyle = const TextStyle(
  fontSize: 13.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

const TextStyle black14MediumTextStyle = const TextStyle(
  fontSize: 14.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

const TextStyle black16MediumTextStyle = const TextStyle(
  fontSize: 16.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

const TextStyle black18MediumTextStyle = const TextStyle(
  fontSize: 18.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

const TextStyle black14SemiBoldTextStyle = const TextStyle(
  fontSize: 14.0,
  color: blackColor,
  fontWeight: FontWeight.w600,
);

const TextStyle black16SemiBoldTextStyle = const TextStyle(
  fontSize: 16.0,
  color: blackColor,
  fontWeight: FontWeight.w600,
);

const TextStyle black8w500TextStyle = const TextStyle(
  fontSize: 10.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

const TextStyle black14w600TextStyle = const TextStyle(
    fontSize: 14.0, color: blackColor, fontWeight: FontWeight.w600);

const TextStyle black18SemiBoldTextStyle = const TextStyle(
  fontSize: 18.0,
  color: blackColor,
  fontWeight: FontWeight.w600,
);

const TextStyle black16BoldTextStyle = const TextStyle(
  fontSize: 16.0,
  color: blackColor,
  fontWeight: FontWeight.bold,
);

const TextStyle black18BoldTextStyle = const TextStyle(
  fontSize: 18.0,
  color: blackColor,
  fontWeight: FontWeight.bold,
);

const TextStyle black22BoldTextStyle = const TextStyle(
  fontSize: 22.0,
  color: blackColor,
  fontWeight: FontWeight.bold,
);

const TextStyle black22BoldTextStyle1 = const TextStyle(
  fontSize: 18.0,
  color: blackColor,
  fontWeight: FontWeight.bold,
);

const TextStyle black10w600TextStyle = const TextStyle(
  fontSize: 10.0,
  color: blackColor,
  fontWeight: FontWeight.w600,
);

const TextStyle white12MediumTextStyle = const TextStyle(
  fontSize: 12.0,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

const TextStyle white14MediumTextStyle = const TextStyle(
  fontSize: 14.0,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

const TextStyle white16MediumTextStyle = const TextStyle(
  fontSize: 16.0,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

const TextStyle white18MediumTextStyle = const TextStyle(
  fontSize: 18.0,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

const TextStyle black28w500TextStyle = const TextStyle(
  fontSize: 28.0,
  color: blackColor,
  fontWeight: FontWeight.w500,
);

const TextStyle white48MediumTextStyle = const TextStyle(
  fontSize: 48.0,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

const TextStyle white12SemiBoldTextStyle = const TextStyle(
  fontSize: 12.0,
  color: whiteColor,
  fontWeight: FontWeight.w600,
);
const TextStyle white12BoldTextStyle = const TextStyle(
  fontSize: 12.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle white16SemiBoldTextStyle = const TextStyle(
  fontSize: 16.0,
  color: whiteColor,
  fontWeight: FontWeight.w600,
);

const TextStyle white14BoldTextStyle = const TextStyle(
  fontSize: 14.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle white16BoldTextStyle = const TextStyle(
  fontSize: 16.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle white18BoldTextStyle = const TextStyle(
  fontSize: 18.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);const TextStyle white22BoldTextStyle = const TextStyle(
  fontSize: 22.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle white26BoldTextStyle = const TextStyle(
  fontSize: 26.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle white36BoldTextStyle = const TextStyle(
  fontSize: 36.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle white36BoldTextStyle1 = const TextStyle(
  fontSize: 22.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle white44BoldTextStyle = const TextStyle(
  fontSize: 44.0,
  color: whiteColor,
  fontWeight: FontWeight.bold,
);

const TextStyle primaryColor12RegularTextStyle = const TextStyle(
  fontSize: 12.0,
  color: primaryColor,
);

const TextStyle primaryColor14RegularTextStyle = const TextStyle(
  fontSize: 14.0,
  color: primaryColor,
);

const TextStyle primaryColor14MediumTextStyle = const TextStyle(
  fontSize: 14.0,
  color: primaryColor,
  fontWeight: FontWeight.w500,
);

const TextStyle primaryColor16MediumTextStyle = const TextStyle(
  fontSize: 16.0,
  color: primaryColor,
  fontWeight: FontWeight.w500,
);

const TextStyle primaryColor16BoldTextStyle = const TextStyle(
  fontSize: 16.0,
  color: primaryColor,
  fontWeight: FontWeight.bold,
);

const TextStyle primaryColor18BoldTextStyle = const TextStyle(
  fontSize: 18.0,
  color: primaryColor,
  fontWeight: FontWeight.bold,
);

const TextStyle primaryColor22BoldTextStyle = const TextStyle(
  fontSize: 22.0,
  color: primaryColor,
  fontWeight: FontWeight.bold,
);

const TextStyle grey12RegularTextStyle = const TextStyle(
  fontSize: 12.0,
  color: greyColor,
);

const TextStyle grey14RegularTextStyle = const TextStyle(
  fontSize: 14.0,
  color: greyColor,
);

const TextStyle grey12MediumTextStyle = const TextStyle(
  fontSize: 12.0,
  color: greyColor,
  fontWeight: FontWeight.w500,
);

const TextStyle grey12MediumItalicTextStyle = const TextStyle(
  fontSize: 14.0,
  color: greyColor,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.italic,
);

const TextStyle grey14MediumTextStyle = const TextStyle(
  fontSize: 14.0,
  color: greyColor,
  fontWeight: FontWeight.w500,
);

const TextStyle grey16MediumTextStyle = const TextStyle(
  fontSize: 16.0,
  color: greyColor,
  fontWeight: FontWeight.w500,
);

const TextStyle grey12BoldTextStyle = const TextStyle(
  fontSize: 12.0,
  color: greyColor,
  fontWeight: FontWeight.bold,
);

const TextStyle grey14BoldTextStyle = const TextStyle(
  fontSize: 14.0,
  color: greyColor,
  fontWeight: FontWeight.bold,
);

const TextStyle grey16BoldTextStyle = const TextStyle(
  fontSize: 16.0,
  color: greyColor,
  fontWeight: FontWeight.bold,
);

const TextStyle grey18BoldTextStyle = const TextStyle(
  fontSize: 18.0,
  color: greyColor,
  fontWeight: FontWeight.bold,
);

const TextStyle grey20BoldTextStyle = const TextStyle(
  fontSize: 20.0,
  color: greyColor,
  fontWeight: FontWeight.bold,
);

const TextStyle green14MediumTextStyle = const TextStyle(
  fontSize: 14.0,
  color: greenColor,
  fontWeight: FontWeight.w500,
);

const TextStyle red14MediumTextStyle = const TextStyle(
  fontSize: 14.0,
  color: redColor,
  fontWeight: FontWeight.w500,
);

const TextStyle red16MediumTextStyle = const TextStyle(
  fontSize: 16.0,
  color: redColor,
  fontWeight: FontWeight.w500,
);
