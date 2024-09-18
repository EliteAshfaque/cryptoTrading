import 'dart:convert';

import 'package:cryptox/constant/api.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/auth/googleMobileReffralUpdate.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:cryptox/util/loader.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cryptox/pages/auth/login.dart' as LoginComponent;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/base.dart';
import '../../api/signUp/signUp.dart';
import '../../util/ToastUtil.dart';
import '../../widget/common.dart';
import '../profile/privacy_policy_web.dart';
import 'email_otp.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final commonWidget = Com();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController referralController = new TextEditingController();
  bool isChecked = false;
  bool emailVerifyDisableObs = false;
  bool passObs = true;
  bool nameObs = false;
  bool phoneObs = false;
  bool referralObs = false;
  String mobileToken = "";
  String countryCode = "";



  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((token) {
      if (kDebugMode) {
        print("DEVICE TOKEN " + token.toString());
      }
      setValueForKey(mobileTokenKey, token.toString());
      setState(() {
        mobileToken = token.toString();
      });
    });
    // getUserMobileToken().then((value) {
    //   print("TOKEN VALUE ON REGISTER PAGE "+value.toString());
    //   if(value != KeyNotFound) {
    //     setState(() {
    //       mobileToken = value;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
                bottom: 0,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child:
                        Image.asset('assets/Images/authBottomRightCut.png'))),
            ListView(
              children: [
                height20Space,
                Text('SignUp',
                    style: black28w500TextStyle, textAlign: TextAlign.center),
                height20Space,
                Form(
                    key: _registerFormKey,
                    child: Column(
                      children: [
                        commonWidget.inputBoxDesign(
                            Icons.person,
                            nameController,
                            "Name",
                            nameValidator,
                            nameObs,
                            false,
                            () => {},
                            TextInputType.name,
                            (val) => {},
                            20.0,
                            20.0),
                        height20Space,
                        commonWidget.inputBoxDesignWithSuffixBTn(
                            Icons.email_outlined,
                            emailController,
                            "Email",
                            emailValidator,
                            emailVerifyDisableObs,
                            () => {
                                  if (emailValidator(emailController.text) ==
                                      "Verify your email id.")
                                    {sendEmailOtp()}
                                },
                            TextInputType.emailAddress,
                            (val) => {},
                            20.0,
                            20.0),
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
                        height20Space,
                        commonWidget.countrySelection(20.0, 20.0,
                            phoneController, _getCountryCode, phoneValidator),
                        height20Space,
                        commonWidget.inputBoxDesign(
                            Icons.person_add_alt_1,
                            referralController,
                            "Referral (Optional)",
                            referralValidator,
                            referralObs,
                            false,
                            () => {},
                            TextInputType.text,
                            (val) => {},
                            20.0,
                            20.0),
                      ],
                    )),
                height20Space,
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.all(primaryColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                      ),
                      Text("I've read & agreed with",
                          style: TextStyle(fontSize: 13)),
                      SizedBox(
                        width: 8.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // await launchUrl(Uri.parse(privacyPolicyUrl));
                          // await canLaunchUrl(Uri.parse(url)) ? launchUrl(Uri.parse(url)) :
                          //   showToast("Can't launch url.",gravity: ToastGravity.BOTTOM,
                          //       toast: Toast.LENGTH_LONG);
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: PrivacyPolicyWeb(),
                            ),
                          );
                        },
                        child: Text("Terms Of Service >>",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 10)),
                      )
                    ],
                  ),
                ),
                height20Space,
                InkWell(
                  onTap: () {
                    if (_registerFormKey.currentState!.validate() &&
                        countryCode.isNotEmpty) {
                      registerUser();
                    }
                  },
                  child: UnconstrainedBox(
                    child: Container(
                      width: 150,
                      height: 50.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: primaryColor,
                      ),
                      child: Text(
                        'REGISTER',
                        style: white14BoldTextStyle,
                      ),
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
                //     registerWithGoogle();
                //   },
                //   child: UnconstrainedBox(
                //     child: Container(
                //       width: 235,
                //       height: 50.0,
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(30.0),
                //         color: Colors.white,
                //       ),
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           SvgPicture.asset("assets/svg/google_g.svg",
                //               width: 20),
                //           widthSpace,
                //           Text(
                //             'Register With Google',
                //             style: black14BoldTextStyle,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                height20Space,
                Center(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginComponent.Login()));
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF757575),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat'),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Login",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Montserrat')),
                            ],
                          ),
                        ))),
                height20Space,
                /*Center(child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => LoginComponent.Login()));
                    },
                    child: Text("Login",style: grey14BoldTextStyle))),*/
              ],
            ),
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
      ),
    );
  }

  void registerWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
        clientId:
            "244599114225-99fgrnostmpkmq1jb01vkoa6krvcbfcs.apps.googleusercontent.com",
        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/userinfo.email'
        ]);

    GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
    if (_googleUser != null) {
      String? _googleUserEmail = _googleUser.email;
      String? _googleUserName = _googleUser.displayName;
      _googleSignIn.signOut();
      if (_googleUserEmail != null && _googleUserEmail.isNotEmpty) {
        googleAuthUser(_googleUserEmail, _googleUserName ?? "");
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

  registerUser() async {
    if (mobileToken.isEmpty) {
      showToast("Mobile Token not found.",
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return;
    }
    if (!isChecked) {
      showToast("Mark T&C check box.",
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return;
    }
    final dio = Dio();
    final client = RestClient(dio);
    try {
      LoadingOverlay.showLoader(context);
      var signUp = await client.signUpUser({
        "email": emailController.text,
        "password": passController.text,
        "phone": phoneController.text,
        "name": nameController.text,
        "mobileToken": mobileToken,
        "countryCode": countryCode,
        "referral": referralController.text,
        'domain': 'App'
      });
      if (kDebugMode) {
        print(jsonEncode(signUp));
      }
      if (signUp.success) {
        // SignUpResult res = SignUpResult.fromJson(signUp.result['message']);
        showToast("Successfully Signup.",
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginComponent.Login()));
      } else {
        showToast(signUp.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      LoadingOverlay.hideLoader(context);
    } catch (e) {
      print("ERROR " + e.toString());
      LoadingOverlay.hideLoader(context);
    }
  }

  googleAuthUser(String email, String name) async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      LoadingOverlay.showLoader(context);
      var signUp = await client.googleAuthUser({
        "email": email,
        "name": name,
        "email_verified": true,
        'domain': 'App'
      });
      if (kDebugMode) {
        print(jsonEncode(signUp));
      }
      if (signUp.success) {
        SignUpResult res = SignUpResult.fromJson(signUp.result['message']);
        updateGoogleDetailsView(res.id ?? "", res.email ?? "");
      } else {
        showToast(signUp.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        if (signUp.result['error']
            .toString()
            .toLowerCase()
            .contains("please login")) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginComponent.Login()));
        }
      }
      LoadingOverlay.hideLoader(context);
    } catch (e) {
      print("ERROR " + e.toString());
      LoadingOverlay.hideLoader(context);
    }
  }

  sendEmailOtp() async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      LoadingOverlay.showLoader(context);
      var signUp =
          await client.sendEmailVerifyOtp({"email": emailController.text});
      if (kDebugMode) {
        print(jsonEncode(signUp));
      }
      if (signUp.success) {
        otpView();
        showToast(signUp.result['message'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      } else {
        showToast(signUp.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      LoadingOverlay.hideLoader(context);
    } catch (e) {
      print("ERROR " + e.toString());
      LoadingOverlay.hideLoader(context);
    }
  }

  otpView() {
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
                child: EmailOTP(
                    email: emailController.text,
                    verify: () {
                      setState(() {
                        emailVerifyDisableObs = true;
                      });
                    }),
              ),
            ],
          ),
        );
      },
    );
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

  nameValidator(String val) {
    if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(val)) {
      return "Name should not be alpha numeric.";
    }
    return null;
  }

  emailValidator(String val) {
    if (!RegExp('[A-Za-z0-9._%-]+@[A-Za-z._%-]+\.[a-z]+').hasMatch(val)) {
      return "Invalid email format";
    } else if (!emailVerifyDisableObs) {
      return 'Verify your email id.';
    }
    return null;
  }

  passValidator(String val) {
    if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,}$')
        .hasMatch(val)) {
      return 'Ex- ZK3JjQR:V,&6VH&OZ&2r&D';
      // return "Password should be in between 6 and 32\ncharacters long Use only Roman letters,\n"
      //     "digits, and these characters:\n~-+=_^#@\$(){}.,:!";
    }
    return null;
  }

  phoneValidator(String val) {
    if ((int.tryParse(val) ?? 0) == 0) {
      return 'Enter valid phone number';
    }
    return null;
  }

  referralValidator(String val) {
    return null;
  }

  otpValidator(String val) {
    if (val.length != 6) {
      return 'Otp length should be 6.';
    }
    return null;
  }

  _toggle() {
    setState(() {
      passObs = !passObs;
    });
  }

  _getCountryCode(String code) {
    setState(() {
      countryCode = code;
    });
  }
}
