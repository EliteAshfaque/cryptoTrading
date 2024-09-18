import 'dart:async';

import 'package:cryptox/api/bank/bankList/bankList.dart';
import 'package:cryptox/api/bank/userBank/userBank.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeletons/skeletons.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key}) : super(key: key);

  @override
  _BankDetailsState createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {

  late StreamSubscription userBankSubscription;
  late StreamSubscription bankListSubscription;
  final GlobalKey<FormState> _bankDetailFormKey = GlobalKey<FormState>();
  List<UserBankStruct> userBanks = [];
  List<BankListStruct> bankList = [];
  String selectedAccountType = 'Savings';
  final accountNumberController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final bankNameController = TextEditingController();
  TextEditingController utrController = new TextEditingController();
  bool isLoading = true;
  final commonWidget = Com();

  @override
  void initState() {
    super.initState();
    userBankSubscription = apiCalls.userBank$.listen((value) {
      if (kDebugMode){print("BANK DETAILS ON PAGE "+value.toString());}
      LoadingOverlay.hideLoader(context);
      if(value is String) {
        return;
      }
      if(value is UserBankStruct) {
        accountNumberController.text = "";
        ifscCodeController.text = "";
        bankNameController.text = "";
        if(userBanks.length > 0) {
          int index = userBanks.indexWhere((element) => int.parse(element.accNumber!) ==
              int.parse(value.accNumber!));
          if(index == -1) {
            setState(() {
              userBanks.add(value);
            });
          }else {
            setState(() {
              userBanks[index] = value;
            });
          }
        }else {
          setState(() {
            userBanks.add(value);
          });
        }
      }
      if(value is List<UserBankStruct>) {
        setState(() {
          userBanks = value;
          isLoading = false;
        });
      }
    });
    bankListSubscription = apiCalls.bankList$.listen((value) {
      if (kDebugMode) { print("BANK LIST ON PAGE "+value.toString());}
      LoadingOverlay.hideLoader(context);
      if(value is String) {
        return;
      }
      if(value is List<BankListStruct>) {
        setState(() {
          bankList = value;
        });
      }
    });
    apiCalls.getBankList(context).then((value) {
      if(value) {
        apiCalls.getUserBankDetails(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    userBankSubscription.cancel();
    bankListSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0.0,
        title: Text(
          'Bank Details',
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
      body: Column(
        children: [
          // info(),
          bankDetail(),
          Expanded(child: userBank())
        ],
      ),
      bottomNavigationBar: Text(
        "Some small amount has been deposited in your bank account, verify the same by "
            "putting utr number for the verification of the bank account.",
        style: TextStyle(fontSize: 12),textAlign: TextAlign.center,
      ),
    );
  }

  info() {
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      color: greyColor.withOpacity(0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: 30.0,
            color: greenColor,
          ),
          widthSpace,
          Expanded(
            child: Text(
              'Congratulations! You have successfully added your bank account details.',
              style: black14RegularTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget userBank() {
    return isLoading ? SkeletonListView() : ListView.builder(
        shrinkWrap: true,
        itemCount: userBanks.length,
        itemBuilder: (BuildContext context, int index) {
          UserBankStruct item = userBanks[index];
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 90.0,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.accHolderName!, style: TextStyle(color: Color(0xff000000),
                                fontWeight: FontWeight.w600)),
                            Text(item.status!, style: TextStyle(color:
                            item.status! == UserBankStatus.VERIFIED.name ? Color(0xff0E8730)
                                : Color(0xffFF1300),fontWeight: FontWeight.w600))
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Acc Number: '+ item.accNumber!,style: TextStyle(color: Color(0xff959595),
                                fontWeight: FontWeight.w600, fontSize: 11.0
                            )),
                            item.status == UserBankStatus.VERIFIED.name ? Text("Utr: "+ (item.utrNo!.isEmpty
                                ? "N/A" : item.utrNo!), style: TextStyle(color: Color(0xff959595),
                                fontWeight: FontWeight.w600, fontSize: 11.0
                            )) : GestureDetector(
                              onTap: () {
                                _selectOptionBottomSheet(item.accNumber!);
                              },
                              child: Text("Verify Utr",style: TextStyle(color: primaryColor,
                                  fontWeight: FontWeight.w800, fontSize: 11.0
                              )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 14.0, right: 14.0),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                      ),
                      child: Row(
                        children: [
                          Text('Ifsc: ${item.ifsc!}',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0, color: Colors.white))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  bankDetail() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Form(
        key: _bankDetailFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field Start
            Container(
              padding: EdgeInsets.only(bottom: fixPadding * 2.0),
              child: Theme(
                data: ThemeData(
                  primaryColor: primaryColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: primaryColor,
                  ),
                ),
                child: TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                      controller: bankNameController,
                      decoration: InputDecoration(
                          labelText: 'Bank Name',
                          labelStyle: black14MediumTextStyle,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(color: greyColor, width: 0.7),
                          )
                      )
                  ),
                  suggestionsCallback: (pattern) {
                    if (kDebugMode) {print(pattern);}
                    if(pattern.isEmpty) {
                      return Iterable<BankListStruct>.empty();
                    }
                    return bankList.where((element) => element.bankName!.toLowerCase()
                        .contains(pattern.toLowerCase())).toList();
                  },
                  itemBuilder: (context,BankListStruct suggestion) {
                    return ListTile(
                      title: Text(suggestion.bankName!),
                    );
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  onSuggestionSelected: (BankListStruct suggestion) {
                    bankNameController.text = suggestion.bankName!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Select Bank.';
                    }
                    int index = bankList.indexWhere((element) => element.bankName!.toLowerCase() ==
                        value.toLowerCase());
                    if(index == -1) {
                      return 'Select bank from list.';
                    }
                    return null;
                  },
                ),
              ),
            ),
            // Name Field End

            // Bank Acc Field Start
            Container(
              padding: EdgeInsets.only(bottom: fixPadding * 2.0),
              child: Theme(
                data: ThemeData(
                  primaryColor: primaryColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: primaryColor,
                  ),
                ),
                child: TextFormField(
                  controller: accountNumberController,
                  keyboardType: TextInputType.number,
                  style: black14MediumTextStyle,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Account Number.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Account Number',
                    labelStyle: black14MediumTextStyle,
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: greyColor, width: 0.7),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),

            // IFSC Code Field Start
            Container(
              padding: EdgeInsets.only(bottom: fixPadding * 2.0),
              child: Theme(
                data: ThemeData(
                  primaryColor: primaryColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: primaryColor,
                  ),
                ),
                child: TextFormField(
                  controller: ifscCodeController,
                  keyboardType: TextInputType.text,
                  style: black14MediumTextStyle,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Ifsc.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'IFSC Code',
                    labelStyle: black14MediumTextStyle,
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: greyColor, width: 0.7),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),

            // Save Button Start
            InkWell(
              onTap: () {
                if(_bankDetailFormKey.currentState!.validate()) {
                  createBank();
                }
              },
              borderRadius: BorderRadius.circular(7.0),
              child: Container(
                width: double.infinity,
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
            // Save Button End
          ],
        ),
      ),
    );
  }

  createBank() {
    Object obj = {
      "bankName" : bankNameController.text,
      'ifsc' : ifscCodeController.text,
      "accNumber" : accountNumberController.text
    };
    LoadingOverlay.showLoader(context);
    apiCalls.createBankForUser(obj, context);
  }

  void _selectOptionBottomSheet(String accountNumber) {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          //borderRadius: BorderRadius.circular(10.0)
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0)
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
                color: whiteColor,
              ),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              // height: 200,
              width: width,
              child: Column(
                children: [
                  height20Space,
                  Text("Please Submit the utr number against the transaction"
                      " remitted by 1fx in your given bank account.",style: TextStyle(color: Color(0xff959595),
                      fontWeight: FontWeight.w600, fontSize: 11.0),textAlign: TextAlign.center),
                  height20Space,
                  commonWidget.inputBoxDesign(Icons.account_balance_sharp, utrController, "utr",
                      utrValidator, false, false, () => {}, TextInputType.number,(val) => {},
                      20.0,20.0),
                  height20Space,
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                    child: InkWell(
                      onTap: () {
                        if(utrController.text.trim().isNotEmpty) {
                          Object obj = {
                            "utr" : utrController.text.toString(),
                            'accNumber': accountNumber
                          };
                          Navigator.pop(context);
                          LoadingOverlay.showLoader(context);
                          apiCalls.verifyUtrForUser(obj, context);
                        }
                      },
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: primaryColor,
                        ),
                        child: Text(
                          'Verify',
                          style: white14BoldTextStyle,
                        ),
                      ),
                    ),
                  ),
                  height20Space
                ],
              ),
            ),
          );
        });
  }

  utrValidator(String val) {
    return null;
  }

  selectAccountTypeItem(type) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        setState(() {
          selectedAccountType = type;
        });
      },
      child: Container(
        width: (width - fixPadding * 4.0) / 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 18.0,
              height: 18.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0),
                border: Border.all(
                  width: 0.8,
                  color:
                      (selectedAccountType == type) ? primaryColor : greenColor,
                ),
              ),
              child: Container(
                width: 10.0,
                height: 10.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: (selectedAccountType == type)
                      ? primaryColor
                      : Colors.transparent,
                ),
              ),
            ),
            widthSpace,
            Text(
              type,
              style: black14MediumTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
