import 'dart:async';
import 'package:cryptox/Interceptors/TokenInterceptor.dart';
import 'package:cryptox/api/base.dart';
import 'package:cryptox/api/coins/masterCoinList/getMasterCoinList.dart';
import 'package:cryptox/api/funds/estimateDeduction/estimateDeduction.dart';
import 'package:cryptox/api/funds/withdrawalinr/withdrawalInr.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/portfolio/qrScanner.dart';
import 'package:cryptox/pages/portfolio/withdraw.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../api/funds/allCoinsFund/networkDetails.dart';

class WithdrawalCrypto extends StatefulWidget {
  final List<NetworkDetails> networkDetails;
  final String symbol;
  final String balance;

  const WithdrawalCrypto(
      {Key? key,
      required this.symbol,
      required this.networkDetails,
      required this.balance})
      : super(key: key);

  @override
  _WithdrawalCrypto createState() => _WithdrawalCrypto();
}

class _WithdrawalCrypto extends State<WithdrawalCrypto> {
  late StreamSubscription cryptoWithdrawalSubscription;
  late StreamSubscription masterCoinSubscription;
  TextEditingController destinationController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  TextEditingController networkController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final withdraw = new Withdraw();
  final GlobalKey<FormState> _withdrawalCryptoFormKey = GlobalKey<FormState>();
  bool showOtp = false;
  String otpHint = "";
  String estimateText = "";
  NetworkDetails selectedNetworkDetails = NetworkDetails();
  MasterCoinListingsStruct? selectedCoin;
  final com = Com();
  bool _hasShownErrorToast = false;

