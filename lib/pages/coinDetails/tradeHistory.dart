import 'dart:convert';

import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/api/coins/tradeHistory/tradeHistory.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api/base.dart';
import '../../util/Enums.dart';

class TradeHistory extends StatefulWidget {

  final CoinListings coin;
  final FiatType fiatType;
  const TradeHistory({Key? key,required this.coin, required this.fiatType}) : super(key: key);

  @override
  _TradeHistory createState() => _TradeHistory();

}

class _TradeHistory extends State<TradeHistory> with AutomaticKeepAliveClientMixin<TradeHistory> {

  List<TradeHistoryStruct> allTrades = [];

  @override
  void initState() {
    super.initState();
    getTradeHistoryData();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allTrades.length,
              itemBuilder: (BuildContext context, int index) {
                var ele = allTrades[index];
                var parsedDate = DateTime.parse(ele.createdAt!).add(Duration(minutes: 330));
                //Color color = ele.colorBool! ? Color(0xff89e1c1) : Color(0xffee9ea6);
                Color color = ele.colorBool! ? Colors.green : Colors.red;
                return Container(
                  // color: ele.colorBool! ? Color(0xff89e1c1) : Color(0xffee9ea6),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(double.parse(ele.price!).toStringAsFixed(4), style: TextStyle(color: color,
                          fontWeight: FontWeight.w600)),
                        Text(double.parse(ele.qty!.toString()).toStringAsFixed(9),
                            style: TextStyle(color: color,fontWeight: FontWeight.w600)),
                        Text('${parsedDate.hour}: ${parsedDate.minute}: ${parsedDate.second}',
                            style: TextStyle(color: color,fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }


  Future getTradeHistoryData() async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      // LoadingOverlay.showLoader(context);
      var tradeData = await client.getTradeHistory(widget.coin.symbol!, widget.fiatType.name);
      if (kDebugMode){print(jsonEncode(tradeData));}
      if (tradeData.success) {
        setState(() {
          allTrades = (tradeData.result['message'] as List)
              .map((trades) {
            if (kDebugMode){print(trades);}
           return TradeHistoryStruct.fromJson(trades);
          }).toList();
        });
        if (kDebugMode){ print("TRADE HISTORY DATA " + allTrades.length.toString());}
      } else {
        showToast(tradeData.result['error'],
            gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      }
      // LoadingOverlay.hideLoader(context);
    } catch (e) {
      showToast(e.toString(),gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      //print("ERROR " + e.toString());
      // LoadingOverlay.hideLoader(context);
    }
  }

}