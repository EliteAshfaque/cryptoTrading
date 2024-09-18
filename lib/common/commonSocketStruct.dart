import 'dart:async';
import 'dart:convert';

import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/api.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CoinListingSocketStruct {
  late StreamSubscription coinSubscription;
  late StreamSubscription channelSubscription;
  Stream<dynamic>? channel;
  FiatType? selectedFiat;
  PublishSubject<CoinListings>? tokenSocket;
  List<CoinListings> coins = [];

  CoinListingSocketStruct(
      {required this.tokenSocket, required this.selectedFiat}) {
    this.connectToSocket();
    coinSubscription = apiCalls.allCoinsSubject$.listen((value) async {
      if (value is String) {
        return;
      }
      if (value is List<CoinListings>) {
        this.coins = value;
        this.coinSocket();
        coinSubscription.cancel().then((value) {});
      }
    });
    if (this.selectedFiat == FiatType.USDT) {
      apiCalls.getCoins();
    }
  }

  disposeCoinSocket() async {
    channelSubscription.cancel().then((value) {});
    connectToSocket();
    await Future.delayed(Duration(milliseconds: 5000));
    coinSocket();
  }

  connectToSocket() async {
    bool flag = await channel?.isEmpty ?? false;
    if (flag || channel == null) {
      channel = WebSocketChannel.connect(
        Uri.parse(coinSocketUrl),
      ).stream.asBroadcastStream();
    }
  }

  void coinSocket() {
    if (channel == null) {
      print("WebSocket channel is not initialized.");
      return;
    }

    channelSubscription = channel!.listen((message) {  // Use `channel!` to assert that it's non-null
      var data = jsonDecode(message);
      int index = coins.indexWhere((element) => element.symbol == data['s']);
      if (index == -1) {
        return;
      }
      if (data['c'] != null && data['c'].toString().isNotEmpty) {
        double newPrice = double.parse(data['c'].toString());
        double oldPrice = coins[index].closePrice!;
        CoinListings listing = coins[index];
        listing.ticker = newPrice > oldPrice ? "up" : "down";
        listing.volume = data["v"].toString();
        listing.closePrice = newPrice;
        listing.percentageChange = data["P"].toString();
        updateCoinLocally(listing);
        tokenSocket?.add(listing);  // Use null-aware operator for `tokenSocket`
      }
    }, onError: (err) async {
      print("SOCKET ERROR: ${err.toString()}");
      await disposeCoinSocket();
    }, onDone: () async {
      print('Closing Socket');
      await disposeCoinSocket();
    });
  }
}
