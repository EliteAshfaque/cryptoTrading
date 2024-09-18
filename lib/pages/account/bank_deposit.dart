import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cryptox/api/bank/adminBanks/adminBanks.dart';
import 'package:cryptox/api/upload/fileUpload.dart';
import 'package:cryptox/api/wallet/userWallet/userWallets.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import '../../api/bank/bankList/bankList.dart';
import '../../api/bank/userBank/userBank.dart';
import '../../api/generare_unique/generate_unique_code_struct.dart';
import '../../api/request/createRequest/createRequest.dart';
import '../../api/uniqueCode/unique_code.dart';
import '../../indX/utils/Utility.dart';
import '../../util/upperCaseTextFormatters.dart';
import '../../widget/CustomText.dart';
import '../../widget/count_timmer.dart';
import '../cdm_terms_condition.dart';

class CashDepositPage extends StatefulWidget {
  const CashDepositPage({Key? key}) : super(key: key);

  @override
  _CashDepositPageState createState() => _CashDepositPageState();
}

class _CashDepositPageState extends State<CashDepositPage> {
  final bankController = TextEditingController();
  final amountController = TextEditingController();
  final atmController = TextEditingController();
  final transactionController = TextEditingController();
  final uniqueCodeController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<AdminBanksStruct> banks = [];
  Timer? _timer;
  Duration countdownDuration = Duration(hours: 24);

