import 'dart:async';

import 'package:cryptox/api/orderFills/completedOrderEntries/completedOrderEntries.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:skeletons/skeletons.dart';

class CompleteOrderEntries extends StatefulWidget {
  @override
  _CompleteOrderEntries createState() => _CompleteOrderEntries();
}

class _CompleteOrderEntries extends State<CompleteOrderEntries>
    with AutomaticKeepAliveClientMixin {
  StreamSubscription? completedOrdersSubscription;
  bool isCompletedLoading = true;
  List<OrderFillsStruct> completedOrders = [];
  int totalCount = 1;

  @override
  void initState() {
    super.initState();
    completedOrdersSubscription =
        apiCalls.userCompletedOrderEntries$.listen((value) {
      if (value is String) {
        setState(() {
          isCompletedLoading = false;
        });
        return;
      }
      if (value is List<OrderFillsStruct>) {
        setState(() {
          completedOrders = value;
          isCompletedLoading = false;
        });
      }
    });
    getCompleteOrderEntries("", "ALL", Filters.None.name, "1", "");
  }

  @override
  void dispose() {
    super.dispose();
    if (completedOrdersSubscription != null) {
      completedOrdersSubscription!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NumberPaginator(
        numberPages: totalCount == 0 ? 1 : totalCount,
        onPageChange: (int index) {
          index++;
          getCompleteOrderEntries(
              "", "ALL", Filters.None.name, index.toString(), "");
        },
        config: NumberPaginatorUIConfig(
          height: 40,
          buttonSelectedForegroundColor: Colors.white,
          buttonUnselectedForegroundColor: primaryColor,
          buttonSelectedBackgroundColor: primaryColor,
        ),
      ),
      body: completedOrderEntries(),
    );
  }

  Widget completedOrderEntries() {
    return isCompletedLoading
        ? SkeletonListView()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: completedOrders.length,
            itemBuilder: (BuildContext context, int index) {
              OrderFillsStruct item = completedOrders[index];
              var parsedDate =
                  DateTime.parse(item.createdAt!).add(Duration(minutes: 330));
              bool flag = item.symbol!.endsWith(FiatType.INR.name);
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 115.0,
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
                                Row(
                                  children: [
                                    Text(item.uniqueId!,
                                        style: TextStyle(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w600)),
                                    Container(
                                      margin: EdgeInsets.only(left: 8.0),
                                      child: Text('(${item.type})',
                                          style: TextStyle(
                                              color: item.type ==
                                                      OrderTypes.BUY.name
                                                  ? Color(0xff0E8730)
                                                  : Colors.red,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.0)),
                                    )
                                  ],
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                      (flag ? '₹' : '\$') +
                                          (double.parse(item.price!)
                                              .toStringAsFixed(8)),
                                      style: TextStyle(
                                          color:
                                              item.type == OrderTypes.BUY.name
                                                  ? Color(0xff0E8730)
                                                  : Colors.red,
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
                                Text(
                                    'Qty: ' +
                                        (double.parse(item.qty!)
                                            .toStringAsFixed(3)),
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
                                child: Text('OID:\n${item.coinOrderId}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0,
                                        color: Colors.white)),
                              ),
                              Flexible(
                                child: Text('MID:\n${item.matchId}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.0,
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

  getCompleteOrderEntries(String searchTerm, String type, String searchFilter,
      String page, String symbol) {
    Map<String, dynamic> body = {
      "page": page,
      "symbol": symbol,
      "searchTerm": searchTerm,
      "searchFilter": searchFilter,
      "type": type
    };
    setState(() {
      isCompletedLoading = true;
    });
    apiCalls.getUserCompletedOrderEntries(body, context).then((value) {
      setState(() {
        totalCount = (value / 10).ceil();
      });
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
