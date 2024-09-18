import 'dart:async';
import 'dart:io';

import 'package:cryptox/api/user/getUser/getUser.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/api.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/indX/routes/AppRoutes.dart';
import 'package:cryptox/pages/profile/activitylogs.dart';
import 'package:cryptox/pages/profile/changePassword.dart';
import 'package:cryptox/pages/profile/privacy_policy_web.dart';
import 'package:cryptox/pages/profile/referral.dart';
import 'package:cryptox/pages/profile/support.dart';
import 'package:cryptox/pages/profile/twoFactorAuth.dart';
import 'package:cryptox/pages/screens.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/util/models.dart';
import 'package:cryptox/util/openOtherApp.dart';
import 'package:cryptox/util/upperCaseExtension.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../api/user/userAdditionalDetails/userAdditionalDetails.dart';
import 'about_us.dart';
import 'kyc.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String userPhone = "";
  bool deleteApproval = false;
  bool userVerified = false;
  bool otpObs = false;
  TextEditingController otpController = new TextEditingController();
  late StreamSubscription deleteSubscription;

  @override
  void initState() {
    super.initState();
    getUserName().then((value) {
      setState(() {
        name = value;
      });
    });
    getValueForKey(phone).then((value) {
      setState(() {
        userPhone = value;
      });
    });
    getValueForKeyBool(isDeleteApproval).then((value) {
      setState(() {
        deleteApproval = value;
        print('The delte approval is ===>>> ${deleteApproval}');
      });
    });
    getValueForKeyBool(isUserVerified).then((value) {
      setState(() {
        userVerified = value;
      });
    });
    deleteSubscription = apiCalls.deleteUser$.listen((value) {
      if (value is String && value != "") {
        cleanSharedPrefs();
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', (Route<dynamic> route) => false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    deleteSubscription.cancel();
  }

  logoutDialog(LogDelFilter filter) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        double width = MediaQuery.of(context).size.width;
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You sure want to ${filter.text}?',
                      style: black16BoldTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    heightSpace,
                    heightSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        InkWell(
                          onTap: () async {
                            switch (filter.type) {
                              case "logout":
                                {
                                  cleanSharedPrefs().then((value) {
                                    if (value) {
                                      Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: BottomBar()));
                                    } else {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/login',
                                          (Route<dynamic> route) => false);
                                    }
                                  });
                                  break;
                                }
                              case "logout all":
                                {
                                  LoadingOverlay.showLoader(context);
                                  String res = await apiCalls
                                      .logOutAllUserDevices(context);
                                  LoadingOverlay.hideLoader(context);
                                  Navigator.pop(context);
                                  if (res.isNotEmpty) {
                                    cleanSharedPrefs().then((value) {
                                      if (value) {
                                        Navigator.pushReplacement(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: BottomBar()));
                                      } else {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/login',
                                            (Route<dynamic> route) => false);
                                      }
                                    });
                                  }
                                  break;
                                }
                              case "delete":
                                {
                                  apiCalls.deleteUser(context);
                                  Navigator.pop(context);
                                  break;
                                }
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
                              filter.text.toTitleCase(),
                              style: white14MediumTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  isDeleteConfDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Request for account deletion is already pending.',
                      style: black16BoldTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    heightSpace,
                    heightSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            Navigator.pop(context);
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
                              "Cancel",
                              style: white14MediumTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  verifyUserStatusView() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Enter otp that was just sent on your email.',
                      style: black16BoldTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    heightSpace,
                    heightSpace,
                    Com().inputBoxDesign(
                        Icons.verified_user_outlined,
                        otpController,
                        "Otp",
                        otpValidator,
                        otpObs,
                        false,
                        _toggle,
                        TextInputType.number,
                        (val) => {},
                        20.0,
                        20.0),
                    heightSpace,
                    height5Space,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        InkWell(
                          onTap: () async {
                            if (otpController.text.isEmpty) {
                              showToast("Otp is empty.",
                                  gravity: ToastGravity.BOTTOM,
                                  toast: Toast.LENGTH_LONG);
                              return;
                            }
                            LoadingOverlay.showLoader(context);
                            IUserStruct? res = await apiCalls
                                .verifyVerificationOtp(context,
                                    {"otp": otpController.text.toString()});
                            LoadingOverlay.hideLoader(context);
                            if (res == null) {
                              return;
                            }
                            setValueForBoolKey(isUserVerified, true);
                            setState(() {
                              userVerified = res.active!;
                            });
                            Navigator.pop(context);
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
                              "Submit",
                              style: white14MediumTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  changePasswordStatusView() {
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
                child: ChangePassword(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            aboutUser(),
            if (!userVerified) verificationAlert(),
            GridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisCount: 3,
              physics: NeverScrollableScrollPhysics(),
              children: [
                // aboutUser(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: EditProfile(),
                      ),
                    );
                  },
                  child: profileItem(
                      Icons.perm_identity, 'Edit Profile', 'Edit your profile'),
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       PageTransition(
                //         type: PageTransitionType.rightToLeft,
                //         child: Kyc(),
                //       ),
                //     );
                //   },
                //   child: profileItem(
                //       Icons.account_box_sharp, 'Kyc', 'Verify your self.'),
                // ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: TwoFactorAuth(),
                      ),
                    );
                  },
                  child: profileItem(
                      Icons.security_rounded, '2FA', 'Add extra security.'),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: ActivityLogs(),
                      ),
                    );
                  },
                  child: profileItem(
                      Icons.list, 'Activity Logs', 'Check auth activity here.'),
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       PageTransition(
                //         type: PageTransitionType.rightToLeft,
                //         child: Support(),
                //       ),
                //     );
                //   },
                //   child: profileItem(Icons.headphones, 'Help & Support',
                //       'Create a ticket and we will contact you'),
                // ),
                InkWell(
                  onTap: () async {
                    //await launchUrl(Uri.parse(privacyPolicyUrl));
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: PrivacyPolicyWeb(),
                      ),
                    );
                  },
                  child: profileItem(Icons.policy, 'Privacy Policy',
                      'How we work & use your data'),
                ),
                // InkWell(
                //   onTap: () async {
                //     Navigator.push(
                //       context,
                //       PageTransition(
                //         type: PageTransitionType.rightToLeft,
                //         child: Referral(),
                //       ),
                //     );
                //   },
                //   child: profileItem(
                //       Icons.add, 'Referrals', 'Refer your friends.'),
                // ),
                // InkWell(
                //   onTap: () async {
                //     var list = await OpenOtherApp.createList(context);
                //     if (list.isEmpty) {
                //       return;
                //     }
                //     Get.toNamed(AppRoutes.splash, arguments: list);
                //     /*String url = await OpenOtherApp.createUrl(context);
                //     if(url.isEmpty) {
                //       return;
                //     }
                //     try {
                //       await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                //     }catch(e) {
                //       if(e.toString().contains("ACTIVITY_NOT_FOUND")) {
                //         await launchUrl(Uri.parse(externalAppUrl),
                //             mode: LaunchMode.externalNonBrowserApplication);
                //       }else {
                //         showToast("Failed to open external app",
                //             gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
                //       }
                //     }*/
                //   },
                //   child: profileItem(
                //       Icons.ac_unit_outlined, '1FXD', 'Explore More.'),
                // ),
                InkWell(
                  onTap: () async {
                    final InAppReview inAppReview = InAppReview.instance;
                    if (await inAppReview.isAvailable()) {
                      // await inAppReview.requestReview();
                      if (Platform.isIOS) {
                        inAppReview.openStoreListing(appStoreId: "");
                      }
                      if (Platform.isAndroid) {
                        inAppReview.openStoreListing();
                      }
                    }
                  },
                  child: profileItem(Icons.star_half_sharp, 'Rate Us',
                      'Tell us what you think'),
                ),
                InkWell(
                  onTap: () async {
                    // await launchUrl(Uri.parse(aboutUsUrl));
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: AboutUs(),
                      ),
                    );
                  },
                  child: profileItem(Icons.info_outline, 'About Us', 'v1.15'),
                ),

                InkWell(
                  onTap: () {
                    changePasswordStatusView();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(fixPadding * 1.5,
                        fixPadding * 1.5, fixPadding * 1.5, fixPadding * 1.5),
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          color: blackColor.withOpacity(0.05),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.password,
                          size: 28.0,
                          color: primaryColor2,
                        ),
                        heightSpace,
                        Text(
                          'Change Password',
                          style: black14MediumTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => logoutDialog(
                      LogDelFilter(text: 'Logout', type: "logout")),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(fixPadding * 1.5,
                        fixPadding * 1.5, fixPadding * 1.5, fixPadding * 1.5),
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          color: blackColor.withOpacity(0.05),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout_sharp,
                          size: 28.0,
                          color: primaryColor2,
                        ),
                        heightSpace,
                        Text(
                          'Logout',
                          style: black14MediumTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () => logoutDialog(LogDelFilter(
                      text: 'logout all devices', type: "logout all")),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(fixPadding * 1.5,
                        fixPadding * 1.5, fixPadding * 1.5, fixPadding * 1.5),
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          color: blackColor.withOpacity(0.05),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout_sharp,
                          size: 28.0,
                          color: primaryColor2,
                        ),
                        heightSpace,
                        Text(
                          'Logout All Devices',
                          style: black14MediumTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    deleteApproval
                        ? isDeleteConfDialog()
                        : logoutDialog(
                            LogDelFilter(text: 'Delete', type: "delete"));
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(fixPadding * 1.5,
                        fixPadding * 1.5, fixPadding * 1.5, fixPadding * 1.5),
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          color: blackColor.withOpacity(0.05),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          size: 28.0,
                          color: primaryColor2,
                        ),
                        heightSpace,
                        Text(
                          'Delete Account',
                          style: black14MediumTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  aboutUser() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100.0,
            width: 100.0,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset(
                    'assets/Images/coinExcha.png',
                    height: 100.0,
                    width: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: greenColor,
                      border: Border.all(
                        width: 2.0,
                        color: whiteColor,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 25.0,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          heightSpace,
          Text(
            'Verified',
            style: grey14MediumTextStyle,
          ),
          heightSpace,
          Text(
            name,
            style: black18SemiBoldTextStyle,
          ),
          height5Space,
          Text(
            userPhone,
            style: grey16MediumTextStyle,
          ),
        ],
      ),
    );
  }

  Widget verificationAlert() {
    // return Container(
    //   height: 55,
    //   width: double.infinity,
    //   padding: EdgeInsets.fromLTRB(fixPadding, fixPadding,
    //       fixPadding, fixPadding),
    //   margin: EdgeInsets.all(8.0),
    //   decoration: BoxDecoration(
    //     color: primaryColor,
    //     borderRadius: BorderRadius.circular(10.0),
    //     boxShadow: [
    //       BoxShadow(
    //         blurRadius: 4.0,
    //         spreadRadius: 1.0,
    //         color: blackColor.withOpacity(0.05),
    //       ),
    //     ],
    //   ),
    //   child: Row(
    //     children: [
    //       Expanded(child: Text("Please verify your email before trading.",style: white14MediumTextStyle)),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
    //         child: Material(
    //           elevation: 2.0,
    //           borderRadius: BorderRadius.circular(5.0),
    //           child: InkWell(
    //             onTap: () async {
    //               LoadingOverlay.showLoader(context);
    //               String res = await apiCalls.sendVerificationOtp(context);
    //               LoadingOverlay.hideLoader(context);
    //               if(res.isNotEmpty) {
    //                 verifyUserStatusView();
    //               }
    //             },
    //             borderRadius: BorderRadius.circular(5.0),
    //             child: Container(
    //               width: 80,
    //               padding: EdgeInsets.all(fixPadding * 0.2),
    //               alignment: Alignment.center,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(5.0),
    //                 color: greenColor,
    //               ),
    //               child: Text(
    //                 'Verify',
    //                 style: white14MediumTextStyle,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Container();
  }

  profileItem(icon, title, subtitle) {
    return Container(
      padding:
          EdgeInsets.fromLTRB(fixPadding, fixPadding, fixPadding, fixPadding),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            spreadRadius: 1.0,
            color: blackColor.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30.0,
            color: primaryColor2,
          ),
          heightSpace,
          Text(
            title,
            style: black14MediumTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  divider() {
    return Container(
      width: double.infinity,
      height: 0.7,
      color: greyColor.withOpacity(0.15),
    );
  }

  otpValidator(String val) {
    if (val.length != 6) {
      return 'Otp length should be 6.';
    }
    return null;
  }

  _toggle() {
    setState(() {
      otpObs = !otpObs;
    });
  }
}