  Wallet? inrWallet;
  List<String> paymentTypes = ["CDW", "CDM"];
  final GlobalKey<FormState> _requestFormKey = GlobalKey<FormState>();
  String paymentTypesVal = "CDM";
  String docId = "";
  bool isLoading = true;
  bool isBankSelected = false;
  bool docUploaded = false;
  String? docUrl = '';
  bool isChecked = false;
  int totalCount = 1;
  String page = "1";
  String remainingTime = '';
  DateTime? createdAt;
  late AdminBanksStruct selectedBank;
  late StreamSubscription adminBankSubscription;
  late StreamSubscription inrRequestSubscription;
  late StreamSubscription generateRequestSubscription;
  late StreamSubscription getCodeSubscription;
  late StreamSubscription uploadDocSubscription;
  late StreamSubscription walletSubscription;
  bool isShowCode = false;
  UniqueCode? _uniqueCode;
  String? uniqueCode;
  GenerateUniqueCodeStruct? _generateUniqueCodeStruct;
  Duration expirationDuration = Duration(hours: 24); // Default 24-hour duration

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  String calculateRemainingTime(
      DateTime createdAt, Duration expirationDuration) {
    final currentTime = DateTime.now();
    final expirationTime = createdAt.add(expirationDuration);
    return formatDuration(expirationTime.difference(currentTime));
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  void startTimer() {
    if (createdAt != null) {
      final expirationDuration = Duration(hours: 24);
      _timer?.cancel(); // Cancel any existing timer
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (createdAt != null) {
          setState(() {
            remainingTime =
                calculateRemainingTime(createdAt!, expirationDuration);
          });
        } else {
          setState(() {
            remainingTime = "Creation time not available.";
          });
          _timer?.cancel();
        }
      });
    }
  }

  void updateRemainingTime() {
    setState(() {
      remainingTime = calculateRemainingTime(createdAt!, expirationDuration);
    });
  }

  @override
  void initState() {
    adminBankSubscription = apiCalls.adminBanks$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if (value is String) {
        return;
      }
      if (value is List<AdminBanksStruct>) {
        setState(() {
          banks = value;
          isLoading = false;
        });
      }
    });
    inrRequestSubscription = apiCalls.inrRequest$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if (value is String) {
        return;
      }
      if (value is FiatRequestStruct) {
        showToast("Request Successfully Placed.",
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        Navigator.pop(context);
      }
    });
    uploadDocSubscription = apiCalls.uploadDoc$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if (value is String) {
        Navigator.pop(context);
        return;
      }
      if (value is DocumentsStruct) {
        Navigator.pop(context);
        setState(() {
          docId = value.uniqueId ?? "";
          docUploaded = true;
          docUrl = value.path;
        });
      }
    });
    generateRequestSubscription = apiCalls.generateUniquesCode$.listen((value) {
      LoadingOverlay.hideLoader(context);

      if (kDebugMode) {
        print("USER WALLET " + value.toString());
      }
      if (value is String) {
        LoadingOverlay.hideLoader(context);

        return;
      }
      if (value is GenerateUniqueCodeStruct) {
        isLoading = false;
        if (mounted)
          setState(() {
            uniqueCode = value.message;
            uniqueCodeController.text = value.message;
            apiCalls.getUniqueCode(context, paymentTypesVal);
          });
      }
    });

    getCodeSubscription = apiCalls.getUniquesCode$.listen((value) {
      LoadingOverlay.hideLoader(context);

      if (kDebugMode) {
        // Debug logic if needed
      }

      // Handle the case where `value` is an empty string
      if (value == "") {
        uniqueCode = '';
        createdAt = null;
        uniqueCodeController.clear();
        isShowCode = false;
        remainingTime = '';

        setState(() {});
        stopTimer(); // Stop the timer when value is an empty string
        return; // Exit the function
      }

      // Handle the case where `value` is a string
      if (value is String) {
        uniqueCode = '';
        createdAt = null;
        uniqueCodeController.clear();
        isShowCode = false;
        remainingTime = '';
        stopTimer();
        setState(() {}); // Stop the timer when value is a string
        return; // Exit the function
      }

      // Handle the case where `value` is a `UniqueCodeStruct`
      if (value is UniqueCodeStruct) {
        LoadingOverlay.hideLoader(context);

        if (mounted) {
          isLoading = false;

          setState(() {
            final expirationDuration = Duration(hours: 24);
            if (value.success == true && value != "") {
              _uniqueCode = UniqueCode.fromJson(value.result['message']);
              createdAt = _uniqueCode?.createdAt;
              uniqueCode = _uniqueCode?.uniqueCode ?? '';
              uniqueCodeController.text = _uniqueCode?.uniqueCode ?? '';
              isShowCode = true;
              remainingTime =
                  calculateRemainingTime(createdAt!, expirationDuration);
            } else {
              // Handle other conditions if needed
            }
          });
        }
      } else {
        setState(() {
          // Handle other cases if needed
        });
      }
    });

    apiCalls.getDepositBankAdmin(context);
    apiCalls.getUniqueCode(context, paymentTypesVal);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    adminBankSubscription.cancel();
    inrRequestSubscription.cancel();
    uploadDocSubscription.cancel();
    getCodeSubscription.cancel();
    generateRequestSubscription.cancel();
    _timer?.cancel(); // Cancel the timer when the widget is disposed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
          gradient: Com.barGradient(),
        )),
        titleSpacing: 0.0,
        title: Text(
          'Inr Deposit',
          style: white16SemiBoldTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _requestFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (banks ?? []).isNotEmpty
                    ? bankDetail(
                        '${banks.first.bankName}',
                        '${banks.first.accNumber}',
                        '${banks.first.accHolderName}',
                        '${banks.first.ifsc}')
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Theme(
                      data: ThemeData(
                        primaryColor: primaryColor,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: primaryColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " Select the Payment Type: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                          DropdownButton(
                            items: paymentTypes.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            value: paymentTypesVal,
                            onChanged: (String? newValue) {
                              setState(() {
                                paymentTypesVal = newValue!;
                                apiCalls.getUniqueCode(
                                    context, paymentTypesVal);
                              });
                            },
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        setState(() {});
                        generateCode(paymentTypesVal ?? '');
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 6.0),
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: primaryColor),
                        child: GestureDetector(
                          onTap: () async {
                            await generateCode(paymentTypesVal);
                          },
                          child: Center(
                              child: Text("Generate Code",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                        ),
                      ),
                    ),
                    Spacer(),
                    Visibility(
                      visible: isShowCode,
                      child: Container(
                        margin: EdgeInsets.only(left: 6.0),
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.black),
                        child: Center(
                            child: Text("$uniqueCode",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Visibility(
                  visible: isShowCode,
                  child: Container(
                    padding: EdgeInsets.all(5.0), // 5px padding on all sides
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: primaryColor, // Red color border
                        width: 1.0, // 2px border width
                      ),
                    ),
                    child: createdAt != null
                        ? CountdownTimer(
                            initialTime: DateTime.now().difference(createdAt!),
                            totalDuration: countdownDuration,
                          )
                        : Container(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Theme(
                  data: ThemeData(
                    primaryColor: greyColor,
                  ),
                  child: TextFormField(
                    controller: bankController,
                    keyboardType: TextInputType.number,
                    style: black16RegularTextStyle,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Fill Me";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Bank',
                      labelStyle: black16RegularTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: greyColor, width: 0.7),
                      ),
                    ),
                  ),
                ),
                // Amount Textfield End
                height20Space,
                (paymentTypesVal == 'CDM')
                    ? Theme(
                        data: ThemeData(
                          primaryColor: greyColor,
                        ),
                        child: TextFormField(
                          controller: atmController,
                          keyboardType: TextInputType.number,
                          style: black16RegularTextStyle,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter the ATM Number";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'ATM Number',
                            labelStyle: black16RegularTextStyle,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: greyColor, width: 0.7),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),

                Theme(
                  data: ThemeData(
                    primaryColor: greyColor,
                  ),
                  child: TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.text,
                    // Allows alphanumeric input
                    style: black16RegularTextStyle,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter the Deposit Amount";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Deposit Amount',
                      labelStyle: black16RegularTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: greyColor, width: 0.7),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                (paymentTypesVal == "CDM")
                    ? Theme(
                        data: ThemeData(
                          primaryColor: greyColor,
                        ),
                        child: TextFormField(
                          controller: transactionController,
                          keyboardType: TextInputType.text,
                          // Allows alphanumeric input
                          style: black16RegularTextStyle,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter the Transaction Id";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'TransactionId',
                            labelStyle: black16RegularTextStyle,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: greyColor, width: 0.7),
                            ),
                          ),
                        ),
                      )
                    : Container(),

                SizedBox(
                  height: 18,
                ),
                Theme(
                  data: ThemeData(
                    primaryColor: greyColor,
                  ),
                  child: TextFormField(
                    controller: uniqueCodeController,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    style: black16RegularTextStyle,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Fill Me";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Unique Id',
                      labelStyle: black16RegularTextStyle,
                      suffixIcon: docUploaded
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              // Ensure the Row takes only necessary space
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      docUrl = '';
                                      docUploaded = false;
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(
                                    width: 30.0), // Add spacing between icons
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Utility.INSTANCE
                                            .urlLaunch(docUrl ?? '');
                                      });
                                    },
                                    child: Icon(
                                      Icons.visibility,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              margin: EdgeInsets.only(left: 16.0),
                              width: 70,
                              decoration: BoxDecoration(color: primaryColor),
                              child: GestureDetector(
                                onTap: () {
                                  selectOptionBottomSheet(
                                      DocumentsType.transferProof);
                                },
                                child: Center(
                                  child: Text(
                                    "Upload",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: greyColor, width: 0.7),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
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
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: CDMPrivacyPolicy(),
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
                SizedBox(
                  height: 30,
                ),
                Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(5.0),
                  child: InkWell(
                    onTap: () {
                      if (!_requestFormKey.currentState!.validate()) {
                        return;
                      }
                      if (docId.isEmpty) {
                        showToast("Upload document.",
                            isSuccess: false,
                            gravity: ToastGravity.BOTTOM,
                            toast: Toast.LENGTH_LONG);
                        return;
                      }
                      if (isChecked == false) {
                        showToast("Please Accept the Terms & Condition",
                            gravity: ToastGravity.BOTTOM,
                            isSuccess: false,
                            toast: Toast.LENGTH_LONG);
                        return;
                      }

                      Object obj = (paymentTypesVal == "CDW")
                          ? {
                              "amount": "${amountController.text}",
                              "bankId": "${banks?.first?.id}",
                              "docId": "${docId}",
                              "paymentMode": "${paymentTypesVal}",
                              "utrNo": "${uniqueCode}"
                            }
                          : {
                              "amount": "${amountController.text}",
                              "bankId": "${banks?.first?.id}",
                              "docId": "${docId}",
                              "paymentMode": "${paymentTypesVal}",
                              "utrNo": "${uniqueCode}",
                              "atmNo": "${atmController.text}",
                              "txnNo": "${transactionController.text}",
                            };

                      LoadingOverlay.showLoader(context);
                      apiCalls.submitInrRequest(obj, context);
                    },
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      padding: EdgeInsets.all(fixPadding * 0.7),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: primaryColor,
                      ),
                      child: Text(
                        'Submit'.toUpperCase(),
                        style: white16MediumTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bankDetail(String? bankName, String? accountName, String? accountNumber,
      String ifsc) {
    return Container(
      padding: EdgeInsets.all(5.0), // 5px padding on all sides
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: primaryColor, // Red color border
          width: 1.0, // 2px border width
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            CustomText(
              text: 'Bank Name: $bankName',
              fontColor: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: primaryColor, // Red color border
              thickness: 1, // Thickness of the line
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
              text: 'Account Number: $accountName',
              fontColor: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: primaryColor, // Red color border
              thickness: 1, // Thickness of the line
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
              text: 'Name: $accountNumber',
              fontColor: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: primaryColor, // Red color border
              thickness: 1, // Thickness of the line
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
              text: 'ifsc: $ifsc',
              fontColor: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future uploadFile(File file, DocumentsType type) async {
    try {
      if (kDebugMode) {
        print(file.uri.toString());
      }
      List<int> fileInByte = file.readAsBytesSync();
      String fileInBase64 = base64Encode(fileInByte);
      if (kDebugMode) {
        print(fileInBase64.toString());
      }
      Map<String, dynamic> map = new Map();
      // Object obj = {
      map['image'] = file;
      map['data'] = fileInBase64.toString();
      map['type'] = type.name;
      // };
      LoadingOverlay.showLoader(context);
      apiCalls.uploadUserDocs(map, context);
    } catch (e) {
      print("IMAGE NOT UPLOADED");
    }
  }

  Future generateCode(String paymentType) async {
    try {
      if (kDebugMode) {
        print(paymentType);
      }
      Object obj = {"paymentMode": paymentTypesVal};

      LoadingOverlay.showLoader(context);
      apiCalls.generateUniqueCode(context, obj);
    } catch (e) {
      print("IMAGE NOT UPLOADED");
    }
  }

  selectOptionBottomSheet(DocumentsType type) {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: whiteColor,
            child: Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    padding: EdgeInsets.all(fixPadding),
                    child: Column(
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
                                  style: black14MediumTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
