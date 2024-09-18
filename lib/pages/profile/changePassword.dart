import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/bottom_bar.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {

  TextEditingController oldPassController = new TextEditingController();
  TextEditingController newPassController = new TextEditingController();
  TextEditingController confirmPassController = new TextEditingController();
  bool passObs = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('Change Password',
          style: black16BoldTextStyle,
          textAlign: TextAlign.center,
        ),
        heightSpace,
        heightSpace,
        Com().inputBoxDesign(Icons.password_outlined, oldPassController, "Old Password",
            passValidator, passObs, false, _toggle, TextInputType.text,(val) => {},
            20.0,20.0),
        heightSpace,
        Com().inputBoxDesign(Icons.password_outlined, newPassController, "New Password",
            passValidator, passObs, false, _toggle, TextInputType.text,(val) => {},
            20.0,20.0),
        heightSpace,

        Com().inputBoxDesign(Icons.password_outlined, confirmPassController, "Confirm Password",
            passValidator, passObs, false, _toggle, TextInputType.text,(val) => {},
            20.0,20.0),
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
                if(oldPassController.text.isEmpty || newPassController.text.isEmpty|| confirmPassController.text.isEmpty) {
                  showToast("Check Passwords fields.",
                      gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
                  return;
                }
                if(oldPassController.text == newPassController.text) {
                  showToast("New Password and Old Password can't be same.",
                      gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
                  return;
                }
                if (newPassController.text != confirmPassController.text) {
                  showToast("New Password and Confirm Password do not match.",
                      gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
                  return;
                }                LoadingOverlay.showLoader(context);

                if(newPassController.text == confirmPassController.text){
                String res = await apiCalls.changeUserPassword(context,
                    {"currentPassword": oldPassController.text,
                      "newPassword": newPassController.text});
                LoadingOverlay.hideLoader(context);
                if(res.isEmpty) {
                  return;
                }}
                Navigator.pop(context);
                cleanSharedPrefs().then((value) {
                  if(value) {
                    Navigator.pushReplacement(context,
                        PageTransition(type: PageTransitionType.fade, child: BottomBar()));
                  }else {
                    Navigator.pushNamedAndRemoveUntil(context, '/login',
                            (Route<dynamic> route) => false);
                  }
                });
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
    );
  }

  passValidator(String val) {
    if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,}$').hasMatch(val)) {
      return 'Ex- ZK3JjQR:V,&6VH&OZ&2r&D';
    }
    return null;
  }

  _toggle() {
    setState(() {
      passObs = !passObs;
    });
  }

}
