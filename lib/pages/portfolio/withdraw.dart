import 'dart:async';

import 'package:cryptox/Interceptors/TokenInterceptor.dart';
import 'package:cryptox/api/bank/userBank/userBank.dart';
import 'package:cryptox/api/base.dart';
import 'package:cryptox/api/funds/estimateDeduction/estimateDeduction.dart';
import 'package:cryptox/api/funds/withdrawalinr/withdrawalInr.dart';
import 'package:cryptox/api/wallet/userWallet/userWallets.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {

  final amountController = TextEditingController();
  final otpController = TextEditingController();
  late StreamSubscription userBankSubscription;
  late StreamSubscription walletSubscription;
  late StreamSubscription inrWithdrawalSubscription;
  final GlobalKey<FormState> _withdrawalInrFormKey = GlobalKey<FormState>();
  List<UserBankStruct> userBanks = [];
  bool showOtp = false;
  bool isLoading = true;
  UserBankStruct? selectedBank;
  String? selectedBankName;
  Wallet? inrWallet;
  String otpHint = "";
  String estimateText = "";
  bool isBankListFound = true;
  final com = Com();

  @override
  void initState() {
    super.initState();
    // Timer(new Duration(milliseconds: 10), () {
    //   Loader.showLoader(context);
    // });
    //Loader.showLoader(context);
    userBankSubscription = apiCalls.userBank$.listen((value) {
      if (kDebugMode){print("BANK DETAILS ON PAGE "+value.toString());}
      if(value is String) {
        //Loader.hideLoader(context);
        return;
      }
      if(value is List<UserBankStruct>) {
        if(value.length == 0) {
          showToast("No bank account found, add some to withdrawal.", gravity: ToastGravity.BOTTOM,
              toast: Toast.LENGTH_LONG);
          setState(() {
            isBankListFound = false;
          });
          // Navigator.pop(context);
          return;
        }
        setState(() {
          userBanks = value.where((element) => (element.status == UserBankStatus.VERIFIED.name &&
              element.active! )).toList();
          isLoading = false;
        });
        //Loader.hideLoader(context);
      }
    });
    walletSubscription = apiCalls.walletSubject$.listen((value) {
      if (kDebugMode){print("USER WALLET "+ value.toString());}
      if(value is String) {
        // showToast("Failed to load wallets.", gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      if(value is List<Wallet>) {
        if(mounted)
          setState(() {
            inrWallet = value.where((element) => element.currency == "INR").first;
          });
      }
    });
    inrWithdrawalSubscription = apiCalls.inrWithdrawalRequest$.listen((value) {
      if (kDebugMode){print("INR WITHDRAWAL "+ value.toString());}
      if(value is String) {
        LoadingOverlay.hideLoader(context);
        return;
      }
      if(value is WithdrawalInrResp) {
        if(value.authType!.length == 0 && value.status != WithdrawalStatus.SUCCESS.name) {
          LoadingOverlay.hideLoader(context);
          return;
        }
        if(value.status == WithdrawalStatus.SUCCESS.name) {
          showToast("Successfully Withdrawal Inr.", gravity: ToastGravity.BOTTOM,
              toast: Toast.LENGTH_LONG);
          LoadingOverlay.hideLoader(context);
          Navigator.pop(context);
        }else {
          setState(() {
            showOtp = checkAuthType(value.authType![0]);
          });
          LoadingOverlay.hideLoader(context);
        }
      }
    });
    apiCalls.getUserBankDetails(context);
  }

  @override
  void dispose() {
    super.dispose();
    userBankSubscription.cancel();
    walletSubscription.cancel();
    inrWithdrawalSubscription.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        titleSpacing: 0.0,
        title: Text(
          'Withdrawal',
          style: white16SemiBoldTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            height20Space,
            Image.asset(
              'assets/Images/coinExcha.png',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            height20Space,
            inrWallet != null ?
            Text(
              "₹"+ (double.parse(inrWallet!.balance!)
                  - double.parse(inrWallet!.freezeAmount!)).toStringAsFixed(3),
              style: black18BoldTextStyle,
            ) : Text(
              "₹"+double.parse("0").toStringAsFixed(3),
              style: black18BoldTextStyle,
            ),
            height5Space,
            Text(
              'Current Balance',
              style: black12MediumTextStyle,
            ),
            SizedBox(height: fixPadding * 3.0),
            if(!isLoading)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
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
                        Text("Bank" + ": ",style: black14w600TextStyle),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: DropdownButton2(
                            isExpanded: true,
                            items: userBanks.map((UserBankStruct items) {
                              return DropdownMenuItem(
                                value: items.uniqueId,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(items.bankName!.toUpperCase()),
                                    height5Space,
                                    Text("Acc No"+ ": " + (items.accNumber ?? ""), style: TextStyle(
                                        fontSize: 9
                                    )),
                                    Text("Ifsc" +": " + (items.ifsc ?? ""), style: TextStyle(
                                        fontSize: 9
                                    )),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedBankName = newValue!;
                              });
                            },
                            value: selectedBankName,
                            hint: Text("Select Bank"),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            height20Space,
            // Amount Textfield Start
            Form(
              key: _withdrawalInrFormKey,
              child: Column(
                children: [
                  Theme(
                    data: ThemeData(
                      primaryColor: greyColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: black16RegularTextStyle,
                        validator: (val) {
                          if(val!.isEmpty) {
                            return "Enter the Amount";
                          }
                          if(int.parse(val) < 999) {
                            return "Minimum withdrawal amount is 1000";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          labelStyle: black16RegularTextStyle,
                          suffix: Text(
                            '₹',
                            style: black16RegularTextStyle,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if(showOtp)
                    height20Space,
                  if(showOtp)
                    Theme(
                      data: ThemeData(
                        primaryColor: greyColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                        child: TextFormField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          style: black16RegularTextStyle,
                          validator: (val) {
                            if(val!.isEmpty) {
                              return "Enter the OTP";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: otpHint,
                            labelStyle: black16RegularTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: greyColor, width: 0.7),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),

            ),
            SizedBox(height: fixPadding * 3.0),
            withdrawNote(),
            height20Space,
            if(isBankListFound)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(5.0),
                  child:
                  InkWell(
                    onTap: () {
                      if(!_withdrawalInrFormKey.currentState!.validate()) {
                        return;
                      }
                      if(double.parse(amountController.text) > double.parse(inrWallet!.balance!)) {
                        showToast("Not enough funds.", gravity: ToastGravity.BOTTOM,
                            toast: Toast.LENGTH_LONG);
                        return;
                      }
                      if(selectedBankName == null || selectedBankName!.isEmpty) {
                        showToast("Bank not selected.", gravity: ToastGravity.BOTTOM,
                            toast: Toast.LENGTH_LONG);
                        return;
                      }
    if (kDebugMode){ print(selectedBankName);}
                      showOtp ? withdrawalCoin() : getEstimate();
                    },
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(fixPadding * 0.7),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: primaryColor,
                      ),
                      child: Text(
                        'Withdrawal'.toUpperCase(),
                        style: white16MediumTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            heightSpace,
            Text(
              'Processing time upto 24 hours.',
              style: black14SemiBoldTextStyle,
            ),
            height20Space
          ],
        ),
      ),
    );
  }

  withdrawalCoin() {
    Navigator.pop(context);
    var arr = userBanks.where((element) => element.uniqueId!.toLowerCase() ==
        selectedBankName!.toLowerCase()).toList();
    if(arr.length == 0) {
      showToast("Issue with selected Bank.", gravity: ToastGravity.BOTTOM,
          toast: Toast.LENGTH_LONG);
      return;
    }
    selectedBank = arr[0];
    Object obj = {
      "walletId" : inrWallet!.uniqueId,
      "amount" : amountController.text,
      "bankId" : selectedBank!.uniqueId,
      "otp" : otpController.text
    };
    LoadingOverlay.showLoader(context);
    apiCalls.withdrawalInrRequest(obj, context);
  }


  getEstimate() async {
    final dio = Dio();
    EstimateDeductionStruct result;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    LoadingOverlay.showLoader(context);
    bool flag = false;
    try {
      var details = await client.getEstimatedFunds(amountController.text,
          WithdrawalType.INR.name,'','');
      LoadingOverlay.hideLoader(context);
      if (details.success) {
        if (kDebugMode){print("WITHDRAWAL ESTIMATE RESPONSE " + details.toString());}
        result = EstimateDeductionStruct.fromJson(details.result['message']);
        flag = true;
        setState(() {
          estimateText = "Final amount after commission and TDS(@${result.tdsPercent}% ~ ₹${result.afterTds}) is "
              "${result.finalAmount}. ";
        });
        com.withdrawalDialog(withdrawalCoin,context,estText: result,amount: amountController.text);
      } else {
        if (kDebugMode){print(details.result['error']);}
        showToast(details.result['error'], gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      return flag;
    } catch (e) {
      if(e is DioError) {
        showToast(e.message.toString(),gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return false;
      }
      showToast(e.toString(),gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("WITHDRAWAL ESTIMATE RESPONSE ERROR " + e.toString());
      return false;
    }
  }

  withdrawNote() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 16.0,right: 16.0),
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 1.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height20Space,
          Text(
            'Notes' +':',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Text("1. "+"Max 2 lakhs per transaction.",
            style: black14RegularTextStyle,
          ),
          heightSpace,
          Text("2. "+"Total 20 lakhs per day.",
            style: black14RegularTextStyle,
          ),
          heightSpace,
          Text("3. "+"Minimum withdrawal limit is ₹1000.",
            style: black14BoldTextStyle,
          ),
          height20Space
        ],
      ),
    );
  }

  amountSuggestionItem(amount) {
    return InkWell(
      onTap: () {
        setState(() {
          amountController.text = '$amount';
        });
      },
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        padding: EdgeInsets.all(fixPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: greyColor.withOpacity(0.2),
        ),
        child: Text(
          '\$$amount',
          style: black14RegularTextStyle,
        ),
      ),
    );
  }

  bool checkAuthType(String val) {
    bool flag = false;
    switch (val) {
      case "sms": {
        flag = true;
        showToast("Otp Successfully send on mobile.", gravity: ToastGravity.BOTTOM,
            toast: Toast.LENGTH_LONG);
        setState(() {
          otpHint = 'Enter Otp Sent on Mobile.';
        });
        break;
      }
      case "google_auth": {
        showToast("Enter Google Auth Otp.", gravity: ToastGravity.BOTTOM,
            toast: Toast.LENGTH_LONG);
        setState(() {
          otpHint = 'Enter Google Auth Otp.';
        });
        flag = true;
        break;
      }
      case "email": {
        showToast("Otp Successfully send on Email.", gravity: ToastGravity.BOTTOM,
            toast: Toast.LENGTH_LONG);
        setState(() {
          otpHint = 'Enter Otp Sent on Mail.';
        });
        flag = true;
        break;
      }
      case "none": {
        flag = false;
        break;
      }
    }
    return flag;
  }

}
