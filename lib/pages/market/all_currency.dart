import 'dart:async';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/services.dart';
import 'package:skeletons/skeletons.dart';
import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:flutter/material.dart';

class AllCurrency extends StatefulWidget {
  final ValueNotifier<bool>? notifier;
  final FiatType fiatType;

  const AllCurrency({Key? key, this.notifier, required this.fiatType})
      : super(key: key);

  @override
  _AllCurrencyState createState() => _AllCurrencyState();
}

class _AllCurrencyState extends State<AllCurrency> {

  List<CoinListings> coins = [];
  List<CoinListings> dummyCoins = [];
  final commonWidget = Com();
  TextEditingController searchController = new TextEditingController();
  bool searchObs = false;
  bool isLoading = true;
  bool showSearchBar = false;
  late StreamSubscription coinSubscription;
  StreamSubscription? coinSocketSubscription;

  @override
  void initState() {
    super.initState();
    coinSubscription = apiCalls.allCoinsSubject$.listen((value) {
      if (value is String) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      if (value is List<CoinListings>) {
        value = value.where((element) => element.symbol!.endsWith(widget.fiatType.name))
            .toList();
        setState(() {
          coins = value;
          dummyCoins = coins;
          isLoading = false;
        });
        coinSocket();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    print("DISPOSE CALLED ");
    coinSubscription.cancel();
    if (coinSocketSubscription != null)
      coinSocketSubscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SkeletonListView()
        : Column(children: [
            if (widget.notifier!.value)
              Container(
                margin: EdgeInsets.only(top: 12.0),
                child: commonWidget.inputBoxDesign(
                    Icons.search,
                    searchController,
                    "search",
                    dummyValidator,
                    searchObs,
                    false,
                    () => {},
                    TextInputType.text,
                    searchBoxValChange,
                    10.0,
                    10.0),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: coins.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = coins[index];
                  return Com().coinCard(index,item,context, coins.length);
                },
              ),
            ),
          ]);
  }

  coinSocket() {
    coinSocketSubscription = apiCalls.commonCoinSocket$.listen((data) {
      int index = coins.indexWhere((element) => element.symbol == data.symbol);
      if (!mounted || index == -1) return;
      setState(() {
        coins[index] = data;
      });
      // updateCoinLocally(coins[index]);
    });
  }

  dummyValidator(String val) {
    return null;
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
