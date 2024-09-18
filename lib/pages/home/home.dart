import 'dart:async';
import 'dart:io';

import 'package:cryptox/api/announcement/getAnnouncements/getAnnouncements.dart';
import 'package:cryptox/api/banner/getBanner/getBanner.dart';
import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/api/notification/getAllUserNotifications/getAllNotifications.dart';
import 'package:cryptox/api/wallet/userWallet/userWallets.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/api.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/portfolio/cryptoAction.dart';
import 'package:cryptox/pages/screens.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:cryptox/widget/column_builder.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:marquee/marquee.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skeletons/skeletons.dart';
import 'package:cryptox/pages/alerts/notification.dart' as notify;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/check_internet_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamSubscription coinSubscription;
  late StreamSubscription walletSubscription;
  late StreamSubscription bannerSubscription;
  late StreamSubscription announceSubscription;
  late StreamSubscription notifySubscription;
  Timer? apiTimer;
  String totalEst = "0";
  String name = "";
  List<CoinListings> coins = [];
  List<CoinListings> marketCoins = [];
  List<BannerStruct> bannerList = [];
  List<CoinListings> userSavedCoins = [];
  List<Wallet> wallets = [];
  bool isLoading = true;
  bool loggedIn = false;
  int activeNotification = 0;
  List<AnnouncementStruct> announce = [];
  GainerLoserPopular selectedMarket = GainerLoserPopular.POPULAR;

  @override
  void initState() {

    super.initState();
    getUserName().then((value) {
      setState(() {
        name = value;
      });
    });
    checkLoggedIn().then((value) {
      setState(() {
        loggedIn = value;
      });
      if (value) {
        getValueForKey(mobileTokenKey).then((value) {
          if (value != KeyNotFound) {
            apiCalls
                .updateUserMobileToken({"token": value.toString()}, context);
          }
        });
        apiCalls.getUserNotification(context).then((it) {
          if (it) {
            apiTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
              print("Print after half seconds");
              if (!apiCalls.walletSubject$.isClosed) {
                apiTimer!.cancel();
                if (mounted) {
                  apiCalls.getUserWallet(context).then((value) {});
                }
              }
            });
          }
        });
      }
    });
    coinSubscription = apiCalls.allCoinsSubject$.listen((value) {
      if (value is String) {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        return;
      }
      if (value is List<CoinListings>) {
        if (mounted)
          setState(() {
            coins = value;
            marketCoins = value;

            isLoading = false;
          });
      }
    });
    walletSubscription = apiCalls.walletSubject$.listen((value) {
      if (value is String) {
        // showToast("Failed to load wallets.", gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      if (value is List<Wallet>) {
        if (mounted)
          setState(() {
            if (loggedIn) {
              wallets = value;

              totalEst = calculateTotalEst(wallets);
            }
          });
      }
    });
    bannerSubscription = apiCalls.banner$.listen((value) {
      if (value is List<BannerStruct>) {
        if (mounted)
          setState(() {
            bannerList = value;
          });
      }
    });
    announceSubscription = apiCalls.announcement$.listen((value) {
      if (value is String) {
        return;
      }
      if (value is List<AnnouncementStruct>) {
        if (mounted)
          setState(() {
            announce = value;
          });
      }
    });
    notifySubscription = apiCalls.notification$.listen((value) {
      if (value is List<MobileNotificationsStruct> && mounted) {
        setState(() {
          activeNotification = value.length;
        });
      }
    });
    apiCalls.getAllBanner("30", context);
    apiCalls.getAllAnnouncement(context);
  }

  @override
  void dispose() {
    super.dispose();
    coinSubscription.cancel();
    walletSubscription.cancel();
    bannerSubscription.cancel();
    announceSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          topBar(),
          announcement(),
          heightSpace,
          if (bannerList.isNotEmpty) carouselSlider(),
          height20Space,
          balanceContainer(),
          height20Space,
          if (wallets.isNotEmpty && loggedIn)
            Column(
              children: [
                myPortfolio(),
                height20Space,
              ],
            ),
          isLoading
              ? Container(height: 600, child: SkeletonListView())
              : popularCurrency(),
        ],
      ),
    );
  }

  Widget carouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 140.0,
        // aspectRatio: 16/9,
        viewportFraction: 0.92,
        // enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
      ),
      items: bannerList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  i.imgUrl!,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  topBar() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              loggedIn
                  ? apiCalls.changeIndex$.add(4)
                  : Navigator.pushNamed(context, '/login');
            },
            borderRadius: BorderRadius.circular(15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                'assets/Images/coinExcha_full.png',
                width: 100.0,
                height: 30.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              // GestureDetector(
              //     onTap: () {
              //       loggedIn ? Navigator.pushNamed(context, '/help_and_support') :
              //       Navigator.pushNamed(context, '/login');
              //     },
              //     child: Icon(Icons.headset_mic, color: primaryColor2,size: 30)
              // ),
              // SizedBox(width: 10),
              GestureDetector(
                  onTap: () {
                    loggedIn
                        ? Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: notify.Notification()))
                        : Navigator.pushNamed(context, '/login');
                  },
                  child: Stack(
                    children: [
                      if (activeNotification != 0)
                        Positioned(
                            top: 0,
                            right: 0,
                            // child: Text(activeNotification.toString(),
                            child: Text('',
                                style: TextStyle(
                                    fontSize: 8,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600))),
                      Icon(Icons.notifications, color: primaryColor2, size: 30),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  balanceContainer() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.size,
                alignment: Alignment.center,
                child: CryptoAction()));
      },
      child: Container(
        padding: EdgeInsets.all(fixPadding * 2.0),
        margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          // color: primaryColor,
          gradient: Com.barGradient(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BALANCE',
              style: TextStyle(
                  color: whiteColor, fontWeight: FontWeight.w600, fontSize: 16),
            ),
            heightSpace,
            Text(
              '\$ ' + Com().roundToDecimals(double.parse(totalEst), 6),
              style: white36BoldTextStyle1,
            ),
          ],
        ),
      ),
    );
  }

  myPortfolio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: fixPadding * 2.0,
            right: fixPadding * 2.0,
            bottom: fixPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Wallet',
                style: black16SemiBoldTextStyle,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/crypto_action');
                },
                child: Text(
                  'More >>',
                  style: black14SemiBoldTextStyle,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 150.0,
          child: ListView.builder(
            itemCount: wallets.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = wallets[index];
              var search = coins.where((element) =>
                  element.symbol!
                      .toUpperCase()
                      .replaceFirst(FiatType.INR.name, "")
                      .replaceFirst(FiatType.USDT.name, "") ==
                  item.currency!.toUpperCase());

              CoinListings entry = search.isEmpty
                  ? CoinListings(
                      closePrice:
                          item.currency == FiatType.USDT.name ? inrVal : 0.0,
                      symbol: FiatType.INR.name)
                  : (search.length > 1 ? search.last : search.first);
              double bal = (entry.closePrice ?? 0) *
                  (double.parse(item.balance ?? "0.0") -
                      double.parse(item.freezeAmount ?? "0.0"));

              return Padding(
                padding: (index != wallets.length - 1)
                    ? EdgeInsets.only(left: fixPadding * 2.0)
                    : EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Container(
                    width: wallets.length == 1 ? 310 : 260.0,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Com.tokenImage(
                                imageUrl:
                                    'assets/Images/${item.currency!.toLowerCase().replaceFirst("inr", "")}.png'),
                            widthSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.currency!.toUpperCase(),
                                  style: black16MediumTextStyle,
                                ),
                                widthSpace,
                                Text(
                                  '(${(double.parse(item.balance ?? "0.0") - double.parse(item.freezeAmount ?? "0.0")).toString()})',
                                  style: black16MediumTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Portfolio',
                              style: grey16MediumTextStyle,
                            ),
                            heightSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "\$" +
                                      (item.currency == FiatType.USDT.name
                                          ? (double.parse(item.balance!) -
                                                  double.parse(
                                                      item.freezeAmount!))
                                              .toString()
                                          : Com().roundToDecimals(bal, 6)),
                                  style: black22BoldTextStyle1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    (entry.ticker == 'up')
                                        ? Icon(
                                            Icons.arrow_drop_up,
                                            size: 26.0,
                                            color: primaryColor,
                                          )
                                        : Icon(
                                            Icons.arrow_drop_down,
                                            size: 26.0,
                                            color: redColor,
                                          ),
                                    Text(
                                      '${((entry.ticker == 'up') ? '+' : '')}${entry.percentageChange == null ? "0" : (entry.ticker == 'up' && entry.percentageChange!.contains('-')) ? entry.percentageChange!.replaceFirst('-', '') : entry.percentageChange}',
                                      style: (entry.ticker == 'up')
                                          ? primaryColor16MediumTextStyle
                                          : red16MediumTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String calculateTotalEst(List<Wallet> wallets) {
    double total = 0.0;
    wallets.forEach((ele) {
      if (ele.currency == FiatType.USDT.name) {
        double bal =
            double.parse(ele.balance!) - double.parse(ele.freezeAmount!);
        total = bal + total;
      } else {
        total = (ele.total ?? 0.0) + total;
      }
    });

    return total.toString();
  }

  popularCurrency() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Top Performers',
                style: black16SemiBoldTextStyle,
              ),
            ],
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, top: 6.0, bottom: 6.0, right: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      changeMarketState(
                          GainerLoserPopular.POPULAR, coins.sublist(0, 11));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: selectedMarket == GainerLoserPopular.POPULAR
                            ? primaryColor
                            : Colors.transparent,
                      ),
                      child: Text("Trending",
                          style: TextStyle(
                              color:
                                  selectedMarket == GainerLoserPopular.POPULAR
                                      ? whiteColor
                                      : Colors.black26,
                              fontWeight: FontWeight.w700,
                              fontSize: 13)),
                    ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      changeMarketState(
                          GainerLoserPopular.GAINER, coins.sublist(12, 24));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: selectedMarket == GainerLoserPopular.GAINER
                            ? primaryColor
                            : Colors.transparent,
                      ),
                      child: Text("Gainers",
                          style: TextStyle(
                              color: selectedMarket == GainerLoserPopular.GAINER
                                  ? whiteColor
                                  : Colors.black26,
                              fontWeight: FontWeight.w700,
                              fontSize: 13)),
                    ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      changeMarketState(
                          GainerLoserPopular.LOSER, coins.sublist(25, 36));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: selectedMarket == GainerLoserPopular.LOSER
                            ? primaryColor
                            : Colors.transparent,
                      ),
                      child: Text("Losers",
                          style: TextStyle(
                              color: selectedMarket == GainerLoserPopular.LOSER
                                  ? whiteColor
                                  : Colors.black26,
                              fontWeight: FontWeight.w700,
                              fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onHorizontalDragEnd: (DragEndDetails drag) {
                if (drag.primaryVelocity == null) return;
                if (drag.primaryVelocity! < 0) {
                  // drag from right to left
                  dragRTL();
                } else {
                  // drag from left to right
                  dragLTR();
                }
              },
              child: ColumnBuilder(
                itemCount: marketCoins.take(12).length,
                itemBuilder: (context, index) {
                  final item = marketCoins[index];
                  bool flag = item.symbol!.endsWith(FiatType.USDT.name);
                  return Padding(
                    padding: (index != (marketCoins.take(12).length - 1))
                        ? EdgeInsets.fromLTRB(
                            fixPadding, fixPadding, fixPadding, 0.0)
                        : EdgeInsets.all(fixPadding),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.size,
                                alignment: Alignment.center,
                                child: CoinView(
                                    coin: item,
                                    fiatType:
                                        flag ? FiatType.USDT : FiatType.INR)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
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
                            Com.tokenImage(imageUrl: item.imgUrl ?? ''),
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
                                      RichText(
                                        text: TextSpan(
                                          text: flag
                                              ? item.symbol!.replaceFirst(
                                                  FiatType.USDT.name, "")
                                              : item.symbol!.replaceFirst(
                                                  FiatType.INR.name, ""),
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: blackColor,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat'),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: flag ? '/USDT' : '/INR',
                                                style: black8w500TextStyle),
                                          ],
                                        ),
                                      ),
                                      height5Space,
                                      Text(
                                          'Vol: ' +
                                              Com().formatNumber(double.parse(
                                                  item.volume ?? "0.0")),
                                          style: TextStyle(
                                              color: Color(0xFF0C0C0C80)
                                                  .withOpacity(0.58),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12))
                                    ],
                                  ),
                                  Spacer(),
                                  selectedMarket == GainerLoserPopular.POPULAR
                                      ? Column(
                                          children: [
                                            Text(
                                              (flag ? "\$" : "₹") +
                                                  Com().roundToDecimals(
                                                      item.closePrice!, 6),
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: blackColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            height5Space,
                                            Container(
                                              decoration: BoxDecoration(
                                                color: (item.ticker == 'up')
                                                    ? greenColor
                                                    : redColor,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              width: 65,
                                              padding: EdgeInsets.all(5.0),
                                              child: Center(
                                                child: Text(
                                                  ((item.ticker == 'up')
                                                          ? '+'
                                                          : '-') +
                                                      double.parse(item
                                                              .percentageChange!
                                                              .replaceFirst(
                                                                  "-", ""))
                                                          .toStringAsFixed(3) +
                                                      "%",
                                                  style: TextStyle(
                                                      color: whiteColor,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : selectedMarket ==
                                              GainerLoserPopular.GAINER
                                          ? Column(
                                              children: [
                                                Text(
                                                  (flag ? "\$" : "₹") +
                                                      Com().roundToDecimals(
                                                          item.closePrice!, 6),
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    color: blackColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                height5Space,
                                                Container(
                                                  width: 80,
                                                  // height: 20,
                                                  padding: EdgeInsets.all(6.0),
                                                  decoration: BoxDecoration(
                                                      color: greenColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Center(
                                                    child: Text(
                                                      '+' +
                                                          double.parse(item
                                                                  .percentageChange!
                                                                  .replaceFirst(
                                                                      "-", ""))
                                                              .toStringAsFixed(
                                                                  3) +
                                                          "%",
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Text(
                                                  (flag ? "\$" : "₹") +
                                                      Com().roundToDecimals(
                                                          item.closePrice!, 6),
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    color: blackColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                height5Space,
                                                Container(
                                                  width: 80,
                                                  // height: 15,
                                                  padding: EdgeInsets.all(6.0),
                                                  decoration: BoxDecoration(
                                                      color: redColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Center(
                                                    child: Text(
                                                      '-' +
                                                          double.parse(item
                                                                  .percentageChange!
                                                                  .replaceFirst(
                                                                      "-", ""))
                                                              .toStringAsFixed(
                                                                  3) +
                                                          "%",
                                                      style: TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ],
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
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget announcement() {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: primaryColor2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 100,
              height: 50,
              child: Stack(
                children: [
                  SvgPicture.asset('assets/svg/newsSide.svg',
                      semanticsLabel: 'news', fit: BoxFit.fill),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text("NEWS",
                            style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.w700)),
                      ))
                ],
              )),
          Expanded(
            child: GestureDetector(
                onTap: () async {
                  await launchUrl(Uri.parse(announcementsUrl));
                },
                child: announcementStruct(announce.isNotEmpty
                    ? announce[0].title!
                    : "1fx Updates!!!")),
          ),
        ],
      ),
    );
  }

  Widget announcementStruct(String val) {
    return Container(
      alignment: Alignment.center,
      child: Marquee(
        text: val,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: whiteColor, fontSize: 12),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        blankSpace: 20.0,
        velocity: 50.0,
        pauseAfterRound: Duration(seconds: 1),
        startPadding: 15.0,
        accelerationDuration: Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }

  changeMarketState(GainerLoserPopular val, List<CoinListings> coins) {
    setState(() {
      if (val == GainerLoserPopular.POPULAR) {
        coins.sort((a, b) => double.parse(b.volume ?? "0.0")
            .compareTo(double.parse(a.volume ?? "0.0")));
      } else if (val == GainerLoserPopular.GAINER) {
        coins.sort((a, b) =>
            double.parse((b.percentageChange ?? "0.0").replaceAll('-', ""))
                .compareTo(double.parse(
                    (a.percentageChange ?? "0.0").replaceAll('-', ""))));
      } else {
        coins.sort((a, b) => double.parse(a.percentageChange ?? "0.0")
            .compareTo(double.parse(b.percentageChange ?? "0.0")));
      }
      selectedMarket = val;
      marketCoins =
          coins.where((element) => (element.symbol!.length < 10)).toList();
    });
  }

  dragRTL() {
    switch (selectedMarket) {
      case GainerLoserPopular.GAINER:
        changeMarketState(GainerLoserPopular.LOSER, coins);
        break;
      case GainerLoserPopular.LOSER:
        break;
      case GainerLoserPopular.POPULAR:
        changeMarketState(GainerLoserPopular.GAINER, coins);
        break;
    }
  }

  dragLTR() {
    switch (selectedMarket) {
      case GainerLoserPopular.GAINER:
        changeMarketState(GainerLoserPopular.POPULAR, coins);
        break;
      case GainerLoserPopular.LOSER:
        changeMarketState(GainerLoserPopular.GAINER, coins);
        break;
      case GainerLoserPopular.POPULAR:
        break;
    }
  }
}
