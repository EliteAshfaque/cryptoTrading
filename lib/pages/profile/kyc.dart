import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cryptox/api/kyc/kycId/kycId.dart';
import 'package:cryptox/api/upload/fileUpload.dart';
import 'package:cryptox/api/user/userAdditionalDetails/userAdditionalDetails.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/profile/bank_details.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Kyc extends StatefulWidget {
  @override
  _Kyc createState() => _Kyc();
}

class _Kyc extends State<Kyc> {
  final commonWidget = Com();
  KycStruct? userKyc;
  TextEditingController panController = new TextEditingController();
  TextEditingController aadhaarController = new TextEditingController();
  final GlobalKey<FormState> _kycDetailFormKey = GlobalKey<FormState>();
  late StreamSubscription uploadDocSubscription;
  late StreamSubscription kycIdSubscription;
  StreamSubscription? userDetailsSubscription;
  final ImagePicker _picker = ImagePicker();
  Map<String, String> kycForm = {
    "panDocId": "",
    "aadhaarFrontDocId": "",
    "aadhaarBackDocId": "",
    "userDocId": "",
    "kycId": "",
    "aadhaarNumber": "",
    "panNumber": ""
  };
  String currentKycStatus = "";
  bool panObs = false;
  bool aadhaarObs = false;
  bool showPan = true;
  bool showAadhaarFront = true;
  bool showAadhaarBack = true;
  bool showUserImg = true;
  bool panUploaded = false;
  bool aadhaarFrontUploaded = false;
  bool aadhaarBackUploaded = false;
  bool userImageUploaded = false;
  bool showKycForm = true;
  bool userDetailsFound = false;
  String aadhaarFrontImageName = "";
  String aadhaarBackImageName = "";
  String panImageName = "";
  String userImageName = "";

