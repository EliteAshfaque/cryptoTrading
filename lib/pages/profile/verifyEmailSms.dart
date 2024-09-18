import 'dart:async';
import 'dart:convert';
import 'package:cryptox/api/user/enableAuth/enableAuth.dart';
import 'package:cryptox/api/user/getUser/getUser.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/util/countDownTimer.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifyEmailSms extends StatefulWidget {
  final String maskedEmail;
  final String authType;
  final IUserStruct userDetails;

  const VerifyEmailSms(
      {Key? key,
      required this.maskedEmail,
      required this.userDetails,
      required this.authType})
      : super(key: key);

  @override
  _VerifyEmailSms createState() => _VerifyEmailSms();
}

class _VerifyEmailSms extends State<VerifyEmailSms> {
  final GlobalKey<CountdownTimerNew> myChildWidgetKey = GlobalKey();
  TextEditingController smsOtpController = new TextEditingController();
  TextEditingController emailOtpController = new TextEditingController();
  TextEditingController tOtpController = new TextEditingController();
  final GlobalKey<FormState> _submitOtpFormKey = GlobalKey<FormState>();
  late StreamSubscription enableAuthSubscription;
  late StreamSubscription verifyOtpSubscription;
  late StreamSubscription userDetailsSubscription;
  bool showEmailOtpBox = false;
  bool showSmsOtpBox = false;
  bool showQr = true;
  bool showGoogleAuth = false;
  String imgSrc = "";
  String gAuthSecret = "";
  final commonWidget = Com();

  @override
  void initState() {
    super.initState();
    enableAuthSubscription = apiCalls.dummyMasterAuth$.listen((value) {
      if (value is String) {
        LoadingOverlay.hideLoader(context);
        return;
      }
      if (value is MasterAuthStruct) {
        setState(() {
          showEmailOtpBox = value.isEmailReq!;
          showSmsOtpBox = value.isSmsReq!;
        });
      }
    });
    verifyOtpSubscription = apiCalls.otpResp$.listen((value) {
      if (value is String) {
        if (value.isEmpty) {
          LoadingOverlay.hideLoader(context);
          return;
        } else {
          setState(() {
            List<String> val = value.split("...");
            if (val.length > 0) {
              imgSrc = val[1].split(",")[1];
              gAuthSecret = val[0];
            }
            showGoogleAuth = true;
          });
          LoadingOverlay.hideLoader(context);
        }
      }
    });
    userDetailsSubscription = apiCalls.iUser$.listen((value) {
      if (value is String) {
        LoadingOverlay.hideLoader(context);
        return;
      }
      if (value is IUserStruct) {
        LoadingOverlay.hideLoader(context);
        Navigator.pop(context);
      }
    });
    if (widget.userDetails.authType != MasterAuthType.google_auth.name) {
      apiCalls.enableUserAuth(widget.authType, context);
    } else {
      print('This is Runnubng');
      showGoogleAuth = true;
      showQr = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    enableAuthSubscription.cancel();
    verifyOtpSubscription.cancel();
    userDetailsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      body: showGoogleAuth
          ? Center(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  children: [
                    Text(
                      showQr
                          ? "Scan  Qr Code on Authenticator App."
                          : "Enter Authenticator OTP.",
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    showQr
                        ? Image.memory(base64Decode(imgSrc),
                            height: 150, width: 320)
                        : Container(),
                    height5Space,
                    showQr
                        ? Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                                color: Color(0xFF222224),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(gAuthSecret,
                                      style: TextStyle(
                                          color: whiteColor, fontSize: 12),
                                      overflow: TextOverflow.ellipsis),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(
                                              ClipboardData(text: gAuthSecret))
                                          .then((value) {
                                        showToast("Copied on clipboard.",
                                            gravity: ToastGravity.BOTTOM,
                                            toast: Toast.LENGTH_LONG);
                                      });
                                    },
                                    child: Icon(
                                      Icons.copy_all,
                                      color: primaryColor,
                                      size: 25,
                                    ))
                              ],
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 12,
                    ),
                    commonWidget.inputBoxDesign(
                        Icons.mobile_screen_share_outlined,
                        tOtpController,
                        "TOtp",
                        dummyValidator,
                        false,
                        false,
                        () => {},
                        TextInputType.number,
                        maxLength: 6,
                        (val) => {},
                        20.0,
                        20.0),
                    height20Space,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: (width - fixPadding * 14.0) / 2,
                            padding: EdgeInsets.symmetric(vertical: fixPadding),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 1.0,
                                color: primaryColor,
                              ),
                              color: whiteColor,
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (tOtpController.text.isNotEmpty) {
                              Object obj = {
                                "type": widget.authType,
                                "otp": tOtpController.text
                              };
                              LoadingOverlay.showLoader(context);
                              apiCalls.updateUserSettings(obj, context);
                            }
                          },
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: (width - fixPadding * 14.0) / 2,
                            padding: EdgeInsets.symmetric(vertical: fixPadding),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: primaryColor,
                            ),
                            child: Text(
                              'Submit',
                              style: white14MediumTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    height20Space,
                    Text(
                      'OTP send successfully on' + ' ${widget.maskedEmail}',
                      style: black16BoldTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    height20Space,
                    Form(
                      key: _submitOtpFormKey,
                      child: Column(
                        children: [
                          if (showEmailOtpBox)
                            commonWidget.inputBoxDesign(
                                Icons.email,
                                emailOtpController,
                                "email OTP",
                                dummyValidator,
                                false,
                                false,
                                () => {},
                                TextInputType.number,
                                maxLength: 6,
                                (val) => {},
                                20.0,
                                20.0,
                                formatters: Com.validateField(
                                    decimal: 0, regex: numberRegExp)),
                          height20Space,
                          if (showSmsOtpBox)
                            commonWidget.inputBoxDesign(
                                Icons.sms,
                                smsOtpController,
                                "sms Otp",
                                dummyValidator,
                                false,
                                false,
                                () => {},
                                TextInputType.number,
                                (val) => {},
                                20.0,
                                20.0,
                                formatters: Com.validateField(
                                    decimal: 0, regex: numberRegExp)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: (width - fixPadding * 14.0) / 2,
                            padding: EdgeInsets.symmetric(vertical: fixPadding),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 1.0,
                                color: primaryColor,
                              ),
                              color: whiteColor,
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (_submitOtpFormKey.currentState!.validate()) {
                              var arr = [];
                              if (showSmsOtpBox) {
                                arr.add({
                                  "type": MasterAuthType.sms.name,
                                  "otp": smsOtpController.text
                                });
                              }
                              if (showEmailOtpBox) {
                                arr.add({
                                  "type": MasterAuthType.email.name,
                                  "otp": emailOtpController.text
                                });
                              }
                              Object obj = {
                                "type": widget.authType,
                                "data": arr
                              };
                              LoadingOverlay.showLoader(context);
                              apiCalls.verifyUserAuth(obj, context);
                            }
                          },
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: (width - fixPadding * 14.0) / 2,
                            padding: EdgeInsets.symmetric(vertical: fixPadding),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: primaryColor,
                            ),
                            child: Text(
                              'Submit',
                              style: white14MediumTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CountDownTimer(
                        key: myChildWidgetKey,
                        duration: timerDuration,
                        onClick: () {
                          apiCalls.enableUserAuth(widget.authType, context);
                          myChildWidgetKey.currentState?.resetTimer();
                          myChildWidgetKey.currentState?.startTimer();
                          myChildWidgetKey.currentState?.changeResendState();
                        })
                  ],
                ),
              ),
            ),
    );
  }

  dummyValidator(String val) {
    return null;
  }
}
