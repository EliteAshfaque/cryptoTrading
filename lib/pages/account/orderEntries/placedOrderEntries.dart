import 'dart:async';

import 'package:cryptox/api/Order/placedOrderEntries/placeOrderEntries.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:skeletons/skeletons.dart';

class PlacedOrderEntries extends StatefulWidget {
  @override
  _PlacedOrderEntries createState() => _PlacedOrderEntries();
}

class _PlacedOrderEntries extends State<PlacedOrderEntries>
    with AutomaticKeepAliveClientMixin {
  StreamSubscription? placedOrdersSubscription;
  late StreamSubscription cancelOrderSubscription;
  late OrderSchedulerStruct selectedOrder;
  List<OrderSchedulerStruct> placedOrders = [];
  String page = "1";
  bool isPlacedLoading = true;
  int totalCount = 1;
  int deleteIndex = 0;

  @override
  void initState() {
    super.initState();
    placedOrdersSubscription = apiCalls.userPlacedOrderEntries$.listen((value) {
      if (value is String) {
        setState(() {
          isPlacedLoading = false;
        });
        return;
      }
      if (value is List<OrderSchedulerStruct>) {
        setState(() {
          placedOrders = value;
          isPlacedLoading = false;
        });
      }
    });
    cancelOrderSubscription = apiCalls.cancelOrder$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if (value is String) {
        // placedOrders.add(selectedOrder);
        return;
      }

      if (value is OrderSchedulerStruct) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Order cancelled.')));
      }
    });
    getPlacedOrderEntries(
        "", "", Filters.None.name, page, OrderStatus.Placed.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NumberPaginator(
        numberPages: totalCount == 0 ? 1 : totalCount,
        onPageChange: (int index) {
          index++;
          getPlacedOrderEntries("", "ALL", Filters.None.name, index.toString(),
              OrderStatus.Placed.name);
        },
        config: NumberPaginatorUIConfig(
          height: 40,
          buttonSelectedForegroundColor: Colors.white,
          buttonUnselectedForegroundColor: primaryColor,
          buttonSelectedBackgroundColor: primaryColor,
        ),
      ),
      body: placedOrderEntries(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    cancelOrderSubscription.cancel();
    if (placedOrdersSubscription != null) {
      placedOrdersSubscription!.cancel();
    }
  }

  Widget placedOrderEntries() {
    return isPlacedLoading
        ? SkeletonListView()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: placedOrders.length,
            itemBuilder: (BuildContext context, int index) {
              OrderSchedulerStruct item = placedOrders[index];
              var parsedDate =
                  DateTime.parse(item.createdAt!).add(Duration(minutes: 330));
              bool flag = item.symbol!.endsWith(FiatType.INR.name);
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  // Remove the item from the data source.
                  setState(() {
                    selectedOrder = item;
                    deleteIndex = index;
                    placedOrders.removeAt(index);
                  });
                  LoadingOverlay.showLoader(context);
                  apiCalls
                      .cancelUserOrder({"orderId": item.uniqueId!}, context);
                },
                background: Container(color: Colors.red),
                child: Padding(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(item.uniqueId!,
                                          style: TextStyle(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w600)),
                                      // Container(
                                      //   margin: EdgeInsets.only(left: 8.0),
                                      //   child: Text('(${item.status})',style: TextStyle(
                                      //       color: item.status == OrderStatus.Completed.name ? Color(0xff0E8730) :
                                      //       item.status == OrderStatus.Canceled.name ? Color(0xffFF1300) : Color(0xffE1A303),
                                      //       fontWeight: FontWeight.w600, fontSize: 12.0)),
                                      // )
                                    ],
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                        (flag ? '₹' : '\$') +
                                            (Com().roundToDecimals(
                                                double.parse(item.price!), 8)),
                                        style: TextStyle(
                                            color:item.type == OrderTypes.SELL.name? Colors.red:  Color(0xff0E8730),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.0)),
                                  )
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${parsedDate.day}/${parsedDate.month}/${parsedDate.year} ${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}",
                                      style: TextStyle(
                                          color: Color(0xff959595),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11.0)),
                                  Text(item.txId!,
                                      style: TextStyle(
                                          color: Color(0xff959595),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11.0))
                                ],
                              ),
                              height5Space,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item.symbol!,
                                      style: TextStyle(
                                          color: Color(0xff959595),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11.0)),
                                  Text(item.type!,
                                      style: TextStyle(
                                          color:item.type == OrderTypes.SELL.name? Colors.red:  Color(0xff0E8730),
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
                                Text(
                                    'RQty: ${Com().roundToDecimals(double.parse(item.qty!), 6)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.0,
                                        color: Colors.white)),
                                GestureDetector(
                                    onTap: () {
                                      Com().commonDialog(
                                          context, "Cancel Order", () {
                                        cancel(item, index);
                                      });
                                    },
                                    child: Icon(Icons.delete_outline,
                                        color: Colors.white)),
                                Text(
                                    'O.Price.: ${Com().roundToDecimals(double.parse(item.orderPrice!), 6)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.0,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
  }

  getPlacedOrderEntries(String searchTerm, String type, String searchFilter,
      String page, String status) {
    Map<String, dynamic> body = {
      "page": page,
      "status": status,
      "searchTerm": searchTerm,
      "searchFilter": searchFilter,
      "type": type
    };
    setState(() {
      isPlacedLoading = true;
    });
    apiCalls.getUserPlacedOrderEntries(body, context).then((value) {
      if (mounted) {
        setState(() {
          totalCount = (value / 10).ceil();
        });
      }
    });
  }

  cancel(OrderSchedulerStruct item, int index) {
    Map<String, dynamic> body = {
      "page": page,
      "status": '',
      "searchTerm": '',
      "searchFilter": Filters.None.name,
      "type": OrderStatus.Canceled.name
    };
    Navigator.pop(context);
    setState(() {
      selectedOrder = item;
      deleteIndex = index;
      placedOrders.removeAt(index);
    });
    LoadingOverlay.showLoader(context);
    apiCalls.cancelUserOrder({"orderId": item.uniqueId!}, context);
    apiCalls.getUserCancelOrderEntries(body, context);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
