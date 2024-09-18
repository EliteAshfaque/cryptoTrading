import 'dart:async';

import 'package:cryptox/api/user/userAdditionalDetails/userAdditionalDetails.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/bottom_bar.dart';
import 'package:cryptox/pages/profile/resetMobile.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  Map<String, bool> editable = {
    "name": true,
    "email": false,
    "mobile": false,
    "address": true,
    "postCode": true,
    "city": true,
    "country": true,
    "state": true
  };
  final GlobalKey<FormState> _userDetailFormKey = GlobalKey<FormState>();
  final commonWidget = Com();
  late StreamSubscription userDetailsSubscription;
  UserDetailsStruct? userDetail;
  bool kycVerified = false;
  bool submitReq = false;
  String phoneNumVal = "";

  @override
  void initState() {
    super.initState();
    getUserDetailsFromSF().then((value) {
      // value.forEach((key, value) {
      //   print(key + " "+ value.toString());
      // });
      nameController.text = value[name]!;
      emailController.text = value[email]!;
      phoneNumVal = value[phone]!;
      phoneController.text = "${value[countryCode]!} $phoneNumVal";
    });
    userDetailsSubscription = apiCalls.userDetails$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if (value is String) {
        return;
      }
      if (value is UserDetailsStruct) {
        setState(() {
          userDetail = value;
          if (userDetail?.kycVerified ?? false) {
            kycVerified = true;
          }
          addressController.text = userDetail?.address ?? "";
          cityController.text = userDetail?.city ?? "";
          countryController.text = userDetail?.country ?? "";
          postalCodeController.text = userDetail?.postalCode ?? "";
          stateController.text = userDetail?.state ?? "";
          setValueForKey(name, userDetail?.name ?? "");
          setValueForKey(phone, userDetail?.phone ?? "");
        });
        if (submitReq) {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.leftToRight,
              child: BottomBar(index: 4),
            ),
          );
        }
      }
    });
    apiCalls.getDetailsOfUser(context);
  }

  @override
  void dispose() {
    super.dispose();
    userDetailsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        titleSpacing: 0.0,
        flexibleSpace: Container(
            decoration: BoxDecoration(
          gradient: Com.barGradient(),
        )),
        title: Text(
          'Edit Profile',
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            left: fixPadding * 2.0, right: fixPadding * 2.0, bottom: 8.0),
        child: InkWell(
          onTap: () {
            if (_userDetailFormKey.currentState!.validate()) {
              submitUserDetails();
            }
          },
          borderRadius: BorderRadius.circular(7.0),
          child: Container(
            height: 50,
            width: width,
            padding: EdgeInsets.all(fixPadding * 1.5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: primaryColor,
            ),
            child: Text(
              'Save',
              style: white14BoldTextStyle,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Form(
              key: _userDetailFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 160.0,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          width: width - fixPadding * 4.0,
                          alignment: Alignment.center,
                          child: Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70.0),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/Images/coinExcha.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  heightSpace,

                  // Name Field Start
                  Container(
                    padding:
                        EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: primaryColor,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: primaryColor,
                        ),
                      ),
                      child: TextFormField(
                        enabled: editable['name'],
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        style: black14MediumTextStyle,
                        validator: (val) {
                          return checkIfEmpty(val!);
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: black14MediumTextStyle,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide:
                                BorderSide(color: greyColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Name Field End

                  // Email Field Start
                  Container(
                    padding:
                        EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: primaryColor,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: primaryColor,
                        ),
                      ),
                      child: TextFormField(
                        enabled: editable['email'],
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: black14MediumTextStyle,
                        validator: (val) {
                          return checkIfEmpty(val!);
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: black14MediumTextStyle,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Email Field End

                  // Phone Number Field Start
                  Container(
                    padding:
                        EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: primaryColor,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: primaryColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: editable['mobile'],
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              style: black14MediumTextStyle,
                              validator: (val) {
                                return checkIfEmpty(val!);
                              },
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: black14MediumTextStyle,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(3.0),
                                      topLeft: Radius.circular(3.0)),
                                  borderSide:
                                      BorderSide(color: greyColor, width: 0.7),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              bottomSheet();
                            },
                            child: Container(
                              height: 56,
                              width: 90,
                              padding: EdgeInsets.all(fixPadding * 1.5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(7.0),
                                    topRight: Radius.circular(7.0)),
                                color: Colors.red,
                              ),
                              child: Text(
                                'Update',
                                style: white14BoldTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Address Field Start
                  Container(
                    padding:
                        EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: primaryColor,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: primaryColor,
                        ),
                      ),
                      child: TextFormField(
                        enabled: editable['address'],
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        style: black14MediumTextStyle,
                        validator: (val) {
                          return checkIfEmpty(val!);
                        },
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: black14MediumTextStyle,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // PostalCode Field Start
                  Container(
                    padding:
                        EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: primaryColor,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: primaryColor,
                        ),
                      ),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        enabled: editable['postCode'],
                        controller: postalCodeController,
                        keyboardType: TextInputType.number,
                        style: black14MediumTextStyle,
                        validator: (val) {
                          return postalValidator(val!);
                        },
                        decoration: InputDecoration(
                          labelText: 'PostalCode',
                          labelStyle: black14MediumTextStyle,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // City Field Start
                  Container(
                    padding:
                        EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: primaryColor,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: primaryColor,
                        ),
                      ),
                      child: TextFormField(
                        enabled: editable['city'],
                        controller: cityController,
                        keyboardType: TextInputType.text,
                        style: black14MediumTextStyle,
                        validator: (val) {
                          return checkIfEmpty(val!);
                        },
                        decoration: InputDecoration(
                          labelText: 'City',
                          labelStyle: black14MediumTextStyle,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // State Field Start
                  Container(
                    padding:
                        EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: primaryColor,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: primaryColor,
                        ),
                      ),
                      child: TextFormField(
                        enabled: editable['state'],
                        controller: stateController,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          return checkIfEmpty(val!);
                        },
                        style: black14MediumTextStyle,
                        decoration: InputDecoration(
                          labelText: 'State',
                          labelStyle: black14MediumTextStyle,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Country Field Start
                  Container(
                    padding:
                        EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: primaryColor,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: primaryColor,
                        ),
                      ),
                      child: TextFormField(
                        enabled: editable['country'],
                        controller: countryController,
                        keyboardType: TextInputType.text,
                        style: black14MediumTextStyle,
                        validator: (val) {
                          return checkIfEmpty(val!);
                        },
                        decoration: InputDecoration(
                          labelText: 'Country',
                          labelStyle: black14MediumTextStyle,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  checkIfEmpty(String val) {
    if (val.isEmpty) {
      return 'Fill some value';
    }
    return null;
  }

  postalValidator(String val) {
    if (val.isEmpty) {
      return 'Fill some value';
    }
    if (!RegExp(r'^[1-9][0-9]{5}$').hasMatch(val)) {
      return "Postal code is invalid.";
    }
    return null;
  }

  submitUserDetails() {
    LoadingOverlay.showLoader(context);
    Object obj = {
      "address": addressController.text,
      "city": cityController.text,
      "country": countryController.text,
      "postalCode": postalCodeController.text,
      "state": stateController.text,
      'name': nameController.text
    };
    setState(() {
      submitReq = true;
    });
    apiCalls.submitDetailsOfUser(obj, context);
  }

  void bottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(
              height: 450, child: ResetMobile(mobileNo: phoneNumVal));
        });
  }
}
