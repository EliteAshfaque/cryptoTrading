import 'dart:async';

import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/coinDetails/main_view.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SearchCoins extends StatefulWidget {
  @override
  _SearchCoins createState() => _SearchCoins();
}

class _SearchCoins extends State<SearchCoins> {
  List<CoinListings> coins = [];
  List<CoinListings> searchedCoins = [];
  TextEditingController searchController = new TextEditingController();
  final commonWidget = Com();
  bool searchObs = false;
  bool resFind = false;
  late StreamSubscription coinSubscription;

  @override
  void initState() {
    super.initState();
    coinSubscription = apiCalls.allCoinsSubject$.listen((value) {
      if (value is String) {
        return;
      }
      if (value is List<CoinListings>) {
        if (kDebugMode) {
          print("LENGTH " + value.length.toString());
        }
        setState(() {
          coins = value;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    print("DISPOSE CALLED ");
    coinSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          titleSpacing: 0.0,
          title: TextFormField(
            autofocus: true,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: TextInputType.text,
            controller: searchController,
            onChanged: (val) {
              searchBoxValChange(val);
            },
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      searchController.clear();
                      searchedCoins = [];
                    });
                  },
                  child: Icon(Icons.cancel_outlined,
                      color: Colors.white, size: 22.0)),
              hintText: "search...",
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: whiteColor,
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
        body: searchedCoins.length == 0
            ? Center(child: Text(resFind ? 'Not Found...' : 'Search coins...'))
            : ListView.builder(
                itemCount: searchedCoins.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = searchedCoins[index];
                  FiatType fiat = item.symbol!.endsWith(FiatType.INR.name)
                      ? FiatType.INR
                      : FiatType.USDT;
                  return Padding(
                    padding: (index != searchedCoins.length - 1)
                        ? EdgeInsets.fromLTRB(fixPadding * 2.0,
                            fixPadding * 2.0, fixPadding * 2.0, 0.0)
                        : EdgeInsets.all(fixPadding * 2.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.size,
                                alignment: Alignment.center,
                                child: CoinView(coin: item, fiatType: fiat)));
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: EdgeInsets.all(fixPadding),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              color: blackColor.withOpacity(0.05),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Com.tokenImage(imageUrl: item.imgUrl!),
                            widthSpace,
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.symbol!
                                                .replaceFirst(fiat.name, "") +
                                            '/${fiat.name}',
                                        style: black14MediumTextStyle,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          (item.ticker == 'up')
                                              ? Icon(
                                                  Icons.arrow_drop_up,
                                                  color: greenColor,
                                                )
                                              : Icon(
                                                  Icons.arrow_drop_down,
                                                  color: redColor,
                                                ),
                                          Text(
                                            item.percentageChange!,
                                            style: TextStyle(
                                                color: item.ticker == 'up'
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontSize: 12.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    (fiat == FiatType.INR ? "₹" : "\$") +
                                        item.closePrice!.toStringAsFixed(3),
                                    style: black16MediumTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }

  dummyValidator(String val) {
    return null;
  }

  searchBoxValChange(String val) {
    if (kDebugMode) {
      print("VAL " + val);
    }
    searchedCoins = coins;
    List<CoinListings> li = searchedCoins
        .where((element) =>
            element.symbol!.toLowerCase().contains(val.toLowerCase()))
        .toList();
    print("SEARCH " + li.length.toString());
    setState(() {
      searchedCoins = li;
      resFind = li.length == 0;
    });
  }
}
