import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/market/savedCoins.dart';
import 'package:cryptox/pages/market/searchCoins.dart';
import 'package:cryptox/pages/screens.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> with TickerProviderStateMixin {

  ValueNotifier<bool> _notifier = ValueNotifier(false);
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Coins List',
          style: black16SemiBoldTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.size,
                      alignment: Alignment.center,
                      child: SearchCoins()));
            },
            icon: Icon(
              Icons.search,
              color: primaryColor,
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: primaryColor, width: 6.0),
            // insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
          ),
          tabs: [
            Tab(icon: Icon(Icons.star,color: blackColor,size: 14)),
            Tab(icon: Com().tabBarTextDesign(FiatType.USDT.name)),
            Tab(icon: Com().tabBarTextDesign(FiatType.BNB.name)),
            Tab(icon: Com().tabBarTextDesign(FiatType.ETH.name)),
            Tab(icon: Com().tabBarTextDesign(FiatType.BTC.name)),
            // Tab(icon: Com().tabBarTextDesign(FiatType.ONEFX.name)),
          ],
        ),
      ),
      // body: AllCurrency(notifier: _notifier),
      body: TabBarView(
        controller: tabController,
        // physics: NeverScrollableScrollPhysics(),
        children: [
          SavedCoins(),
          AllCurrency(notifier: _notifier, fiatType: FiatType.USDT),
          AllCurrency(notifier: _notifier, fiatType: FiatType.BNB),
          AllCurrency(notifier: _notifier, fiatType: FiatType.ETH),
          AllCurrency(notifier: _notifier, fiatType: FiatType.BTC),
          // AllCurrency(notifier: _notifier, fiatType: FiatType.ONEFX),
        ],
      )
    );
  }

}
