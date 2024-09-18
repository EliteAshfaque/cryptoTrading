import 'dart:async';

import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/api/coins/orderBook/orderBook.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/common/orderBookSocket.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';

class OrderBook extends StatefulWidget {

  final CoinListings coin;
  final Function openModalSheet;
  final FiatType fiatType;
  final bool loggedIn;
  const OrderBook({Key? key,required this.coin, required this.openModalSheet,
    required this.fiatType, required this.loggedIn}) : super(key: key);

  @override
  _OrderBook createState() => _OrderBook();

}

class _OrderBook extends State<OrderBook> with AutomaticKeepAliveClientMixin<OrderBook>  {

  AllOrderResponse allOrders = new AllOrderResponse();
  bool isLoading = true;
  double buyMax = 0.0;
  double sellMax = 0.0;
  OrderBookSocket? socket;
  StreamSubscription? orderBookSubscription;

  @override
  void initState() {
    super.initState();
    orderBookSubscription = apiCalls.orderBookSubject$.listen((value) {
      if(value is AllOrderResponse) {
        if(mounted)
          setState(() {
            allOrders.buy = value.buy;
            allOrders.sell = value.sell;
            if(allOrders.buy!.length > 0) {
              double max = 0.0;
              allOrders.buy!.forEach((element) {
                if(element.totalQty! > max) {
                  max = element.totalQty!;
                }
              });
              buyMax = max / 100.0;
            }
            if(allOrders.sell!.length > 0) {
              double max = 0.0;
              allOrders.sell!.forEach((element) {
                if(element.totalQty! > max) {
                  max = element.totalQty!;
                }
              });
              sellMax = max / 100;
            }
          });
      }
      if(mounted) {
        setState(() {
          isLoading = false;
        });
      }
      LoadingOverlay.hideLoader(context);
    });
    socket = OrderBookSocket(coin: widget.coin, fiatType: widget.fiatType);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    if(orderBookSubscription != null) {
      orderBookSubscription!.cancel();
    }
    if(socket != null) {
      print("SOCKET CLOSED");
      socket!.disposeOrderBookSocket();
    }
    // apiCalls.orderBookSubject$.drain().then((value) {
    //   apiCalls.orderBookSubject$.close();
    // });
    // apiCalls.orderBookSubject$.close();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return isLoading ? Text("") : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width / 2 - 8,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Volume", style: TextStyle( color: Colors.grey)),
                  Text("Buy 🡫", style: TextStyle(color: Colors.green))
                ],
              ),
              height5Space,
              Expanded(
                child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: allOrders.buy!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var ele = allOrders.buy![index];
                        double price = double.parse(ele.price!.toString());
                        return GestureDetector(
                          onTap: () {
                            buySellClicked(index, true);
                          },
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 33,
                                    width: ((ele.totalQty! / buyMax) + 50),
                                    decoration: BoxDecoration(
                                      //borderRadius: BorderRadius.circular(20),
                                      color: Color(0xffc7ebd1),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(Com().formatNumber(ele.totalQty!),
                                        style: TextStyle(fontWeight: FontWeight.bold,)),
                                    Text(price > 5000.0 ? price.toStringAsFixed(5)
                                        : price.toStringAsFixed(7), style: TextStyle(color: Colors.green))
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  ),
              ),
            ],
          ),
        ),
        Container(
          width: width / 2 - 8,
          padding: EdgeInsets.only(right: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sell", style: TextStyle(color: Colors.red)),
                  Text("Volume", style: TextStyle(color: Colors.grey))
                ],
              ),
              height5Space,
              Expanded(
                child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: allOrders.sell!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var ele = allOrders.sell![index];
                        double price = double.parse(ele.price!.toString());
                        return GestureDetector(
                          onTap: () {
                            buySellClicked(index, false);
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 33,
                                width: ((ele.totalQty! / sellMax) + 50),
                                decoration: BoxDecoration(
                                  //borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffebc9c7),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(price > 5000.0 ? price.toStringAsFixed(5)
                                        : price.toStringAsFixed(7),
                                        style: TextStyle(color: Colors.red)),
                                    Text(Com().formatNumber(ele.totalQty!),
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  ),
              ),
            ],
          ),
        )
      ],
    );
  }

  buySellClicked(int index, bool flag) {
    if(!widget.loggedIn) {
      return;
    }
    double totalPrice = 0;
    double qtyTotal = 0;
    double price = flag ? double.parse(allOrders.buy![index].price) :
      double.parse(allOrders.sell![index].price);
    if(flag) {
      for (int i = 0; i <= index; i++) {
        double total = double.parse(allOrders.buy![i].price) * allOrders.buy![i].totalQty!;
        qtyTotal = qtyTotal + allOrders.buy![i].totalQty!;
        totalPrice = totalPrice + total;
      }
    }else {
      for (int i = 0; i <= index; i++) {
        double total = double.parse(allOrders.sell![i].price) * allOrders.sell![i].totalQty!;
        qtyTotal = qtyTotal + allOrders.sell![i].totalQty!;
        totalPrice = totalPrice + total;
      }
    }
    widget.openModalSheet(flag ? OrderTypes.SELL : OrderTypes.BUY,price,totalPrice,qtyTotal);
  }

}