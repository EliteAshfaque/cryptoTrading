import 'dart:async';

import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/coinDetails/coinAppDrawer/coinAppDrawerCard.dart';
import 'package:cryptox/pages/screens.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoinAppDrawer extends StatefulWidget {
  final FiatType fiatType;

  CoinAppDrawer({Key? key, required this.fiatType})
      : super(key: key);

  @override
  _CoinAppDrawer createState() => _CoinAppDrawer();
}

class _CoinAppDrawer extends State<CoinAppDrawer> {

  List<CoinListings> coins = [];
  List<CoinListings> dummyCoins = [];
  final commonWidget = Com();
  TextEditingController searchController = new TextEditingController();
  late StreamSubscription coinSubscription;
  late StreamSubscription coinSocketSubscription;

  @override
  void initState() {
    super.initState();
    coinSubscription = apiCalls.allCoinsSubject$.listen((value) {
      if (value is String) {
        setState(() {
          // isLoading = false;
        });
        return;
      }
      if (value is List<CoinListings>) {
        value = value
            .where((element) => element.symbol!.endsWith(widget.fiatType.name))
            .toList();
        if(!mounted) return;
        setState(() {
          coins = value;
          dummyCoins = coins;
          // isLoading = false;
        });
        // coinSocket();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Column(
        children: [
          heightSpace,
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
          Expanded(
            child: StreamBuilder(
              stream: apiCalls.commonCoinSocket$,
              builder: (context, snapshot) {
                var data = snapshot.data;
                if(data is CoinListings) {
                  int index = coins.indexWhere((element) => element.symbol == data.symbol);
                  if (index != -1) {
                      coins[index] = data;
                  }
                }
                return ListView.builder(
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
                                    CoinView(coin: item, fiatType: widget.fiatType),
                              ));
                        },
                        child: CoinAppDrawerCard(fiatType: widget.fiatType,item: item)
                      );
                    });
              },
            )
          ),
        ],
      ),
    );
  }

  changePrice(CoinListings value) {
    int index = coins.indexWhere((element) => element.symbol == value.symbol);
    if (index != -1) {
      if (!mounted) return;
      setState(() {
        coins[index] = value;
      });
    }
  }

  searchBoxValChange(String val) {
    coins = dummyCoins;
    List<CoinListings> li = coins
        .where((element) =>
        element.symbol!.toLowerCase().contains(val.toLowerCase()))
        .toList();
    setState(() {
      coins = li;
    });
  }
}
