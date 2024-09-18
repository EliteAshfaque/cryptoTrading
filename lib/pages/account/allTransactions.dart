import 'dart:async';

import 'package:cryptox/api/coins/ledger/ledgerEntries.dart';
import 'package:cryptox/api/wallet/userWallet/userWallets.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/widget/common.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:skeletons/skeletons.dart';

class AllTransactions extends StatefulWidget {
  @override
  _AllTransactions createState() => _AllTransactions();
}

class _AllTransactions extends State<AllTransactions>
    with SingleTickerProviderStateMixin {
  final NumberPaginatorController _controller = NumberPaginatorController();
  List<LedgerStruct> allTransactions = [];
  List<Wallet> wallets = [];
  late StreamSubscription transactionSubscription;
  late StreamSubscription walletSubscription;

  bool isLoading = true;
  String? selectedCurrency;
  int totalCount = 1;
  String page = "1";

  @override
  void initState() {
    super.initState();
    transactionSubscription = apiCalls.ledgerEntries$.listen((value) {
      if (value is String) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      if (value is List<LedgerStruct>) {
        setState(() {
          allTransactions = value;
          isLoading = false;
        });
      }
    });
    walletSubscription = apiCalls.walletSubject$.listen((value) {
      if (kDebugMode) {
        print("USER WALLET " + value.toString());
      }
      if (value is String) {
        // showToast("Failed to load wallets.", gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      if (value is List<Wallet>) {
        if (mounted) {
          List<Wallet> filtered =
              value.where((element) => element.currency == "ALL").toList();
          if (filtered.isEmpty) {
            value.insert(0, Wallet(currency: "ALL"));
          }
          setState(() {
            wallets = value;
            selectedCurrency = "ALL";
          });
        }
      }
    });
    getLedgerEntries("", page);
  }

  @override
  void dispose() {
    super.dispose();
    transactionSubscription.cancel();
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
          title: Text('Ledger', style: white16SemiBoldTextStyle),
        ),
        bottomNavigationBar: NumberPaginator(
          numberPages: totalCount,
          onPageChange: (int index) {
            print("PAGE INDEX " + index.toString());
            index++;
            setState(() {
              page = index.toString();
            });
            getLedgerEntries(
                selectedCurrency! == "ALL" ? "" : selectedCurrency!, page);
          },
          config: NumberPaginatorUIConfig(
            height: 40,
            buttonSelectedForegroundColor: Colors.white,
            buttonUnselectedForegroundColor: primaryColor,
            buttonSelectedBackgroundColor: primaryColor,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: DropdownButton2(
                isExpanded: true,
                buttonStyleData: ButtonStyleData(width: 100.0),
                //buttonWidth: 100.0,
                items: wallets.map((Wallet items) {
                  return DropdownMenuItem(
                    value: items.currency,
                    child: Text(items.currency!.toUpperCase()),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCurrency = newValue!;
                    page = "1";
                  });
                  _controller.navigateToPage(0);
                  getLedgerEntries(
                      selectedCurrency! == "ALL" ? "" : selectedCurrency!,
                      page);
                },
                value: selectedCurrency,
              ),
            ),
            Expanded(child: transactions()),
          ],
        ));
  }

  Widget transactions() {
    return isLoading
        ? SkeletonListView()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: allTransactions.length,
            itemBuilder: (BuildContext context, int index) {
              LedgerStruct item = allTransactions[index];
              var parsedDate = DateTime.fromMicrosecondsSinceEpoch(
                  int.parse(item.createdAt!.toString() + "000"));
              //double finalAmount = item.amount! - double.parse(item.deductedAmt!.isEmpty ? "0.0" : item.deductedAmt!);
              // var parsedUpdatedDate = DateTime.parse(item.updatedAt!);
              // print(parsedUpdatedDate.month);
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 110.0,
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
                                Text(item.uniqueId!,
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w600)),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                      (item.symbol == "INR" ? '₹' : "") +
                                          (double.parse(item.amount!)
                                              .toStringAsFixed(3)),
                                      style: TextStyle(
                                          color: item.type ==
                                                  LedgerTransactionType
                                                      .CREDITED.name
                                              ? Color(0xff0E8730)
                                              : Color(0xffFF1300),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0)),
                                )
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${parsedDate.day}/${parsedDate.month}/${parsedDate.year} ${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}",
                                    style: TextStyle(
                                        color: Color(0xff959595),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.0)),
                                Text(item.symbol!,
                                    style: TextStyle(
                                        color: Color(0xff959595),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.0))
                              ],
                            ),
                            height5Space,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('txId: ${item.txId}',
                                    style: TextStyle(
                                        color: Color(0xff959595),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.0)),
                                Text('Utr: ' + (item.utrNo!),
                                    style: TextStyle(
                                        color: Color(0xff959595),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.0))
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
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                    'Open: ${(item.symbol == "INR" ? "₹" : "")}${Com().roundToDecimals(double.parse(item.openingBalance!), decimal)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.0,
                                        color: Colors.white)),
                              ),
                              Expanded(
                                child: Text(
                                    textAlign: TextAlign.right,
                                    'Close: ${(item.symbol == "INR" ? "₹" : "")}${Com().roundToDecimals(double.parse(item.closingBalance!), decimal)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.0,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
  }

  getLedgerEntries(String symbol, String _page) {
    Map<String, dynamic> body = {
      "page": page,
      "symbol": symbol,
    };
    apiCalls.getAllLedgerTransactions(body, context).then((value) {
      setState(() {
        totalCount = (value / 10).ceil();
        // page = _page;
      });
    });
  }
}
