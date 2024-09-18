import 'dart:async';

import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/coinDetails/coinAppDrawer/coinAppDrawerCard.dart';
import 'package:cryptox/pages/coinDetails/main_view.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SavedCoinsAppBar extends StatefulWidget {
  @override
  _SavedCoinsAppBar createState() => _SavedCoinsAppBar();
}

class _SavedCoinsAppBar extends State<SavedCoinsAppBar> {

  List<CoinListings> coins = [];
  List<CoinListings> coinListingList = [];
  List<CoinListings> dummyCoins = [];
  final commonWidget = Com();
  TextEditingController searchController = new TextEditingController();
  late StreamSubscription coinSubscription;
  StreamSubscription? usdtSubscription;
  StreamSubscription? commonSocketSubscription;

  @override
  void initState() {
    super.initState();
    getUserSavedList().then((value) {
      if (kDebugMode){print("VALUE IN SAVED COIN "+value.length.toString());}
      if(value.length != 0) {
        if(mounted)
          setState(() {
            coins = value;
          });
      }
    });
    coinSubscription = apiCalls.allCoinsSubject$.listen((value) async {
      if (value is String) {
        // setState(() {
        //   // isLoading = false;
        // });
        return;
      }
      if (value is List<CoinListings>) {
        if(!mounted) return;
        // List<CoinListings> li = value.where((element) => element.symbol! == usdtInr).toList();
        // List<CoinListings> list = coins.where((element) => element.symbol == usdtInr).toList();
        // if(li.isNotEmpty && list.isEmpty)  {
        //   await alterUserCoinList(li[0]);
        // }
        setState(()  {
          coinListingList = value;
          dummyCoins = value;
          // if(li.isNotEmpty && list.isEmpty)  {
          //     coins.add(li[0]);
          // }
        });
        // coinSocket();
      }
    });
    openSocketsToUpdateCoin();
  }

  @override
  void dispose() {
    super.dispose();
    coinSubscription.cancel();
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
          color: Colors.black12)) : Column(
            children: [
              height20Space,
                commonWidget.textFieldBoxLayout(TextFormField(
                  style: black14MediumTextStyle,
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  validator: (val) {
                    return null;
                  },
                  onChanged: searchBoxValChange,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20.0),
                    hintText: "Search",
                    hintStyle: black14MediumTextStyle,
                    border: InputBorder.none,
                  ),
                ),0.0,0.0),
              heightSpace,
                searchController.text.isEmpty ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: coins.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = coins[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    CoinView(coin: item, fiatType: Com.checkFiatType(item.symbol!)),
                              ));
                        },
                        child: CoinAppDrawerCard(
                            fiatType: Com.checkFiatType(item.symbol!),
                            item: item),
                      );
                    },
                  ),
                ) : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: coinListingList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = coinListingList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    CoinView(coin: item, fiatType: Com.checkFiatType(item.symbol!)),
                              ));
                        },
                        child: CoinAppDrawerCard(
                            fiatType: Com.checkFiatType(item.symbol!),
                            item: item),
                      );
                      // return Com().coinCard(index, item, context, coins.length);
                    },
                  ),
                ),
              ],
          ),
    );
  }

  searchBoxValChange(String val) {
    // print("VBJBJ "+val);
    coinListingList = dummyCoins;
    List<CoinListings> li = coinListingList
        .where((element) =>
        element.symbol!.toLowerCase().contains(val.toLowerCase()))
        .toList();
    setState(() {
      coinListingList = li;
    });
  }

  openSocketsToUpdateCoin() {
    commonSocketSubscription = apiCalls.commonCoinSocket$.listen((value) {
        int mainListIndex = searchController.text.isEmpty ? -1 :
            coinListingList.indexWhere((element) => element.symbol == value.symbol);
        int savedListIndex = searchController.text.isEmpty ? coins.indexWhere((element) => element.symbol
            == value.symbol) : -1;
        setState(() {
          if(mainListIndex != -1) {
            coinListingList[mainListIndex] = value;
            updateCoinLocally(value).then((value) => value);
          }
          if(savedListIndex != -1) {
            coins[savedListIndex] = value;
            updateCoinLocally(value).then((value) => value);
          }
        });
    });
  }

}