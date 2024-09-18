import 'dart:async';

import 'package:cryptox/api/masterAuth/allMasterAuth/allMasterAuth.dart';
import 'package:cryptox/api/user/getUser/getUser.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/profile/verifyEmailSms.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';

class TwoFactorAuth extends StatefulWidget {
  const TwoFactorAuth({Key? key}) : super(key: key);

  @override
  _TwoFactorAuth createState() => _TwoFactorAuth();
}

class _TwoFactorAuth extends State<TwoFactorAuth> {
  late StreamSubscription userDetailsSubscription;
  late StreamSubscription masterAuthSubscription;
  late IUserStruct userDetails;
  String maskedEmail = "";
  bool showEmail = false;
  bool showSms = false;
  bool showNone = false;
  bool showGAuth = false;
  bool emailChecked = false;
  bool noneChecked = false;
  bool smsChecked = false;
  bool gAuthChecked = false;
  bool showQr = true;

  final commonWidget = Com();

  @override
  void initState() {
    super.initState();
    userDetailsSubscription = apiCalls.iUser$.listen((value) {
      if (value is String) {
        return;
      }
      if (value is IUserStruct) {
        List<String> dummy = value.email!.split("@");
        String mask = "";
        if (dummy.length > 0) {
          int len = dummy[0].length;
          print(len);
          dummy[0] = dummy[0].replaceRange(2, len, "********");
          mask = dummy[0] + "@" + dummy[1];
        }
        setState(() {
          emailChecked = value.authType == MasterAuthType.email.name;
          smsChecked = value.authType == MasterAuthType.sms.name;
          gAuthChecked = value.authType == MasterAuthType.google_auth.name;
          noneChecked = value.authType == MasterAuthType.none.name;
          maskedEmail = mask;
          userDetails = value;
        });
      }
    });
    masterAuthSubscription = apiCalls.allMasterAuth$.listen((value) {
      if (value is String) {
        return;
      }
      if (value is DummyMasterAuthStruct) {
        setState(() {
          showEmail = value.email!;
          showSms = value.sms!;
          showNone = value.none!;
          showGAuth = value.googleAuth!;
        });
      }
    });
    apiCalls.getMasterAuth(context).then((value) {
      if (value) {
        apiCalls.getIUserDetails(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    userDetailsSubscription.cancel();
    masterAuthSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
          gradient: Com.barGradient(),
        )),
        title: Text(
          'Two Factor Auth',
          style: white16SemiBoldTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: ListView(
          children: [
            if (showGAuth)
              cardEntryStruct(
                  headText: "Authenticator App Recommended",
                  authType: MasterAuthType.google_auth.name,
                  bodyText: "Highly secure",
                  checked: gAuthChecked),
            height20Space,
            if (showEmail)
              cardEntryStruct(
                  headText: "Email",
                  faText: "2FA enabled on" + " $maskedEmail",
                  bodyText: "Moderately secure",
                  checked: emailChecked,
                  flag: true,
                  authType: MasterAuthType.email.name),
            // height20Space,
            // if(showSms)
            // cardEntryStruct(headText: "Mobile SMS",
            //     bodyText: "Moderately secure", checked: smsChecked, authType: MasterAuthType.sms.name),
            height20Space,
            if (showNone)
              cardEntryStruct(
                  headText: "None",
                  authType: MasterAuthType.none.name,
                  bodyText: "Not secure",
                  checked: noneChecked),
          ],
        ),
      ),
    );
  }

  Widget cardEntryStruct(
      {String? headText,
      String? bodyText,
      String? faText,
      bool? checked,
      bool? flag,
      String? authType}) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: primaryColor),
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            spreadRadius: 1.0,
            color: blackColor.withOpacity(0.05),
          ),
        ],
      ),
      child: CheckboxListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(headText!,
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0)),
            height5Space,
            Text(bodyText!,
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0)),
            if (flag ?? false)
              Column(
                children: [
                  height5Space,
                  Text(faText ?? "",
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.0)),
                ],
              )
          ],
        ),
        value: checked!,
        onChanged: (value) {
          // apiCalls.enableUserAuth();
          setState(() {
            checked = value!;
          });
          if ((authType != 'none' && noneChecked == true) ||
              (authType == 'none' && noneChecked == false) ||
              (authType != 'none' && noneChecked == true) ||
              (authType == ' email' && noneChecked == false))
            otpDialogs(authType!);
        },
      ),
    );
  }

  otpDialogs(String authType) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: primaryColor)),
            height: (authType == 'none' && noneChecked == true)
                ? 200
                : authType == 'email'
                    ? 400
                    : 400,
            child: VerifyEmailSms(
                maskedEmail: maskedEmail,
                userDetails: userDetails,
                authType: authType),
          ),
        );
      },
    );
  }
}
