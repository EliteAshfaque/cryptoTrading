import 'dart:async';
import 'dart:convert';

import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/api/coins/orderBook/orderBook.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/api.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OrderBookSocket {

  late StreamSubscription orderBookSubscription;
  late StreamSubscription coinSubscription;
  Stream<dynamic>? channel;
  CoinListings selectedCoin = CoinListings();
  FiatType? selectedFiatType;
  List<CoinListings> coins = [];

  OrderBookSocket({required CoinListings coin, required FiatType fiatType}) {
    selectedCoin = coin;
    selectedFiatType = fiatType;
    this.connectToSocket();
    coinSubscription = apiCalls.allCoinsSubject$.listen((value) async {
      if (value is String) {
        return;
      }
      if (value is List<CoinListings>) {
        this.coins = value;
        this.orderBookSocket();
        coinSubscription.cancel().then((value) {});
      }
    });
  }

  connectToSocket() async {
    bool flag = await channel?.isEmpty ?? false;
    if(flag || channel == null) {
      channel = selectedCoin.listed == 1 ? WebSocketChannel.connect(
        Uri.parse(order_book_socket_url + 'symbol=${selectedCoin.symbol}'),
      ).stream.asBroadcastStream() : WebSocketChannel.connect(
        Uri.parse(binance_order_book_socket_url + '${selectedCoin.symbol!
            .replaceAll(FiatType.INR.name, FiatType.USDT.name).toLowerCase()}'+'@depth20@1000ms'),
      ).stream.asBroadcastStream();
    }
  }

  orderBookSocket() {
    //print("HELLO ORDER BOOK ");
    AllOrderResponse allOrders = new AllOrderResponse();
    orderBookSubscription = channel!.listen((it) {
      var message = jsonDecode(it);
      List<OrderResponse> buyArr = [];
      List<OrderResponse> sellArr = [];
      bool flag = selectedCoin.listed == 1;
      for (int i = 0; i < message['bids'].length; i++) {
        flag ? buyArr.add(OrderResponse(price: message['bids'][i][0].toString(),
            totalQty: double.parse(message['bids'][i][1]))) :
        buyArr.add(OrderResponse(price: (double.parse(message['bids'][i][0])
            * (selectedFiatType == FiatType.INR ? inrVal : 1 )).toString(),
            totalQty: double.parse(message['bids'][i][1])));
      }
      for (int i = 0; i < message['asks'].length; i++) {
        flag ? sellArr.add(OrderResponse(price: message['asks'][i][0],
            totalQty: double.parse(message['asks'][i][1]))) :
        sellArr.add(OrderResponse(price: (double.parse(message['asks'][i][0])
            * (selectedFiatType == FiatType.INR ? inrVal : 1 )).toString(),
            totalQty: double.parse(message['asks'][i][1])));
      }
      allOrders = AllOrderResponse(buy: buyArr,sell: sellArr);
      apiCalls.orderBookSubject$.add(allOrders);
    },onError: (err) async {
      print("ORDER BOOK SOCKET ERROR "+err.toString());
      await disposeAndReconnectBookSocket();
    },onDone: () async {
      print('CLOSING ORDER BOOK SOCKET');
      await disposeAndReconnectBookSocket();
    });
  }

  disposeOrderBookSocket() async {
    orderBookSubscription.cancel().then((value) {
      print("ORDER BOOK SOCKET CLOSED ");
    });
  }

  disposeAndReconnectBookSocket() async {
    orderBookSubscription.cancel().then((value) {});
    print("ORDER BOOK SOCKET CLOSED ");
    connectToSocket();
    await Future.delayed(Duration(milliseconds: 5000));
    orderBookSocket();
  }


}