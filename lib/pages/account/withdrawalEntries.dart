import 'dart:async';

import 'package:cryptox/api/coinTransactionLogs/transactionLogHistory.dart';
import 'package:cryptox/api/wallet/userWallet/userWallets.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:skeletons/skeletons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class WithdrawalEntries extends StatefulWidget {

  @override
  _WithdrawalEntries createState() => _WithdrawalEntries();
}

class _WithdrawalEntries extends State<WithdrawalEntries> with SingleTickerProviderStateMixin {

  List<Wallet> wallets = [];
  List<TransactionLogsStruct> cryptoWithdrawal = [];
  List<TransactionLogsStruct> inrWithdrawal = [];
  StreamSubscription? withdrawalCryptoEntriesSubscription;
  late StreamSubscription walletSubscription;
  late TabController tabController;
  String? selectedCurrency;
  bool isCoinLoading = true;
  int totalCountForFiat = 0;
  int totalCountForCrypto = 0;
  int totalCount = 1;
  int selectedIndex = 1;
  String page = "1";

  @override
  void initState() {
    super.initState();
    // tabController = new TabController(length: 2, vsync: this)..addListener(() {
    //   if(tabController.indexIsChanging) {
    //     setState(() {
    //       selectedIndex = tabController.index;
    //     });
    //     if(tabController.index == 1) {
    //
    //       if(apiCalls.userCryptoWithdrawal$.hasListener) {
    //         print("NOT CALLING CRYPTO WITHDRAWAL API...");
    //         apiCalls.userCryptoWithdrawal$.add(cryptoWithdrawal);
    //       }else{
    //         print("CALLING CRYPTO WITHDRAWAL API...");
    //
    //         List<Wallet> wal = wallets.where((element) => element.currency != "INR").toList();
    //         if(wal.length > 0) {
    //
    //         }else {
    //           Timer(Duration(milliseconds: 500), () {
    //             setState(() {
    //               isCoinLoading = false;
    //             });
    //           });
    //         }
    //       }
    //     }else {
    //       if(apiCalls.coinTransactions$.hasListener) {
    //         apiCalls.coinTransactions$.add(inrWithdrawal);
    //       }
    //     }
    //   }
    // });
    withdrawalCryptoEntriesSubscription = apiCalls.userCryptoWithdrawal$.listen((value) {
      if(value is String) {
        setState(() {
          isCoinLoading = false;
        });
        return;
      }
      if(value is List<TransactionLogsStruct>) {
        setState(() {
          cryptoWithdrawal = value;
          totalCount = (totalCountForCrypto / 10).ceil();
          isCoinLoading = false;
        });
      }
    });
    walletSubscription = apiCalls.walletSubject$.listen((value) {
      if (kDebugMode) {print("USER WALLET "+ value.toString());}
      if(value is String) {
        // showToast("Failed to load wallets.", gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      if(value is List<Wallet>) {
        if(mounted){
          setState(() {
            wallets = value.where((element) => element.currency != FiatType.INR.name).toList();
            if(wallets[0].currency!="ALL") {
              wallets.insert(0, Wallet(currency: "ALL"));
            }
            if(wallets.length > 0) {
              selectedCurrency = wallets[0].currency.toString();
              getEntries(TransactionLogStatus.ALL,TransactionType.WithDrawal,selectedCurrency!,
                  page, false);
            }else {
              isCoinLoading = false;
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(withdrawalCryptoEntriesSubscription != null) {
      withdrawalCryptoEntriesSubscription!.cancel();
    }
    walletSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: Com.barGradient(),
            )
        ),
        title: Text('Withdrawal', style: white16SemiBoldTextStyle),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //     },
        //     icon: Icon(
        //       Icons.search,
        //       color: primaryColor,
        //     ),
        //   ),
        // ],
      ),
      bottomNavigationBar: NumberPaginator(
        numberPages: totalCount == 0 ? 1 : totalCount,
        onPageChange: (int index) {
          print("PAGE INDEX "+index.toString());
          index ++;
          getEntries(TransactionLogStatus.ALL,TransactionType.WithDrawal,"",
              index.toString(), false);
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
              buttonStyleData: ButtonStyleData(
                  width: 100.0
              ),
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
                });
                getEntries(TransactionLogStatus.ALL,TransactionType.WithDrawal,selectedCurrency!,
                    selectedIndex.toString(), false);
              },
              value: selectedCurrency,
            ),
          ),
          Expanded(child: cryptoWithdrawalHistory())
        ],
      )
    );
  }


  Widget cryptoWithdrawalHistory() {
    return isCoinLoading ? SkeletonListView() : ListView.builder(
        shrinkWrap: true,
        itemCount: cryptoWithdrawal.length,
        itemBuilder: (BuildContext context, int index) {
          TransactionLogsStruct item = cryptoWithdrawal[index];
          var parsedDate = DateTime.parse(item.createdAt!).add(Duration(minutes: 330));
          double finalAmount = item.amount! - double.parse(item.deductedAmt!.isEmpty ? "0.0" : item.deductedAmt!);
          // var parsedUpdatedDate = DateTime.parse(item.updatedAt!);
          // print(parsedUpdatedDate.month);
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
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(item.uniqueId!, style: TextStyle(color: Color(0xff000000),
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w600)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0,right: 5),
                                    child: Text('(${item.status})',style: TextStyle(
                                        color: item.status == TransactionLogStatus.SUCCESS.name ? Color(0xff0E8730) :
                                        item.status == TransactionLogStatus.FAILED.name ? Color(0xffFF1300) : Color(0xffE1A303),
                                        fontWeight: FontWeight.w600, fontSize: 12.0)),
                                  )
                                ],
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text((item.finalAmount!.isEmpty ? finalAmount.toStringAsFixed(3)
                                  : double.parse(item.finalAmount!).toStringAsFixed(3)),style: TextStyle(
                                  color: item.status == TransactionLogStatus.SUCCESS.name ? Color(0xff0E8730) :
                                  item.status == TransactionLogStatus.FAILED.name ? Color(0xffFF1300) : Color(0xffE1A303),
                                  fontWeight: FontWeight.w600, fontSize: 12.0)),
                            )
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${parsedDate.day}/${parsedDate.month}/${parsedDate.year}"
                                " ${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}"
                                + "    "+ (item.symbol!.replaceFirst("INR", ""))
                                ,style: TextStyle(color: Color(0xff959595),
                                fontWeight: FontWeight.w600, fontSize: 11.0)),
                            Text('Ded: '+ (item.deductedAmt!.isEmpty ? "0" : Com()
                                .roundToDecimals(double.parse(item.deductedAmt!), decimal)),
                                style: TextStyle(color: Color(0xff959595), fontWeight: FontWeight.w600,
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
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Orig Amount: ${Com().roundToDecimals(item.amount!, decimal)}',
                              style: TextStyle(fontWeight: FontWeight.w600,
                              fontSize: 11.0, color: Colors.white))
                          // Text('Created: ${parsedDate.day}/${parsedDate.month}/${parsedDate.year}'
                          //     ' ${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}',
                          // style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0, color: Colors.white)),
                          // Text('Updated At: ${parsedUpdatedDate.day}/${parsedUpdatedDate.month}/${parsedUpdatedDate.year}'
                          //     ' ${parsedUpdatedDate.hour}:${parsedUpdatedDate.minute}:${parsedUpdatedDate.second}',
                          //     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0, color: Colors.white))
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

  getEntries(TransactionLogStatus status, TransactionType type, String symbol, String page,bool flag) {
    Map<String, dynamic> body = {
      "page": page,
      "status": status.name,
      "requestType": type.name,
      "symbol": symbol=="ALL"?"":symbol
    };
    flag ? apiCalls.getTransactionHistoryCoin(body, context).then((value) {
      setState(() {
        totalCount = (value / 10).ceil();
        totalCountForFiat = value;
      });
    }) : apiCalls.getUserWithdrawalHistory(body, context).then((value) {
      setState(() {
        totalCount = (value / 10).ceil();
        totalCountForCrypto = value;
      });
    });
  }

}