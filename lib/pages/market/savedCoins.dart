import 'dart:async';

import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';

class SavedCoins extends StatefulWidget {
  @override
  _SavedCoins createState() => _SavedCoins();
}

class _SavedCoins extends State<SavedCoins> {

  List<CoinListings> coins = [];
  StreamSubscription? usdtSubscription;
  StreamSubscription? commonSocketSubscription;


  @override
  void initState() {
    super.initState();
    getUserSavedList().then((value) {
      if(value.length != 0) {
        if(mounted)
          setState(() {
            coins = value;
          });
      }
    });
    openSocketsToUpdateCoin();
  }

  @override
  void dispose() {
    super.dispose();
    if(usdtSubscription != null) {
      usdtSubscription!.cancel();
    }
    if(commonSocketSubscription != null) {
      commonSocketSubscription!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: coins.isEmpty ? Center(child: Icon(Icons.do_not_disturb_alt_sharp,size: 120,
        color: Colors.black12)) : ListView.builder(
        itemCount: coins.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = coins[index];
          return Com().coinCard(index,item,context,coins.length);
        },
      ),
    );
  }

  openSocketsToUpdateCoin() {
    commonSocketSubscription = apiCalls.commonCoinSocket$.listen((value) {
        int savedListIndex = coins.indexWhere((element) => element.symbol == value.symbol);
        setState(() {
          if(savedListIndex != -1) {
            coins[savedListIndex] = value;
            updateCoinLocally(value).then((value) => value);
          }
        });
    });
  }

}