  @override
  void initState() {
    super.initState();
    kycIdSubscription = apiCalls.kycId$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if (value is String) {
        return;
      }
      if (value is KycStruct) {
        if (value.uniqueId != null && value.uniqueId!.isNotEmpty) {
          setState(() {
            userKyc = value;
            panController.text = value.panNumber ?? "";
            aadhaarController.text = value.aadhaarNumber ?? "";
            currentKycStatus = value.status!;
            if (currentKycStatus == KycStatus.PENDING.name ||
                currentKycStatus == KycStatus.VERIFIED.name) {
              showKycForm = false;
            }
          });
          if (value.status == KycStatus.REJECTED.name) {
            kycForm['aadhaarNumber'] = value.aadhaarNumber ?? "";
            kycForm['panNumber'] = value.panNumber ?? "";
            if (value.docsArr!.length > 0) {
              value.docsArr!.forEach((element) {
                switch (element.docType) {
                  case "aadhaarBack":
                    {
                      setState(() {
                        showAadhaarBack = element.status!;
                        if (!element.status!) {
                          kycForm["aadhaarBackDocId"] =
                              value.aadhaarBackDocId ?? "";
                        }
                      });
                      break;
                    }

                  case "aadhaarFront":
                    {
                      setState(() {
                        showAadhaarFront = element.status!;
                        if (!element.status!) {
                          kycForm["aadhaarFrontDocId"] =
                              value.aadhaarBackDocId ?? "";
                        }
                      });
                      break;
                    }

                  case "pan":
                    {
                      setState(() {
                        showPan = element.status!;
                        if (!element.status!) {
                          kycForm["panDocId"] = value.panDocId ?? "";
                        }
                      });
                      break;
                    }

                  case "userImage":
                    {
                      setState(() {
                        showUserImg = element.status!;
                        if (!element.status!) {
                          kycForm["userDocId"] = value.userDocId ?? "";
                        }
                      });
                      break;
                    }
                }
              });
            }
          }
        }
        setState(() {
          kycForm['kycId'] = value.userImgId!;
        });
      }
    });
    uploadDocSubscription = apiCalls.uploadDoc$.listen((value) {
      LoadingOverlay.hideLoader(context);
      Navigator.pop(context);
      if (value is String) {
        return;
      }
      if (value is DocumentsStruct) {
        switch (value.type) {
          case "aadhaarBack":
            {
              setState(() {
                aadhaarBackImageName = value.path ?? "";
                aadhaarBackUploaded = true;
                kycForm["aadhaarBackDocId"] = value.uniqueId ?? "";
              });
              break;
            }

          case "aadhaarFront":
            {
              setState(() {
                aadhaarFrontImageName = value.path ?? "";
                aadhaarFrontUploaded = true;
                kycForm["aadhaarFrontDocId"] = value.uniqueId ?? "";
              });
              break;
            }

          case "pan":
            {
              setState(() {
                panImageName = value.path ?? "";
                panUploaded = true;
                kycForm["panDocId"] = value.uniqueId ?? "";
              });
              break;
            }

          case "userImage":
            {
              setState(() {
                userImageName = value.path ?? "";
                userImageUploaded = true;
                kycForm["userDocId"] = value.uniqueId ?? "";
              });
              break;
            }
        }
      }
    });
    userDetailsSubscription = apiCalls.userDetails$.listen((value) {
      if (value is String) {
        return;
      }
      if (value is UserDetailsStruct) {
        if (value.city!.isNotEmpty &&
            value.name!.isNotEmpty &&
            value.phone!.isNotEmpty &&
            value.state!.isNotEmpty &&
            value.postalCode!.isNotEmpty &&
            value.country!.isNotEmpty &&
            value.address!.isNotEmpty) {
          setState(() {
            userDetailsFound = true;
          });
        }
      }
    });
    apiCalls.getDetailsOfUser(context);
    apiCalls.getUserKycDetails(context);
  }

  @override
  void dispose() {
    super.dispose();
    uploadDocSubscription.cancel();
    kycIdSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
          gradient: Com.barGradient(),
        )),
        title: Text(
          'Manual KYC',
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
      bottomNavigationBar: userDetailsFound
          ? (showKycForm
              ? Container(
                  padding: EdgeInsets.only(
                      left: fixPadding * 2.0,
                      right: fixPadding * 2.0,
                      bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      if (_kycDetailFormKey.currentState!.validate()) {
                        //print("DONE ");
                        submitUserKyc();
                        // submitUserDetails();
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
                )
              : Text(""))
          : Text(""),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: !userDetailsFound
            ? Center(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('For Better Experience Fill User details'),
                  height5Space,
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/edit_profile');
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: (width - fixPadding * 12.0) / 2,
                      padding: EdgeInsets.symmetric(vertical: fixPadding),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: primaryColor,
                      ),
                      child: Text(
                        'Take me there',
                        style: white14MediumTextStyle,
                      ),
                    ),
                  ),
                ],
              ))
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (currentKycStatus == KycStatus.VERIFIED.name)
                      Center(child: Text("KYC successfully verified" + " !!!")),
                    if (currentKycStatus == KycStatus.PENDING.name)
                      Center(
                          child:
                              Text("KYC verification is in progress" + " !!!")),
                    if (currentKycStatus == KycStatus.REJECTED.name)
                      Center(
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("Rejection Reason" +
                                  ": " +
                                  (userKyc!.failedReason ?? "")))),
                    height20Space,
                    showKycForm
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (showPan)
                                    GestureDetector(
                                        onTap: () {
                                          panUploaded
                                              ? showToast("Already Uploaded.",
                                                  gravity: ToastGravity.BOTTOM,
                                                  toast: Toast.LENGTH_LONG)
                                              : selectOptionBottomSheet(
                                                  DocumentsType.pan);
                                        },
                                        child: containerOutlet(
                                            Icons.upload_file,
                                            "Pan",
                                            "Pan : Image size should be below 1mb.",
                                            panUploaded)),
                                  if (showAadhaarFront)
                                    GestureDetector(
                                      onTap: () {
                                        aadhaarFrontUploaded
                                            ? showToast("Already Uploaded.",
                                                gravity: ToastGravity.BOTTOM,
                                                toast: Toast.LENGTH_LONG)
                                            : selectOptionBottomSheet(
                                                DocumentsType.aadhaarFront);
                                      },
                                      child: containerOutlet(
                                          Icons.upload_file,
                                          "Aadhaar Front",
                                          "Aadhaar Front : Image size should be below 1mb.",
                                          aadhaarFrontUploaded),
                                    )
                                ],
                              ),
                              height20Space,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (showAadhaarBack)
                                    GestureDetector(
                                        onTap: () {
                                          aadhaarBackUploaded
                                              ? showToast("Already Uploaded.",
                                                  gravity: ToastGravity.BOTTOM,
                                                  toast: Toast.LENGTH_LONG)
                                              : selectOptionBottomSheet(
                                                  DocumentsType.aadhaarBack);
                                        },
                                        child: containerOutlet(
                                            Icons.upload_file,
                                            "Aadhaar Back",
                                            "Aadhaar Back : Image size should be below 1mb.",
                                            aadhaarBackUploaded)),
                                  if (showUserImg)
                                    GestureDetector(
                                      onTap: () {
                                        userImageUploaded
                                            ? showToast("Already Uploaded.",
                                                gravity: ToastGravity.BOTTOM,
                                                toast: Toast.LENGTH_LONG)
                                            : selectOptionBottomSheet(
                                                DocumentsType.userImage);
                                      },
                                      child: containerOutlet(
                                          Icons.upload_file,
                                          "Selfie" + " (${kycForm['kycId']})",
                                          "Take the selfie with this unique number "
                                          "written on the page along with aadhaar or photo id issued by Govt.",
                                          userImageUploaded),
                                    )
                                ],
                              ),
                              Form(
                                  key: _kycDetailFormKey,
                                  child: Column(
                                    children: [
                                      height20Space,
                                      if (showPan)
                                        commonWidget.textFieldBoxLayout(
                                            Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 16),
                                                    child: Icon(Icons.balance,
                                                        color: Colors
                                                            .grey.shade300,
                                                        size: 24)),
                                                Expanded(
                                                  child: TextFormField(
                                                    inputFormatters: [
                                                      UpperCaseTextFormatter()
                                                    ],
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    style:
                                                        black14MediumTextStyle,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    controller: panController,
                                                    validator: (val) {
                                                      if (val == null ||
                                                          val.isEmpty) {
                                                        return 'Enter your pan.';
                                                      }
                                                      return panValidator(val);
                                                    },
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 20.0),
                                                      hintText: "Pan number.",
                                                      hintStyle:
                                                          black14MediumTextStyle,
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            0.0,
                                            0.0),
                                      height20Space,
                                      if (showAadhaarBack || showAadhaarFront)
                                        commonWidget.inputBoxDesign(
                                            Icons.balance,
                                            aadhaarController,
                                            "Aadhaar number.",
                                            aadhaarValidator,
                                            aadhaarObs,
                                            false,
                                            () => {},
                                            TextInputType.number,
                                            (val) => {},
                                            0.0,
                                            0.0),
                                      height20Space,
                                    ],
                                  )),
                            ],
                          )
                        : Text("")
                  ],
                ),
              ),
      ),
    );
  }

  Widget containerOutlet(
      IconData icon, String text, String bottomText, bool uploaded) {
    return Container(
        height: 170,
        width: 160,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: primaryColor),
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              spreadRadius: 1.0,
              color: blackColor.withOpacity(0.05),
            ),
          ],
        ),
        child: Center(
          child: uploaded
              ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(
                    'assets/Images/greenTick.png',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                  height20Space,
                  Text("Successfully Uploaded.",
                      style: TextStyle(
                          color: Color(0xff959595),
                          fontWeight: FontWeight.w600,
                          fontSize: 10.0),
                      textAlign: TextAlign.center)
                ])
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 50.0, color: blackColor),
                    height5Space,
                    Text(text, textAlign: TextAlign.center),
                    height5Space,
                    Text(bottomText,
                        style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10.0),
                        textAlign: TextAlign.center)
                  ],
                ),
        ));
  }

  panValidator(String val) {
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   panController.text = panController.text.toUpperCase();
    //   // nameController.selection = TextSelection(baseOffset: 0, extentOffset: nameController.text.length);
    // });
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(val)) {
      return 'Invalid pan number.';
    }
    return null;
  }

  aadhaarValidator(String val) {
    if (!RegExp(r'^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$').hasMatch(val)) {
      return 'Invalid aadhaar number.';
    }
    return null;
  }

  selectOptionBottomSheet(DocumentsType type) {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.all(fixPadding),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: whiteColor,
            ),
            height: type == DocumentsType.userImage ? 400 : 200,
            child: Wrap(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Choose Option',
                        textAlign: TextAlign.center,
                        style: black18BoldTextStyle,
                      ),
                    ),
                    heightSpace,
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: fixPadding),
                      width: width,
                      height: 1.0,
                      color: greyColor.withOpacity(0.5),
                    ),
                    InkWell(
                      onTap: () async {
                        final XFile? image =
                            await _picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          var li = image.path.split("/");
                          print(li[li.length - 1]);
                          await uploadFile(File(image.path), type);
                        }
                      },
                      child: Container(
                        width: width,
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.camera_alt,
                              color: Colors.black.withOpacity(0.7),
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text('Camera', style: black14BoldTextStyle),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          var li = image.path.split("/");
                          print(li[li.length - 1]);
                          await uploadFile(File(image.path), type);
                        }
                      },
                      child: Container(
                        width: width,
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.photo_album,
                              color: Colors.black.withOpacity(0.7),
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Upload from Gallery',
                              style: black14BoldTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (type == DocumentsType.userImage)
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/Images/kycPhotoId.png',
                        height: 250,
                        width: 250,
                      ))
              ],
            ),
          );
        });
  }

  Future uploadFile(File file, DocumentsType type) async {
    print("===================================================");
    try {
      print(file.uri.toString());
      List<int> fileInByte = file.readAsBytesSync();
      String fileInBase64 = base64Encode(fileInByte);
      print(fileInBase64.toString());
      Map<String, dynamic> map = new Map();
      map['image'] = file;
      map['data'] = fileInBase64.toString();
      map['type'] = type.name;
      LoadingOverlay.showLoader(context);
      apiCalls.uploadUserDocs(map, context);
    } catch (e) {
      print("IMAGE NOT UPLOADED $e");
    }
  }

  submitUserKyc() {
    bool flag = true;
    String wrongKey = "";
    kycForm['panNumber'] = panController.text;
    kycForm['aadhaarNumber'] = aadhaarController.text;
    kycForm.forEach((key, value) {
      if (value.isEmpty) {
        flag = false;
        wrongKey = key;
      }
    });
    if (!flag) {
      showToast('$wrongKey is wrong.',
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return;
    }
    LoadingOverlay.showLoader(context);
    apiCalls.submitUserKycDetails(kycForm, context);
  }
}
