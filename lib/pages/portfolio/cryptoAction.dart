import 'dart:async';

import 'package:cryptox/api/funds/allCoinsFund/allCoinsFund.dart';
import 'package:cryptox/api/funds/generateUserAddress/generateUserAddress.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/portfolio/depositCrypto.dart';
import 'package:cryptox/pages/portfolio/withdrawalCrypto.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletons/skeletons.dart';

class CryptoAction extends StatefulWidget {
  const CryptoAction({Key? key}) : super(key: key);

  @override
  _CryptoAction createState() => _CryptoAction();
}

class _CryptoAction extends State<CryptoAction> {
  // List<CoinListings> coins = [];
  List<FundsStruct> allFunds = [];
  List<FundsStruct> dummyCoins = [];
  UserAddressStruct? userAddress;
  TextEditingController searchController = new TextEditingController();
  TextEditingController addressController = TextEditingController();
  StreamSubscription? coinSubscription;
  StreamSubscription? fundsSubscription;
  bool isLoading = true;
  bool addressLoading = true;
  bool showSearch = false;
  final commonWidget = Com();

  @override
  void initState() {
    super.initState();
    fundsSubscription = apiCalls.funds$.listen((value) {
      //print(value.runtimeType);
      if (value is String) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      if (value is List<FundsStruct>) {
        setState(() {
          allFunds = value;
          dummyCoins = value;
          isLoading = false;
        });
      }
    });
    apiCalls.getAllCoinsToFund("-1", context);
  }

  @override
  void dispose() {
    if (coinSubscription != null) {
      coinSubscription!.cancel();
    }
    if (fundsSubscription != null) {
      fundsSubscription!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
          gradient: Com.barGradient(),
        )),
        titleSpacing: 0.0,
        actions: [
          if (!showSearch)
            GestureDetector(
              onTap: () {
                setState(() {
                  showSearch = !showSearch;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.search),
              ),
            )
        ],
        title: showSearch
            ? Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      onChanged: (val) {
                        searchBoxValChange(val);
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                showSearch = !showSearch;
                                searchController.clear();
                                allFunds = dummyCoins;
                              });
                            },
                            child: Icon(Icons.cancel_outlined,
                                color: Colors.white, size: 22.0)),
                        hintText: "search...",
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                'Crypto Action',
                style: white16SemiBoldTextStyle,
              ),
      ),
      body: isLoading
          ? SkeletonListView()
          : ListView.builder(
              itemCount: allFunds.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final item = allFunds[index];
                // FundsStruct item1 = allFunds.where((element) => element.symbol
                //     == item.symbol).first;
                return Padding(
                  padding: (index != allFunds.length - 1)
                      ? EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 2.0,
                          fixPadding * 2.0, 0.0)
                      : EdgeInsets.all(fixPadding * 2.0),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
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
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: fixPadding,
                                right: fixPadding,
                                top: fixPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Com.tokenImage(
                                    imageUrl: 'assets/Images/' +
                                        '${item.symbol!.toLowerCase()}.png'),
                                widthSpace,
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.symbol!,
                                            style: black14MediumTextStyle,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        Com().roundToDecimals(
                                            double.parse(item.balance!),
                                            decimal),
                                        style: black16MediumTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          heightSpace,
                          Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 16.0, right: 16.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (item.canDeposit!) {
                                      setState(() {
                                        addressLoading = true;
                                      });
                                      if (item.networkDetails != null &&
                                          item.networkDetails!.isNotEmpty) {
                                        apiCalls.getUserAddress(
                                            item.networkDetails![0].uniqueId ??
                                                "",
                                            item.symbol ?? "",
                                            context);
                                      }
                                      bottomSheet(Container(
                                          height: 560,
                                          child: DepositCrypto(coin: item)));
                                    } else {
                                      showToast(
                                          "Deposit on this coin is not allowed.",
                                          gravity: ToastGravity.BOTTOM,
                                          toast: Toast.LENGTH_LONG);
                                    }
                                  },
                                  child: Text('Deposit',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0,
                                          color: Colors.white)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (item.canWithdrawal!) {
                                      bottomSheet(Container(
                                          height: 600,
                                          child: WithdrawalCrypto(
                                              symbol: item.symbol!,
                                              networkDetails:
                                                  item.networkDetails!,
                                              balance: item.balance!)));
                                    } else {
                                      showToast(
                                          "Withdrawal on this coin is not allowed.",
                                          gravity: ToastGravity.BOTTOM,
                                          toast: Toast.LENGTH_LONG);
                                    }
                                  },
                                  child: Text('Withdrawal ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0,
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<bool> getAssetImage(path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (e) {
      return false;
    }
  }

  searchBoxValChange(String val) {
    allFunds = dummyCoins;
    List<FundsStruct> li = allFunds
        .where((element) =>
            element.symbol!.toLowerCase().contains(val.toLowerCase()))
        .toList();
    setState(() {
      allFunds = li;
    });
  }

  void bottomSheet(Widget ui) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          //borderRadius: BorderRadius.circular(10.0)
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return ui;
        });
  }
}
