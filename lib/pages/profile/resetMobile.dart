import 'dart:async';

import 'package:cryptox/api/user/getUser/getUser.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/screens.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:cryptox/util/countDownTimer.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';

class ResetMobile extends StatefulWidget {
  String mobileNo;
  ResetMobile({Key? key,required this.mobileNo}) : super(key: key);

  @override
  _ResetMobile createState() => _ResetMobile();
}

class _ResetMobile extends State<ResetMobile> {

  TextEditingController otpController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();
  final GlobalKey<CountdownTimerNew> myChildWidgetKey = GlobalKey();
  late StreamSubscription userDetailsSubscription;
  bool otpObs = false;
  bool phoneObs = false;
  String maskedEmail = "";
  bool showMaskedEmail = false;
  final commonWidget = Com();
  final register = Register();

  @override
  void initState() {
    super.initState();
    getUserEmail().then((value) {
      List<String> dummy = value.split("@");
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
    });
    getOtp();
    userDetailsSubscription = apiCalls.updatePhone$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if(value is IUserStruct) {
        setValueForKey(phone,value.phone.toString());
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => BottomBar(index: 4),
        ));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    userDetailsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 40),
          Text("Update Phone",textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18
          )),
          height20Space,
          Form(
            key: _resetFormKey,
            child: Column(
              children: [
                commonWidget.inputBoxDesign(Icons.person, phoneController, "Phone",
                    register.createState().phoneValidator, phoneObs, false, () => {}, TextInputType.number,
                        (val) => {},20.0,20.0,formatters: Com.validateField(decimal: 0,regex: numberRegExp)),
                height20Space,
                commonWidget.inputBoxDesignWithLength(Icons.pin,6, otpController, "Otp",
                    validatorOTP, otpObs, false, () => {}, TextInputType.number,(val) => {},
                    20.0,20.0,formatters: Com.validateField(decimal: 0,regex: numberRegExp)),
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
                    changeNumber();
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
                    'Update',
                    style: white14MediumTextStyle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          if(showMaskedEmail)
            Text("Otp sent on $maskedEmail",textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600)),
          heightSpace,
          CountDownTimer(key: myChildWidgetKey,duration: timerDuration,
              onClick: () {
                getOtp();
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

  getOtp() {
    apiCalls.updateMobile(context, {"phone": widget.mobileNo,
      "otp": otpController.text}).then((value) {
      setState(() {
        showMaskedEmail = value;
      });
    });
  }

  changeNumber() {
    LoadingOverlay.showLoader(context);
    apiCalls.updateMobile(context, {"phone": phoneController.text,
      "otp": otpController.text});
  }

  validatorOTP(String val) {
    if(val.length != 6) {
      return 'Otp length should be 6 digits.';
    }
    return null;
  }



}