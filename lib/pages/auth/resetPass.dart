import 'dart:convert';

import 'package:cryptox/pages/auth/login.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/widget/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api/base.dart';
import '../../util/ToastUtil.dart';

class ResetPass extends StatefulWidget {
  @override
  _ResetPass createState() => _ResetPass();
}

class _ResetPass extends State<ResetPass> {

  final commonWidget = Com();
  final GlobalKey<FormState> _resetFormKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();
  bool emailObs = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset('assets/Images/authTopLeftCut.png'),
              Positioned(
                  right: 10,
                  top: 10,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel_outlined,color: Colors.grey.shade400)
                  )
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Reset Password',
                style: black28w500TextStyle,
              ),
              height20Space,
              Form(
                key: _resetFormKey,
                child: Column(
                  children: [
                    commonWidget.inputBoxDesign(Icons.email_outlined, emailController, "Email",
                        emailValidator, emailObs, false, () => {}, TextInputType.emailAddress,(val) => {},
                        20.0,20.0),
                  ],
                ),
              ),
              height20Space,
              heightSpace,
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: InkWell(
                  onTap: () {
                    if(_resetFormKey.currentState!.validate()) {
                      resetPassword();
                    }
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: 150,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: primaryColor,
                    ),
                    child: Text(
                      'Continue',
                      style: white14BoldTextStyle,
                    ),
                  ),
                ),
              ),
              height20Space,
              Center(child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text("Login",style: grey14BoldTextStyle)))
            ],
          ),
        ],
      ),
    );
  }

  emailValidator(String val) {
    if (RegExp('[A-Za-z0-9._%-]+@[A-Za-z0-9._%-]+\.[a-z]+').hasMatch(val)) {
      return null;
    }
    return "Check Email";
  }

  resetPassword() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final dio = Dio();
    final client = RestClient(dio);
    try {
      LoadingOverlay.showLoader(context);
      var resetPass = await client.resetUserPass(emailController.text);
      if (kDebugMode) {print(jsonEncode(resetPass));}
      if (resetPass.success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(resetPass.result['message']),
        ));
        Navigator.pop(context);
      }else {
        showToast(resetPass.result['error'],gravity: ToastGravity.BOTTOM,toast: Toast.LENGTH_LONG);
      }
      LoadingOverlay.hideLoader(context);
    } catch (e) {
      print("ERROR " + e.toString());
      LoadingOverlay.hideLoader(context);
    }
  }
}
