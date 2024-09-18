import 'dart:convert';

import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cryptox/pages/auth/login.dart' as LoginComponent;

import '../../api/base.dart';

class GoogleMobileReffralUpdate extends StatefulWidget {
  String id;
  String email;
  GoogleMobileReffralUpdate({Key? key,required this.id,required this.email}) : super(key: key);

  @override
  _GoogleMobileReffralUpdate createState() => _GoogleMobileReffralUpdate();
}

class _GoogleMobileReffralUpdate extends State<GoogleMobileReffralUpdate> {

  TextEditingController phoneController = new TextEditingController();
  TextEditingController referralController = new TextEditingController();
  String countryCode = "";
  bool referralObs = false;
  final commonWidget = Com();
  final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();
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
        Text('Please Fill Details',
          style: black16BoldTextStyle,
          textAlign: TextAlign.center,
        ),
        height20Space,
        Form(
        key: _updateFormKey,
        child: Column(
          children: [
            commonWidget.countrySelection(0,0,phoneController,_getCountryCode, phoneValidator),
            height20Space,
            commonWidget.inputBoxReffralDesign(Icons.person_add_alt_1, referralController, "Referral (Optional)",
                referralValidator, referralObs, true, () => {}, TextInputType.text,
                    (String val) => {if(val.length>=6){
                  reffralValidate(val)
                }},0,0),
          ],
        )),

        height20Space,
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
                if (_updateFormKey.currentState!.validate() && countryCode.isNotEmpty) {
                  updateDetails();
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


  referralValidator(String val) {

    return null;
  }
  phoneValidator(String val) {
    if(val==null || val.isEmpty){
      return "Enter your Phone Number.";
    }else if((int.tryParse(val)??0)==0) {
      return 'Enter valid phone number';
    }
    return null;
  }
  _getCountryCode(String code) {
    setState(() {
      countryCode = code;
    });
  }
  /*_toggle() {
    setState(() {
      passObs = !passObs;
    });
  }*/
  reffralValidate(String refrral) async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      LoadingOverlay.showLoader(context);
      var signUp = await client.getUserByReferral(refrral);
      if (kDebugMode) {print(jsonEncode(signUp));}
      if (signUp.success) {
        setState(() {
          referralObs=true;
        });

      }else {
        showToast(signUp.result['error'],gravity: ToastGravity.BOTTOM,toast: Toast.LENGTH_LONG);
        setState(() {
          referralObs=false;
        });
      }
      LoadingOverlay.hideLoader(context);
    } catch (e) {
      print("ERROR " + e.toString());
      LoadingOverlay.hideLoader(context);
    }
  }

  updateDetails() async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      LoadingOverlay.showLoader(context);
      /*"id": widget.id,*/
      var signUp = await client.updateUserDetails({"email": widget.email, "phone": phoneController.text, "referral": referralController.text, "countryCode": countryCode });
      if (kDebugMode) {print(jsonEncode(signUp));}
      if (signUp.success) {
        showToast(signUp.result['message'],gravity: ToastGravity.BOTTOM,toast: Toast.LENGTH_LONG);
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginComponent.Login()));
      }else {
        showToast(signUp.result['error'],gravity: ToastGravity.BOTTOM,toast: Toast.LENGTH_LONG);
      }
      LoadingOverlay.hideLoader(context);
    } catch (e) {
      print("ERROR " + e.toString());
      LoadingOverlay.hideLoader(context);
    }
  }
}
