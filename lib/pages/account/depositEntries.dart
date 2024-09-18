import 'dart:async';

import 'package:cryptox/api/coinTransactionLogs/transactionLogHistory.dart';
import 'package:cryptox/api/request/allRequest/allRequests.dart';
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

class DepositEntries extends StatefulWidget {

  @override
  _DepositEntries createState() => _DepositEntries();
}

class _DepositEntries extends State<DepositEntries> with SingleTickerProviderStateMixin {

  List<RequestStruct> fiatDeposits = [];
  List<Wallet> wallets = [];
  List<TransactionLogsStruct> cryptoDeposits = [];
  StreamSubscription? depositCoinSubscription;
  late StreamSubscription walletSubscription;
  late TabController tabController;
  String? selectedCurrency;
  bool isCoinLoading = true;
  int totalCount = 1;
  int totalCountForFiat = 0;
  int totalCountForCrypto = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    depositCoinSubscription = apiCalls.coinTransactions$.listen((value) {
      if(value is String) {
        setState(() {
          isCoinLoading = false;
        });
        return;
      }
      if(value is List<TransactionLogsStruct>) {
        setState(() {
          cryptoDeposits = value;
          totalCount = (totalCountForCrypto / 10).ceil();
          isCoinLoading = false;
        });
      }
    });
    walletSubscription = apiCalls.walletSubject$.listen((value) {
      if (kDebugMode){print("USER WALLET "+ value.toString());}
      if(value is String) {
        // showToast("Failed to load wallets.", gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      if (value is List<Wallet>) {
        if (mounted) {
          setState(() {
            wallets = value.where((element) => element.currency != FiatType.INR.name).toList();
            if(wallets[0].currency!="ALL") {
              wallets.insert(0, Wallet(currency: "ALL"));
            }
            if(wallets.length > 0) {
              selectedCurrency = wallets[0].currency.toString();
              getCoinEntries(TransactionLogStatus.ALL,TransactionType.Deposit,selectedCurrency!,"1");
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
    if(depositCoinSubscription != null) {
      depositCoinSubscription!.cancel();
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
        title: Text('Deposit', style: white16SemiBoldTextStyle),
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
          index ++;
          List<Wallet> wal = wallets.where((element) => element.currency != FiatType.INR.name).toList();
          if(wal.length > 0) {
            getCoinEntries(TransactionLogStatus.ALL,TransactionType.Deposit,wal[0].currency.toString(),"1");
          }
          // setState(() {
          //   totalCount = index;
          // });
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
                getCoinEntries(TransactionLogStatus.ALL,TransactionType.Deposit,
                    selectedCurrency!,"1");
              },
              value: selectedCurrency,
            ),
          ),
          Expanded(child: cryptoDepositHistory()),
        ],
      )
    );
  }

  Widget cryptoDepositHistory() {
    return isCoinLoading ? SkeletonListView() : ListView.builder(
        shrinkWrap: true,
        itemCount: cryptoDeposits.length,
        itemBuilder: (BuildContext context, int index) {
          TransactionLogsStruct item = cryptoDeposits[index];
          var parsedDate = DateTime.parse(item.createdAt!).add(Duration(minutes: 330));
          double finalAmount = item.amount! - double.parse(item.deductedAmt!.isEmpty ? "0.0" : item.deductedAmt!);
          // var parsedUpdatedDate = DateTime.parse(item.updatedAt!);
          // print(parsedUpdatedDate.month);
          return Container(
            margin: const EdgeInsets.all(12.0),
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
                          Text(item.uniqueId!, style: TextStyle(color: Color(0xff000000),fontSize: 13,
                              fontWeight: FontWeight.w600)),
                          Text('(${item.status})',style: TextStyle(
                              color: item.status == TransactionLogStatus.SUCCESS.name ? Color(0xff0E8730) :
                              item.status == TransactionLogStatus.FAILED.name ? Color(0xffFF1300) : Color(0xffE1A303),
                              fontWeight: FontWeight.w600, fontSize: 11.0)),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text((item.finalAmount!.isEmpty ? Com().roundToDecimals(finalAmount, decimal)
                                : Com().roundToDecimals(double.parse(item.finalAmount!), decimal)),style: TextStyle(
                                color: item.status == TransactionLogStatus.SUCCESS.name ? Color(0xff0E8730) :
                                item.status == TransactionLogStatus.FAILED.name ? Color(0xffFF1300) : Color(0xffE1A303),
                                fontWeight: FontWeight.w600, fontSize: 11.0)),
                          )
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${parsedDate.day}/${parsedDate.month}/${parsedDate.year} ${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}",style: TextStyle(color: Color(0xff959595),
                              fontWeight: FontWeight.w600, fontSize: 11.0)),
                          Text('Ded: '+ (item.deductedAmt!.isEmpty ? "0" : item.deductedAmt!),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Orig Amount: ${Com().roundToDecimals(item.amount!, decimal)}',
                            style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 11.0, color: Colors.white)),
                        Text('${item.symbol}',
                            style: TextStyle(fontWeight: FontWeight.w600,
                                fontSize: 11.0, color: Colors.white)),
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
          );
        }
    );
  }

  getCoinEntries(TransactionLogStatus status, TransactionType type, String symbol, String page) {
    Map<String, dynamic> body = {
      "page": page,
      "status": status.name,
      "requestType": type.name,
      "symbol": symbol=="ALL"?"":symbol
    };
    apiCalls.getTransactionHistoryCoin(body, context).then((value) {
      setState(() {
        totalCount = (value / 10).ceil();
        totalCountForCrypto = value;
      });
    });
  }

}