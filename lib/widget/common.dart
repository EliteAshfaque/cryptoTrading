import 'dart:math';

import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/api/funds/estimateDeduction/estimateDeduction.dart';
import 'package:cryptox/constant/api.dart';
import 'package:cryptox/pages/coinDetails/coinAppDrawer/coinAppDrawer.dart';
import 'package:cryptox/pages/coinDetails/main_view.dart';
import 'package:cryptox/pages/market/savedCoinsAppBar.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/decimalTextInputFormatter.dart';
import 'package:cryptox/util/tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:page_transition/page_transition.dart';

import '../constant/constant.dart';

class Com extends StatelessWidget {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  Widget inputBoxDesign(
      IconData icon,
      TextEditingController controller,
      String hintText,
      Function validator,
      bool flagObs,
      bool showEye,
      Function _toggle,
      TextInputType text,
      Function change,
      double left,
      double right,
      {List<TextInputFormatter>? formatters,
      int? maxLength}) {
    return Padding(
      padding: EdgeInsets.only(right: right, left: left),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: black14MediumTextStyle,
        inputFormatters: formatters ?? [],
        // Simplified null check for formatters
        keyboardType: text,
        controller: controller,
        maxLength: maxLength,
        // Optional maxLength parameter
        validator: (val) {
          if (hintText != "Referral (Optional)" &&
              (val == null || val.isEmpty)) {
            return 'Enter your ${hintText.toLowerCase()}.';
          }
          return validator(val);
        },
        obscureText: flagObs,
        onChanged: (val) {
          change(val);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20.0),
          hintText: hintText,
          hintStyle: black14MediumTextStyle,
          fillColor: whiteColor,
          filled: true,
          counterText: "",
          // Removes the counter text if maxLength is set
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: redColor),
          ),
          prefixIcon: Icon(icon, color: Colors.grey.shade300, size: 24),
          suffixIcon: showEye
              ? GestureDetector(
                  onTap: () {
                    _toggle();
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Icon(
                          flagObs
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye_rounded,
                          color: Colors.grey.shade400,
                          size: 24)),
                )
              : null,
        ),
      ),
    );
  }

  Widget inputBoxDesignWithSuffixBTn(
      IconData icon,
      TextEditingController controller,
      String hintText,
      Function validator,
      bool verifyDisable,
      Function _verify,
      TextInputType text,
      Function change,
      double left,
      double right,
      {List<TextInputFormatter>? formatters}) {
    return Padding(
      padding: EdgeInsets.only(right: right, left: left),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: black14MediumTextStyle,
        inputFormatters: formatters == null ? [] : formatters,
        keyboardType: text,
        readOnly: verifyDisable,
        controller: controller,
        validator: (val) {
          if (hintText != "Referral (Optional)" &&
              (val == null || val.isEmpty)) {
            return 'Enter your ${hintText.toLowerCase()}.';
          }
          return validator(val);
        },
        onChanged: (val) {
          change(val);
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20.0),
            hintText: hintText,
            hintStyle: black14MediumTextStyle,
            fillColor: whiteColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: redColor),
            ),
            prefixIcon: Icon(icon, color: Colors.grey.shade300, size: 24),
            suffixIcon: GestureDetector(
                onTap: () {
                  if (!verifyDisable) {
                    _verify();
                  }
                },
                child: Container(
                  width: 60,
                  margin: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.0),
                    color: verifyDisable ? Colors.grey.shade500 : primaryColor,
                  ),
                  child: Text(
                    'Verify',
                    style: white12BoldTextStyle,
                  ),
                ))),
      ),
    );
  }

  Widget inputBoxReffralDesign(
      IconData icon,
      TextEditingController controller,
      String hintText,
      Function validator,
      bool flagObs,
      bool showEye,
      Function _toggle,
      TextInputType text,
      Function change,
      double left,
      double right,
      {List<TextInputFormatter>? formatters}) {
    return Padding(
      padding: EdgeInsets.only(right: right, left: left),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: black14MediumTextStyle,
        inputFormatters: formatters == null ? [] : formatters,
        keyboardType: text,
        controller: controller,
        validator: (val) {
          if (hintText != "Referral (Optional)" &&
              (val == null || val.isEmpty)) {
            return 'Enter your ${hintText.toLowerCase()}.';
          }
          return validator(val);
        },
        onChanged: (val) {
          change(val);
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20.0),
            hintText: hintText,
            hintStyle: black14MediumTextStyle,
            fillColor: whiteColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: redColor),
            ),
            prefixIcon: Icon(icon, color: Colors.grey.shade300, size: 24),
            suffixIcon: showEye
                ? Icon(flagObs ? Icons.check_circle : Icons.cancel,
                    color:
                        flagObs ? Colors.green.shade500 : Colors.red.shade500,
                    size: 24)
                : null),
      ),
    );
  }

  Widget inputBoxDesignWithLength(
      IconData icon,
      int length,
      TextEditingController controller,
      String hintText,
      Function validator,
      bool flagObs,
      bool showEye,
      Function _toggle,
      TextInputType text,
      Function change,
      double left,
      double right,
      {List<TextInputFormatter>? formatters}) {
    return Padding(
      padding: EdgeInsets.only(right: right, left: left),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: black14MediumTextStyle,
        inputFormatters: formatters == null ? [] : formatters,
        keyboardType: text,
        maxLength: length,
        controller: controller,
        validator: (val) {
          if (hintText != "Referral (Optional)" &&
              (val == null || val.isEmpty)) {
            return 'Enter your ${hintText.toLowerCase()}.';
          }
          return validator(val);
        },
        obscureText: flagObs,
        onChanged: (val) {
          change(val);
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20.0),
            hintText: hintText,
            hintStyle: black14MediumTextStyle,
            fillColor: whiteColor,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: redColor),
            ),
            prefixIcon: Icon(icon, color: Colors.grey.shade300, size: 24),
            suffixIcon: showEye
                ? GestureDetector(
                    onTap: () {
                      _toggle();
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 16),
                        child: Icon(
                            flagObs
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye_rounded,
                            color: Colors.grey.shade400,
                            size: 24)))
                : null),
      ),
    );
  }

  Widget countrySelection(
      double left,
      double right,
      TextEditingController controller,
      Function getCountryCode,
      Function validator) {
    return Padding(
      padding: EdgeInsets.only(right: right, left: left),
      child: IntlPhoneField(
        style: black14MediumTextStyle,
        controller: controller,
        decoration: InputDecoration(
          fillColor: whiteColor,
          filled: true,
          contentPadding: EdgeInsets.all(12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.red),
          ),
          hintText: 'Phone',
          hintStyle: black14MediumTextStyle,
        ),
        initialCountryCode: 'IN',
        validator: (val) {
          if (val == null || val.number.isEmpty) {
            return 'Enter your Phone Number.';
          }
          return validator(val.number);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        dropdownIcon:
            Icon(Icons.arrow_drop_down_outlined, color: Colors.grey.shade300),
        // disableLengthCheck: false,
        onChanged: (phone) {
          getCountryCode(phone.countryCode);
        },
      ),
    );
  }

  Widget textFieldBoxLayout(Widget child, double right, double left) {
    return Padding(
      padding: EdgeInsets.only(right: right, left: left),
      child: Container(
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
        child: child,
      ),
    );
  }

  withdrawalDialog(Function withdrawal, BuildContext context,
      {required EstimateDeductionStruct estText, required String amount}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 200,
            width: double.infinity,
            // padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: textRows(key: "Amount", value: amount),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, bottom: 12.0),
                  child: textRows(
                      key: "Charge",
                      value: (double.parse(amount) -
                              double.parse(estText.afterCommission!))
                          .toStringAsFixed(9)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, bottom: 12.0),
                  child: textRows(
                      key: "TDS(@${estText.tdsPercent}%)",
                      value: estText.tdsToken!,
                      tds: estText.afterTds),
                ),
                Container(
                  height: 35,
                  margin: EdgeInsets.only(left: 8.0, right: 8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    color: Color(0xFFD9D9D9),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Amount",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: blackColor)),
                      Container(
                        height: 35,
                        padding:
                            EdgeInsets.only(left: 5.0, right: 5.0, top: 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                          color: Color(0xFFF58048),
                        ),
                        child: Text(
                            double.parse(estText.finalAmount!)
                                .toStringAsFixed(9),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 12)),
                      )
                    ],
                  ),
                ),
                // Text((estText ?? "") +
                //   'Sure, you want to Withdrawal.',
                //   style: black16SemiBoldWordSpaceTextStyle,
                //   textAlign: TextAlign.center,
                // ),
                // Text("Are you Sure",style: black12MediumTextStyle,textAlign: TextAlign.center),
                // Text("you want to Withdrawal",style: TextStyle(color: Color(0xFF525252),
                //   fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                Expanded(child: Text("")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0))),
                          child: Text(
                            'Cancel',
                            style: white14MediumTextStyle,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          withdrawal();
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.0))),
                          child: Text(
                            'Withdrawal',
                            style: white14MediumTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget textRows(
      {required String key, required String value, String? tds = "0"}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(key, style: black14BoldTextStyle),
            if (key.contains('TDS'))
              MyTooltip(
                  child: Icon(
                    Icons.info,
                    size: 18.0,
                  ),
                  message:
                      'As per government laws, tds of amount ₹$tds will be deducted.'),
          ],
        ),
        Expanded(
            child: Text(value,
                style: black16RegularTextStyle, textAlign: TextAlign.end))
      ],
    );
  }

  commonDialog(BuildContext context, String text, Function action) {
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
                      'You sure want to $text?',
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
                            action();
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
                              "Confirm",
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

  String roundToDecimals(double val, int decimal) {
    decimal = min(decimal, 9);
    final num = val.toString().contains('e') ? "0" : val.toString();
    final dot = num.indexOf('.');
    if (dot == -1) return num;
    List<String> arr = num.split('.');
    if ((dot + decimal + 1) > arr[1].length) {
      if (decimal > arr[1].length) {
        return num;
      } else {
        return arr[0] + '.' + arr[1].substring(0, decimal);
      }
    }
    String str = num.substring(0, dot + decimal + 1);
    print('the Total quantity is ===>>> ${str}');
    return str.contains('e') ? "0" : str;
  }

  String formatNumber(double number) {
    if (number >= 1000000000000) {
      return '${(number / 1000000000000).toStringAsFixed(1)}T';
    } else if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      List<String> strList = number.toString().split('.');
      if (strList.length > 1) {
        if (strList[1].length >= 9) {
          return '${number.toStringAsFixed(9)}';
        }
      }
      return number.toString();
    }
  }

  // static Widget tokenImage(
  //     {required String imageUrl, double width = 45.0, double height = 45.0}) {
  //   return Image.network(
  //     websiteUrl + imageUrl,
  //     height: height,
  //     width: width,
  //     fit: BoxFit.cover,
  //     loadingBuilder: (context, child, loadingProgress) =>
  //         (loadingProgress == null) ? child : CircularProgressIndicator(),
  //     errorBuilder: (context, error, stackTrace) => Image.asset(
  //         'assets/Images/btc.png',
  //         height: height,
  //         width: width,
  //         fit: BoxFit.cover),
  //   );
  // }
  static Widget tokenImage({
    required String imageUrl,
    double width = 45.0,
    double height = 45.0,
  }) {
    print("The is the image ${imageUrl}");
    return Image.network(
      websiteUrl + imageUrl,
      height: height,
      width: width,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) =>
      (loadingProgress == null) ? child : CircularProgressIndicator(),
      errorBuilder: (context, error, stackTrace) {
        // Print the error and stack trace
        print('Error loading image: $error');
        if (stackTrace != null) {
          print('Stack trace: $stackTrace');
        }
        // Return fallback image
        return Image.asset(
          'assets/Images/btc.png',
          height: height,
          width: width,
          fit: BoxFit.cover,
        );
      },
    );
  }

  static Widget createTab({required String text}) {
    return Tab(
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            child: Container(
                child: Center(child: Text(text)),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: primaryColor))))),
      ]),
    );
  }

  static List<TextInputFormatter> validateField(
      {int decimal = 8, RegExp? regex}) {
    List<TextInputFormatter> li = [
      FilteringTextInputFormatter.allow(
          regex == null ? RegExp(r'[0-9.]') : regex),
      TextInputFormatter.withFunction((oldValue, newValue) {
        try {
          final text = newValue.text;
          if (text.isNotEmpty) double.parse(text);
          return newValue;
        } catch (e) {}
        return oldValue;
      }),
    ];
    if (decimal > 0) {
      li.add(DecimalTextInputFormatter(
        decimalRange: decimal,
      ));
    }
    return li;
  }

  static List<TextInputFormatter> validateWhiteSpace(
      {int decimal = 8, RegExp? regex}) {
    List<TextInputFormatter> li = [
      FilteringTextInputFormatter.allow(regex ?? RegExp(r'[0-9.\s]')),
      // Allows digits, decimal points, and whitespace initially
      TextInputFormatter.withFunction((oldValue, newValue) {
        final text = newValue.text;

        // Prevents spaces after entering the number
        if (text.contains(RegExp(r'\d')) && text.contains(' ')) {
          return oldValue;
        }

        try {
          if (text.isNotEmpty)
            double.parse(text.replaceAll(RegExp(r'\s+'), ''));
          return newValue;
        } catch (e) {
          return oldValue;
        }
      }),
    ];

    if (decimal > 0) {
      li.add(DecimalTextInputFormatter(decimalRange: decimal));
    }

    return li;
  }

  tabBarTextDesign(String text) {
    return Text(text,
        style: TextStyle(
            color: blackColor, fontWeight: FontWeight.bold, fontSize: 12));
  }

  appDrawer(Function func, TabController _tabController, int val) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TabBar(
                  onTap: (val) {
                    func(val);
                  },
                  isScrollable: true,
                  controller: _tabController,
                  indicatorColor: primaryColor,
                  indicator: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                        child: Container(
                            margin: EdgeInsets.only(top: 2),
                            child: Text("*",
                                style: TextStyle(
                                    color: val == 0
                                        ? Colors.white
                                        : Colors.black54,
                                    fontSize: 18)))),
                    Tab(
                        child: Text(FiatType.USDT.name,
                            style: TextStyle(
                                color:
                                    val == 1 ? Colors.white : Colors.black54))),
                    Tab(
                        child: Text(FiatType.ETH.name,
                            style: TextStyle(
                                color:
                                    val == 2 ? Colors.white : Colors.black54))),
                    Tab(
                        child: Text(FiatType.BNB.name,
                            style: TextStyle(
                                color:
                                    val == 3 ? Colors.white : Colors.black54))),
                    Tab(
                        child: Text(FiatType.BTC.name,
                            style: TextStyle(
                                color:
                                    val == 4 ? Colors.white : Colors.black54))),
                    // Tab(child: Text(FiatType.ONEFX.name,
                    //     style: TextStyle(color: val == 5 ?
                    //     Colors.white : Colors.black54))),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    SavedCoinsAppBar(),
                    CoinAppDrawer(fiatType: FiatType.USDT),
                    CoinAppDrawer(fiatType: FiatType.ETH),
                    CoinAppDrawer(fiatType: FiatType.BNB),
                    CoinAppDrawer(fiatType: FiatType.BTC),
                    // CoinAppDrawer(fiatType: FiatType.ONEFX),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  static FiatType checkFiatType(String val) {
    if (val.endsWith(FiatType.USDT.name)) {
      return FiatType.USDT;
    } else if (val.endsWith(FiatType.ETH.name)) {
      return FiatType.ETH;
    } else if (val.endsWith(FiatType.BTC.name)) {
      return FiatType.BTC;
    } else if (val.endsWith(FiatType.BNB.name)) {
      return FiatType.BNB;
    } else if (val.endsWith(FiatType.ONEFX.name)) {
      return FiatType.ONEFX;
    } else {
      return FiatType.INR;
    }
  }

  Widget coinCard(
      int index, CoinListings item, BuildContext context, int coinLength) {
    FiatType fiatType = Com.checkFiatType(item.symbol!);
    return Padding(
      padding: (index != coinLength - 1)
          ? EdgeInsets.fromLTRB(
              fixPadding * 2.0, fixPadding * 2.0, fixPadding * 2.0, 0.0)
          : EdgeInsets.all(fixPadding * 2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.size,
                  alignment: Alignment.center,
                  child: CoinView(coin: item, fiatType: fiatType)));
        },
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: EdgeInsets.all(fixPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                spreadRadius: 1.0,
                color: blackColor.withOpacity(0.05),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Com.tokenImage(imageUrl: item.imgUrl!),
              widthSpace,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.symbol!.replaceFirst(fiatType.name, "") +
                              '/${fiatType.name}',
                          style: black14MediumTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (item.ticker == 'up')
                                ? Icon(
                                    Icons.arrow_drop_up,
                                    color: greenColor,
                                  )
                                : Icon(
                                    Icons.arrow_drop_down,
                                    color: redColor,
                                  ),
                            Text(
                              item.percentageChange!,
                              style: TextStyle(
                                  color: item.ticker == 'up'
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      (fiatType == FiatType.INR ? "₹" : "\$") +
                          item.closePrice!.toStringAsFixed(6),
                      style: black16MediumTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static LinearGradient barGradient() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF161616), Color(0xFF373737)]);
  }

  commonAlertDialog(BuildContext context, String text,
      {String btnText = "Cancel"}) {
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
                      text,
                      style: black16BoldTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    heightSpace,
                    heightSpace,
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
                          btnText,
                          style: white14MediumTextStyle,
                        ),
                      ),
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
}
