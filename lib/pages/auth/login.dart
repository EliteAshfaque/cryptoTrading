import 'dart:convert';
import 'dart:io';

import 'package:cryptox/pages/auth/resetPass.dart';
import 'package:cryptox/pages/screens.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/widget/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:upgrader/upgrader.dart';

import '../../Interceptors/TokenInterceptor.dart';
import '../../api/base.dart';
import '../../api/login/login.dart';
import '../../common/check_internet_controller.dart';
import '../../util/SharedPref.dart';
import '../../util/ToastUtil.dart';
import 'googleMobileReffralUpdate.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DateTime? currentBackPressTime;
  final commonWidget = Com();
  final TextEditingController controller = TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool emailObs = false;
  bool passObs = true;
  bool otpObs = false;
  bool showOtp = false;
  bool showResend = false;
  String uniqueLogId = "";
  String otpPlaceHolder = "";

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
                      child: Icon(Icons.cancel_outlined,
                          color: Colors.grey.shade400))),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'SignIn',
                style: black28w500TextStyle,
              ),
              height20Space,
              Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      commonWidget.inputBoxDesign(
                          Icons.email_outlined,
                          emailController,
                          "Email",
                          emailValidator,
                          emailObs,
                          false,
                          _toggle,
                          TextInputType.emailAddress,
                          (val) => {},
                          20.0,
                          20.0),
                      if (showResend)
                        Padding(
                          padding: const EdgeInsets.only(right: 20, top: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(emailController.text);
                                  if (emailValid) {
                                    resendVerificationLink();
                                  }
                                },
                                child: Text("Resend Link",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                        ),
                      height20Space,
                      commonWidget.inputBoxDesign(
                          Icons.lock_outline_sharp,
                          passController,
                          "Password",
                          passValidator,
                          passObs,
                          true,
                          _toggle,
                          TextInputType.text,
                          (val) => {},
                          20.0,
                          20.0),
                      if (showOtp)
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: commonWidget.inputBoxDesign(
                              Icons.password,
                              otpController,
                              otpPlaceHolder,
                              otpValidator,
                              emailObs,
                              false,
                              _toggle,
                              TextInputType.number,
                              maxLength: 6,
                              (val) => {},
                              20.0,
                              20.0),
                        ),
                      heightSpace,
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: ResetPass()));
                              },
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 16.0),
                                  child: Text("forgot password ?",
                                      style: TextStyle(
                                          color: Color(0xFFBBB0B0),
                                          fontWeight: FontWeight.w500))),
                            )),
                      )
                    ],
                  )),
              height30Space,
              InkWell(
                onTap: () {
                  if (_loginFormKey.currentState!.validate()) {

                    loginUser();
                  }
                },
                child: Container(
                  width: 150,
                  height: 50.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: primaryColor,
                  ),
                  child: Text(
                    'LOGIN',
                    style: white14BoldTextStyle,
                  ),
                ),
              ),
              height20Space,
              Row(
                children: [
                  Expanded(
                      child: Divider(
                          color: Colors.black, indent: 20, endIndent: 15)),
                  Text("Or",
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: blackColor,
                        fontWeight: FontWeight.w600,
                      )),
                  Expanded(
                      child: Divider(
                          color: Colors.black, indent: 15, endIndent: 20)),
                ],
              ),
              height20Space,
              // InkWell(
              //   onTap: () async {
              //     signInWithGoogle();
              //   },
              //   child: Container(
              //     width: 230,
              //     height: 50.0,
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(30.0),
              //       color: Colors.white,
              //     ),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SvgPicture.asset("assets/svg/google_g.svg", width: 20),
              //         widthSpace,
              //         Text(
              //           'Sign In With Google',
              //           style: black14BoldTextStyle,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              height30Space,
              Center(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don’t have account? ",
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat'),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Register",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Montserrat')),
                          ],
                        ),
                      ))),
              height20Space
            ],
          ),
        ],
      ),
    );
  }

  void signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
        clientId:
            "244599114225-99fgrnostmpkmq1jb01vkoa6krvcbfcs.apps.googleusercontent.com",
        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/userinfo.email'
        ]);

    GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
    if (_googleUser != null) {
      /*{displayName: Roundpay Training, email: roundpaytraining@gmail.com, id: 112318304271655988599, photoUrl: https://lh3.googleusercontent.com/a/ACg8ocLrVe7ZUKMqtr2Wav1TvH8Ofe3m5aVtKTTLAh444A5ttX6Qhw=s96-c, serverAuthCode: 4/0ATx3LY4oxzbV4PjT-iJqAoshTdrzhbZWHnnEkB3Q7wKqdD6PUFCUmY960Gv5DZ7dGTAMmw}*/
      String? _googleUserEmail = _googleUser.email;
      _googleSignIn.signOut();
      if (_googleUserEmail != null && _googleUserEmail.isNotEmpty) {
        googleLoginUser(_googleUserEmail);
      } else {
        showToast("Email id not found",
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
    } else {
      _googleSignIn.signOut();
      showToast("Cancelled by user or Details is not available",
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
    }

    /* if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;

    }*/
  }

  emailValidator(String val) {
    if (RegExp('[A-Za-z0-9._%-]+@[A-Za-z._%-]+\.[a-z]+').hasMatch(val)) {
      return null;
    }
    return "Invalid email format";
  }

  passValidator(String val) {
    return null;
  }

  otpValidator(String val) {
    if (val.length != 6) {
      return 'Otp length should be 6.';
    }
    return null;
  }

  _toggle() {
    // print("VALUE " + passObs.toString());
    setState(() {
      passObs = !passObs;
    });
  }

  loginUser() async {

    final dio = Dio();
    // dio.interceptors.add(TokenInterceptor(context: context));

    final client = RestClient(dio);
    try {
      LoadingOverlay.showLoader(context);

      var login = await client.loginUser({
        "email": emailController.text,
        "password": passController.text,
        "otp": otpController.text,
        "uniqueLogId": uniqueLogId
      });
      if (kDebugMode) {
        print(jsonEncode(login));
      }
      if (login.success) {
        LoginResult res = LoginResult.fromJson(login.result['message']);
        if (res.authType != MasterAuthType.none &&
            res.status == LoginStatus.In_Progress) {
          setState(() {
            showOtp = true;
            uniqueLogId = res.uniqueLogId!;
            otpPlaceHolder = checkAuthType(res.authType!);
          });
        } else {
          showToast("Successfully logged In.",
              gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
          addStringToSF(
              email: res.email,
              admin: res.isAdmin,
              name: res.name,
              countryCode: res.countryCode,
              phone: res.phone,
              token: res.token,
              sessionId: res.uniqueLogId,
              isDeleteApproval: res.isDeleteApproval,
              userVerified: res.active);
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: BottomBar(),
            ),
          );
        }
      } else {
        showToast(login.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (login.result['error']
            .toString()
            .startsWith("Please Verify your email first")) {
          setState(() {
            showResend = true;
          });
        }
      }
      LoadingOverlay.hideLoader(context);
    } catch (e) {
      print("ERROR " + e.toString());
      LoadingOverlay.hideLoader(context);
    }
  }

  googleLoginUser(String email) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(context: context));

    final client = RestClient(dio);
    try {
      LoadingOverlay.showLoader(context);
      var login =
          await client.googleLoginUser({"email": email, "signType": "Google"});
      if (kDebugMode) {
        print(jsonEncode(login));
      }
      if (login.success) {
        LoginResult res = LoginResult.fromJson(login.result['message']);
        /*if(res.authType != MasterAuthType.none && res.status == LoginStatus.In_Progress) {
          setState(() {
            showOtp = true;
            uniqueLogId = res.uniqueLogId!;
            otpPlaceHolder = checkAuthType(res.authType!);
          });
        }else {*/
        showToast("Successfully logged In.",
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        addStringToSF(
            email: res.email,
            admin: res.isAdmin,
            name: res.name,
            countryCode: res.countryCode,
            phone: res.phone,
            token: res.token,
            sessionId: res.uniqueLogId,
            isDeleteApproval: res.isDeleteApproval,
            userVerified: res.active);
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: BottomBar(),
          ),
        );
        /* }*/
      } else {
        showToast(login.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (login.result['error']
            .toString()
            .startsWith("Please Verify your email first")) {
          setState(() {
            showResend = true;
          });
        } else if (login.result['error']
            .toString()
            .startsWith("Please update your phone number")) {
          updateGoogleDetailsView("", email);
        }
      }
      LoadingOverlay.hideLoader(context);
    } catch (e) {
      print("ERROR " + e.toString());
      LoadingOverlay.hideLoader(context);
    }
  }

  updateGoogleDetailsView(String id, String email) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(fixPadding * 2.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GoogleMobileReffralUpdate(id: id, email: email),
              ),
            ],
          ),
        );
      },
    );
  }

  String checkAuthType(MasterAuthType val) {
    var otpPlaceHolder = "";
    switch (val) {
      case MasterAuthType.sms:
        {
          otpPlaceHolder = "Enter Sms Otp.";
          showToast("Otp Sent on Mobile.",
              gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
          break;
        }
      case MasterAuthType.email:
        {
          otpPlaceHolder = "Enter Email Otp.";
          showToast("Otp Sent on Email.",
              gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
          break;
        }
      case MasterAuthType.google_auth:
        {
          otpPlaceHolder = "Enter  Auth App OTP.";
          showToast("Check  Auth App for OTP.",
              gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
          break;
        }
      case MasterAuthType.none:
        {
          break;
        }
    }
    return otpPlaceHolder;
  }

  resendVerificationLink() async {
    final dio = Dio();
    final client = RestClient(dio);
    setState(() {
      showResend = false;
    });
    try {
      LoadingOverlay.showLoader(context);
      var resend =
          await client.resendVerificationLink({email: emailController.text});
      if (resend.success) {
        showToast(resend.result['message'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      } else {
        setState(() {
          showResend = true;
        });
        showToast(resend.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      LoadingOverlay.hideLoader(context);
    } catch (e) {
      print("ERROR " + e.toString());
      LoadingOverlay.hideLoader(context);
      setState(() {
        showResend = true;
      });
    }
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }
}