  @override
  void initState() {
    super.initState();
    if (widget.networkDetails != null && widget.networkDetails.isNotEmpty) {
      selectedNetworkDetails = widget.networkDetails[0];
      networkController.text = selectedNetworkDetails.symbol ?? "";
    }
    cryptoWithdrawalSubscription =
        apiCalls.inrWithdrawalRequest$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if (kDebugMode) {
        print("CRYPTO WITHDRAWAL " + value.toString());
      }
      if (value is String) {
        return;
      }
      if (value is WithdrawalInrResp) {
        if (value.authType!.length == 0 &&
            value.status != WithdrawalStatus.SUCCESS.name) {
          return;
        }
        if (value.status == WithdrawalStatus.SUCCESS.name) {
          showToast(
              "Verification link has been sent to your mail id, "
              "check spam and promotions for the same.",
              gravity: ToastGravity.BOTTOM,
              toast: Toast.LENGTH_LONG);
          Navigator.pop(context);
        } else {
          setState(() {
            showOtp = checkAuthType(value.authType![0]);
          });
        }
      }
    });
    masterCoinSubscription = apiCalls.masterCoinList$.listen((value) {
      if (value is List<MasterCoinListingsStruct>) {
        if (mounted) {
          setState(() {
            if (value.isNotEmpty) {
              selectedCoin = value[0];
            }
          });
        }
      }
    });
    apiCalls.getMasterCoins(context, symbol: widget.symbol);
  }

  @override
  void dispose() {
    cryptoWithdrawalSubscription.cancel();
    masterCoinSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          height20Space,
          Text(Com().roundToDecimals(double.parse(widget.balance), 6),
              style: black18BoldTextStyle),
          height5Space,
          Text('Current ${widget.symbol.toUpperCase()} Balance',
              style: black12MediumTextStyle),
          SizedBox(height: fixPadding * 3.0),
          Form(
            key: _withdrawalCryptoFormKey,
            child: Column(
              children: [
                Theme(
                  data: ThemeData(
                    primaryColor: greyColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0),
                    child: TextFormField(
                      controller: destinationController,
                      keyboardType: TextInputType.text,
                      style: black16RegularTextStyle,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter the Address.";
                        }
                        if (!networkRegExp.hasMatch(val)) {
                          return 'Invalid address.';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Destination Address',
                        labelStyle: black16RegularTextStyle,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: greyColor, width: 0.7),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: QrScanner(
                                        func: setDestinationTextVal)));
                          },
                          icon: Icon(Icons.qr_code),
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.networkDetails.length > 1) ...[
                  Theme(
                    data: ThemeData(
                      primaryColor: greyColor,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 18, left: 18),
                      child: DropdownButtonFormField2<NetworkDetails>(
                        isExpanded: true,
                        style: black16RegularTextStyle,
                        value: selectedNetworkDetails,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 12),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 0.7),
                          ),
                          labelText: "Network",
                          labelStyle: black16RegularTextStyle,
                        ),
                        items: widget.networkDetails
                            .map((item) => DropdownMenuItem<NetworkDetails>(
                                  value: item,
                                  child: Text(
                                    item.symbol ?? "",
                                    style: black16RegularTextStyle,
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return "Enter the Network";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          selectedNetworkDetails = value!;
                          setState(() {});
                        },
                        buttonStyleData: const ButtonStyleData(width: 0),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Theme(
                    data: ThemeData(
                      primaryColor: greyColor,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 20, left: 20),
                      child: TextFormField(
                        enabled: false,
                        controller: networkController,
                        keyboardType: TextInputType.number,
                        style: black16RegularTextStyle,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Fill Me";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Network',
                          labelStyle: black16RegularTextStyle,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                Container(
                  padding: const EdgeInsets.all(12.0),
                  margin: EdgeInsets.only(top: 20, left: 18.0, right: 18.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: greyColor, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      minMaxText(
                          key: "Max: ",
                          value: selectedCoin != null
                              ? (selectedCoin!.maxWithdrawal ?? "0.0")
                              : "0.0"),
                      minMaxText(
                          key: "Min: ",
                          value: selectedCoin != null
                              ? (selectedCoin!.minWithdrawal ?? "0.0")
                              : "0.0"),
                    ],
                  ),
                ),
                Theme(
                  data: ThemeData(
                    primaryColor: greyColor,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 18, left: 18),
                    child: TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: Com.validateField(),
                      style: black16RegularTextStyle,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter the Amount.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: black16RegularTextStyle,
                        suffix: Text(
                          widget.symbol,
                          style: black16RegularTextStyle,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: greyColor, width: 0.7),
                        ),
                      ),
                    ),
                  ),
                ),
                if (showOtp)
                  Theme(
                    data: ThemeData(
                      primaryColor: greyColor,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 18, left: 18),
                      child: TextFormField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        inputFormatters:
                            Com.validateField(decimal: 0, regex: numberRegExp),
                        style: black16RegularTextStyle,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Fill Me";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: otpHint,
                          labelStyle: black16RegularTextStyle,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),

                // Withdraw Button Start
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 18, left: 18),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(5.0),
                    child: InkWell(
                      onTap: () async {
                        if (!_withdrawalCryptoFormKey.currentState!
                            .validate()) {
                          return;
                        }
                        if (double.parse(amountController.text) >
                                double.parse(
                                    selectedCoin!.maxWithdrawal ?? "0.0") ||
                            double.parse(amountController.text) <
                                double.parse(
                                    selectedCoin!.minWithdrawal ?? "0.0")) {
                          showToast("Check Withdrawal limits.",
                              gravity: ToastGravity.BOTTOM,
                              toast: Toast.LENGTH_LONG);
                          return;
                        }
                        if (double.parse(amountController.text) >
                            double.parse(widget.balance)) {
                          showToast("Not enough funds.",
                              gravity: ToastGravity.BOTTOM,
                              toast: Toast.LENGTH_LONG);
                          return;
                        }

                        /*bool validate = await apiCalls.validateNetworkAddress(
                            context,
                            destinationController.text,
                            networkController.text);
                        if (!validate) {
                          showToast("Invalid Address.",
                              gravity: ToastGravity.BOTTOM,
                              toast: Toast.LENGTH_LONG);
                          return;
                        }*/
                        showOtp ? withdrawalCrypto() : getEstimate();
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
                // Withdraw Button End
                height5Space,
                Text(
                  'Processing time upto 30 minutes.',
                  style: black14SemiBoldTextStyle,
                )
              ],
            ),
          ),
          height20Space,
          withdrawNotice(),
          height20Space
        ],
      ),
    );
  }

  getEstimate() async {
    final dio = Dio();
    EstimateDeductionStruct result;
    dio.interceptors.add(TokenInterceptor(context: context));
    final client = RestClient(dio);
    LoadingOverlay.showLoader(context);
    bool flag = false;
    try {
      var details = await client.getEstimatedFunds(
          amountController.text,
          WithdrawalType.COIN.name,
          widget.symbol,
          selectedNetworkDetails.uniqueId ?? '');
      LoadingOverlay.hideLoader(context);
      if (details.success) {
        if (kDebugMode) {
          print("WITHDRAWAL ESTIMATE RESPONSE " + details.toString());
        }
        result = EstimateDeductionStruct.fromJson(details.result['message']);
        flag = true;
        setState(() {
          estimateText =
              "Final amount after commission and TDS(@${result.tdsPercent}% ~ "
              "₹${double.parse(result.afterTds!).toStringAsFixed(3)}) is ${double.parse(result.finalAmount!).toStringAsFixed(3)}. ";
        });
        com.withdrawalDialog(withdrawalCrypto, context,
            estText: result, amount: amountController.text);
      } else {
        showToast(details.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      return flag;
    } catch (e) {
      if (e is DioError) {
        showToast(e.message.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);

        return false;
      }
      if (!_hasShownErrorToast) {
        showToast(e.toString(),
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        _hasShownErrorToast = true;
        setState(() {});
      }
      //print("WITHDRAWAL ESTIMATE RESPONSE ERROR " + e.toString());
      return false;
    }
  }

  // setDestinationTextVal(String val){
  //   setState(() {
  //     destinationController.text = val;
  //   });
  // }

  void setDestinationTextVal(Barcode val) {
    setState(() {
      String code = val.code ?? "";

      // Find the index of the colon and remove everything before and including it
      int colonIndex = code.indexOf(':');
      if (colonIndex != -1) {
        code = code.substring(colonIndex + 1);
      }

      destinationController.text = code;
      print('The value contains this code: $code');
    });
  }

  withdrawNotice() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 1.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height20Space,
          Container(
            width: double.infinity,
            child: Text(
              'Important',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          heightSpace,
          Text("Disclaimer",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          height5Space,
          Row(
            children: [
              Flexible(
                child: Text(
                    "* Receive only using the (${selectedNetworkDetails.symbol}) network."
                    "\n* Using any other network will result in loss of funds.",
                    style: TextStyle(color: Colors.black54, fontSize: 16)),
              ),
            ],
          ),
          height5Space,
          // Row(
          //   children: [
          //     Flexible(
          //       child: Text("* Withdraw only ${widget.symbol} to this deposit address."
          //           "\n* Withdraw any other asset will result in a loss of funds.",
          //           style: TextStyle(color: Colors.black54,fontSize: 16)),
          //     ),
          //   ],
          // ),
          height20Space
        ],
      ),
    );
  }

  bool checkAuthType(String val) {
    bool flag = false;
    switch (val) {
      case "sms":
        {
          flag = true;
          showToast("Otp Successfully send on mobile.",
              gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
          setState(() {
            otpHint = 'Enter Otp Sent on Mobile.';
          });
          break;
        }
      case "google_auth":
        {
          showToast("Enter Google Auth Otp.",
              gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
          setState(() {
            otpHint = 'Enter Google Auth Otp.';
          });
          flag = true;
          break;
        }
      case "email":
        {
          print("this is Executing hser");
          showToast("Otp Successfully send on Email.",
              gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
          setState(() {
            otpHint = 'Enter Otp Sent on Mail.';
          });
          flag = true;
          break;
        }
      case "none":
        {
          flag = false;
          break;
        }
    }
    return flag;
  }

  withdrawalCrypto() {
    Object obj = {
      "contractAddress": selectedNetworkDetails.contractAddress,
      "symbol": widget.symbol,
      "amount": amountController.text,
      "destAddress": destinationController.text,
      "otp": otpController.text
    };
    if (!showOtp) {
      Navigator.pop(context);
    }
    LoadingOverlay.showLoader(context);
    FocusManager.instance.primaryFocus?.unfocus();
    apiCalls.withdrawalCryptoRequest(
        selectedNetworkDetails.uniqueId ?? "", obj, context);
  }

  Widget minMaxText({required String key, required String value}) {
    return RichText(
      text: TextSpan(
        text: key,
        style: TextStyle(
            fontSize: 14.0,
            color: blackColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'),
        children: <TextSpan>[
          TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 12.0,
                color: blackColor,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}
