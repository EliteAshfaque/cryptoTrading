import 'dart:convert';

import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/screens.dart';
import 'package:cryptox/util/countDownTimer.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api/base.dart';
import '../../util/ToastUtil.dart';

class EmailOTP extends StatefulWidget {
  String email;
  Function verify;
  EmailOTP({Key? key,required this.email,required this.verify}) : super(key: key);

  @override
  _EmailOTP createState() => _EmailOTP();
}

class _EmailOTP extends State<EmailOTP> {

  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();
  final GlobalKey<CountdownTimerNew> myChildWidgetKey = GlobalKey();

  bool otpObs = false;

  String maskedEmail = "";
  bool showMaskedEmail = true;
  final commonWidget = Com();
  final register = Register();

  @override
  void initState() {
    super.initState();

      List<String> dummy = widget.email.split("@");
      String mask = "";
      if(dummy.length > 0) {
        int len = dummy[0].length;
        print(len);
        dummy[0] = dummy[0].replaceRange(2, len, "********");
        mask = dummy[0] + "@" + dummy[1];
      }
      setState(() {
        maskedEmail = mask;
      });

    //getOtp();

  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          height20Space,
          Text("Enter OTP",textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18
          )),
          height20Space,
          Form(
            key: _resetFormKey,
            child: Column(
              children: [
                commonWidget.inputBoxDesignWithLength(Icons.pin,6, otpController, "Otp",
                    validatorOTP, otpObs, false, () => {}, TextInputType.number,(val) => {},
                    0,0,formatters: Com.validateField(decimal: 0,regex: numberRegExp)),
              ],
            ),
          ),
          height20Space,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    style: black14MediumTextStyle,
                  ),
                ),
              ),
              SizedBox(width: 20,),
              InkWell(
                onTap: () {
                  if(_resetFormKey.currentState!.validate()) {
                    verifyEmail();
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
                    'Verify',
                    style: white14MediumTextStyle,
                  ),
                ),
              ),
            ],
          ),
          height20Space,
          if(showMaskedEmail)
            Text("Otp sent on $maskedEmail",textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600)),
          height20Space,
          CountDownTimer(key: myChildWidgetKey,duration: timerDuration,
              onClick: () {
                sendEmailOtp();
                myChildWidgetKey.currentState?.resetTimer();
                myChildWidgetKey.currentState?.startTimer();
                myChildWidgetKey.currentState?.changeResendState();
              })
          // CountDownTimer(key: myChildWidgetKey,duration: Duration(seconds: 10),
          //     showMyWidget: true, onClick: () {getOtp();})
        ],
      ),
    );
  }

  sendEmailOtp() async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      LoadingOverlay.showLoader(context);
      var signUp = await client.sendEmailVerifyOtp({"email": widget.email});
      if (kDebugMode) {print(jsonEncode(signUp));}
      if (signUp.success) {
        showToast(signUp.result['message'],gravity: ToastGravity.BOTTOM,toast: Toast.LENGTH_LONG);
      }else {
        showToast(signUp.result['error'],gravity: ToastGravity.BOTTOM,toast: Toast.LENGTH_LONG);
      }
      LoadingOverlay.hideLoader(context);
    } catch (e) {
      print("ERROR " + e.toString());
      LoadingOverlay.hideLoader(context);
    }
  }

  /*getOtp() {
    apiCalls.updateMobile(context, {"email": widget.email,
      "otp": otpController.text}).then((value) {
      setState(() {
        showMaskedEmail = value;
      });
    });
  }*/

  verifyEmail() async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      LoadingOverlay.showLoader(context);
      var res = await client.verifyActiveOtp({"email": widget.email, "otp": otpController.text});
      if (kDebugMode) {print(jsonEncode(res));}
      if (res.success) {
        if(widget.verify!=null){
          widget.verify();
        }
        showToast(res.result['message'],gravity: ToastGravity.BOTTOM,toast: Toast.LENGTH_LONG);
        Navigator.pop(context);
      }else {
        showToast(res.result['error'],gravity: ToastGravity.BOTTOM,toast: Toast.LENGTH_LONG);
      }
      LoadingOverlay.hideLoader(context);
    } catch (e) {
      print("ERROR " + e.toString());
      LoadingOverlay.hideLoader(context);
    }
  }
 /* verifyEmail() async {
    LoadingOverlay.showLoader(context);
    IUserStruct? res = await apiCalls.verifyVerificationOtp(context,
        {"email": widget.email, "otp": otpController.text});
    LoadingOverlay.hideLoader(context);

  }*/

  validatorOTP(String val) {
    if(val.length != 6) {
      return 'Otp length should be 6 digits.';
    }
    return null;
  }



}