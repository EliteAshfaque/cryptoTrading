import 'dart:async';

import 'package:cryptox/api/Order/placeOrder/placeOrder.dart';
import 'package:cryptox/api/coins/allCoins/allCoins.dart';
import 'package:cryptox/api/coins/orderBook/orderBook.dart';
import 'package:cryptox/api/wallet/userWallet/userWallets.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/coinDetails/orderBook.dart';
import 'package:cryptox/pages/coinDetails/tradeHistory.dart';
import 'package:cryptox/pages/coinDetails/tradingView.dart';
import 'package:cryptox/pages/screens.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:cryptox/util/SliderButton.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/util/models.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class CoinView extends StatefulWidget {
  CoinListings coin;
  final FiatType fiatType;

  CoinView({Key? key, required this.coin, required this.fiatType})
      : super(key: key);

  @override
  _CoinViewState createState() => _CoinViewState();
}

class _CoinViewState extends State<CoinView>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  List<Wallet> wallets = [];
  Wallet? fiatWallet;
  TabController? _tabController;
  String selectedSymbolWalletBal = "0";
  final GlobalKey webViewKey = GlobalKey();
  AllCurrency allCurrency = new AllCurrency(fiatType: FiatType.INR);
  bool scroll = true;
  bool watchlist = false;
  bool loggedIn = false;
  final priceController = TextEditingController();
  final amountController = TextEditingController(text: "0");
  final totalController = TextEditingController(text: "0");
  AllOrderResponse allOrders = new AllOrderResponse();
  final sellValueController = TextEditingController();
  final sellAmountController = TextEditingController();
  late StreamSubscription orderBookSubscription;
  late StreamSubscription userOrderSubscription;
  late StreamSubscription walletSubscription;
  late StreamSubscription coinSubscription;
  late StreamSubscription volumeSubscription;
  int decimals = 8;
  int val = 0;

  @override
  void initState() {
    super.initState();
    getUserSavedList().then((value) {
      if (value.length == 0) {
        return;
      }
      int index =
          value.indexWhere((element) => element.symbol == widget.coin.symbol);
      if (index != -1) {
        setState(() {
          watchlist = true;
        });
      }
    });
    priceController.value = TextEditingValue(
        text: Com().roundToDecimals(widget.coin.closePrice!, decimals));

    _tabController = new TabController(vsync: this, length: 6);

    // Calling order book data...
    apiCalls.getOrderBookData(widget.coin.symbol!, widget.fiatType.name);

    walletSubscription = apiCalls.walletSubject$.listen((value) {
      if (value is String) {
        // showToast("Failed to load wallets.",
        //     gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        return;
      }
      if (value is List<Wallet>) {
        if (mounted)
          setState(() {
            wallets = value;
            var wallet = value
                .where((element) => element.currency == widget.fiatType.name)
                .toList();
            if (wallet.length > 0) {
              fiatWallet = wallet[0];
            } else {
              fiatWallet = Wallet(balance: "0", freezeAmount: "0");
            }
            var arr = value
                .where((element) =>
                    widget.coin.symbol!.startsWith(element.currency ?? ""))
                .toList();
            if (arr.length > 0) {
              selectedSymbolWalletBal = Com().roundToDecimals(
                  ((double.parse(arr[0].balance!) -
                      double.parse(arr[0].freezeAmount!))),
                  decimals);
            }
          });
      }
    });
    checkLoggedIn().then((value) {
      if (value) {
        apiCalls.getUserWallet(context);
        setState(() {
          loggedIn = value;
        });
      }
    });
    orderBookSubscription = apiCalls.orderBookSubject$.listen((value) {
      if (value is AllOrderResponse) {
        if (mounted)
          setState(() {
            allOrders.buy = value.buy;
            allOrders.sell = value.sell;
          });
      }
    });
    userOrderSubscription = apiCalls.userOrder$.listen((value) {
      if (kDebugMode) {
        print("MAIN VIEW PLACE ORDER " + value.toString());
      }
      LoadingOverlay.hideLoader(context);
      Navigator.pop(context);
      apiCalls.getUserWallet(context);
      if (value is PlaceOrderStruct) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.topToBottom,
            child: BuySuccessScreen(placedOrder: value),
          ),
        );
      }
    });
    coinSubscription = apiCalls.commonCoinSocket$.listen((value) {
      if (value.symbol == widget.coin.symbol && mounted) {
        setState(() {
          widget.coin = value;
        });
      }
    });
    volumeSubscription = apiCalls.last24HourVolume$.listen((value) {
      if (value == "") {
        return;
      }
      setState(() {
        widget.coin.volume = value.toString();
      });
    });
    if (widget.coin.listed == 1) {
      apiCalls.last24HourVolume(context, widget.coin.symbol!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    orderBookSubscription.cancel();
    userOrderSubscription.cancel();
    walletSubscription.cancel();
    priceController.value = TextEditingValue(text: "0");
    coinSubscription.cancel();
    volumeSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        key: _scaffoldState,
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Com().appDrawer(changeTabState, _tabController!, val),
            // child: CoinAppDrawer(fiatType: FiatType.USDT)
          ),
        ),
        backgroundColor: scaffoldBgColor,
        bottomNavigationBar: loggedIn
            ? Material(
                elevation: 2.0,
                child: Container(
                  height: 50.0,
                  width: width,
                  color: primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          buySellBottomSheet(OrderTypes.BUY);
                          priceController.value = TextEditingValue(
                              text: Com().roundToDecimals(
                                  widget.coin.closePrice!, decimals));
                          amountController.text = "0";
                          moveCursorToEnd(amountController);
                          totalController.text = "0";
                          moveCursorToEnd(totalController);
                        },
                        child: Container(
                          color: Colors.green,
                          height: 50.0,
                          width: (width - 1.0) / 2,
                          alignment: Alignment.center,
                          child: Text(
                            'Buy'.toUpperCase(),
                            style: white16BoldTextStyle,
                          ),
                        ),
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: whiteColor.withOpacity(0.5),
                      ),
                      InkWell(
                        onTap: () {
                          buySellBottomSheet(OrderTypes.SELL);
                          priceController.value = TextEditingValue(
                              text: Com().roundToDecimals(
                                  widget.coin.closePrice!, decimals));
                          amountController.text = "0";
                          moveCursorToEnd(amountController);
                          totalController.text = "0";
                          moveCursorToEnd(totalController);
                        },
                        child: Container(
                          color: Colors.red,
                          height: 50.0,
                          width: (width - 1.0) / 2,
                          alignment: Alignment.center,
                          child: Text(
                            'Sell'.toUpperCase(),
                            style: white16BoldTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Text(""),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(fixPadding * 1.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back),
                        ),
                        IconButton(
                          onPressed: () {
                            _scaffoldState.currentState!.openDrawer();
                          },
                          icon: Icon(Icons.add_chart),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${widget.coin.symbol!.replaceFirst(widget.fiatType.name, "")}',
                                  style: black16BoldTextStyle,
                                ),
                                Text(
                                  '/${widget.fiatType.name}',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Text(
                                'Vol: ${Com().roundToDecimals(double.parse(widget.coin.volume!), decimals)}',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        widthSpace,
                        InkWell(
                          onTap: () async {
                            int flag = await alterUserCoinList(widget.coin);
                            if (kDebugMode) {
                              print(flag);
                            }
                            if (flag == 1) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Added to watchlist.'),
                              ));
                              setState(() {
                                watchlist = true;
                              });
                            } else if (flag == 2) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Remove from watchlist.'),
                              ));
                              setState(() {
                                watchlist = false;
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('Error while adding to watchlist.'),
                              ));
                              setState(() {
                                watchlist = false;
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(18.0),
                          child: Container(
                            width: 35.0,
                            height: 35.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              border: Border.all(
                                width: 0.6,
                                color: primaryColor.withOpacity(0.6),
                              ),
                            ),
                            child: Icon(
                              (watchlist) ? Icons.star : Icons.star_border,
                              size: 24.0,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 1.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // cleanSharedPrefsKey(userSavedCoinList);
                      },
                      child: Container(
                        height: 56.0,
                        width: 56.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(
                            width: 0.8,
                            color: greyColor.withOpacity(0.5),
                          ),
                        ),
                        child: Com.tokenImage(imageUrl: widget.coin.imgUrl!),
                      ),
                    ),
                    widthSpace,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current ${widget.coin.symbol!.replaceFirst(widget.fiatType.name, "")} Buy Price',
                          style: black14RegularTextStyle,
                        ),
                        height5Space,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (widget.fiatType == FiatType.INR ? "₹" : "\$") +
                                  Com().roundToDecimals(
                                      widget.coin.closePrice!, decimals),
                              style: black18SemiBoldTextStyle,
                            ),
                            widthSpace,
                            (widget.coin.ticker == 'up')
                                ? Icon(
                                    Icons.arrow_drop_up,
                                    color: greenColor,
                                  )
                                : Icon(
                                    Icons.arrow_drop_down,
                                    color: redColor,
                                  ),
                            Text(
                              widget.coin.percentageChange!,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: widget.coin.ticker == 'up'
                                    ? Colors.green
                                    : redColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              height5Space,
              DefaultTabController(
                  length: 3,
                  child: Expanded(
                    child: Column(
                      children: [
                        TabBar(indicatorColor: primaryColor, tabs: [
                          Tab(text: "Chart"),
                          Tab(text: "Order"),
                          Tab(text: "Trade"),
                        ]),
                        Expanded(
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              TradingView(
                                  coin: widget.coin, fiatType: widget.fiatType),
                              OrderBook(
                                  coin: widget.coin,
                                  openModalSheet: openModalSheet,
                                  fiatType: widget.fiatType,
                                  loggedIn: loggedIn),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.0, right: 16.0, top: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Price",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        Text("Volume",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        Text("Time",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                  TradeHistory(
                                      coin: widget.coin,
                                      fiatType: widget.fiatType)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  openModalSheet(
      OrderTypes type, double price, double totalPrice, double qtyTotal) {
    setState(() {
      priceController.text = Com().roundToDecimals(price, decimals);
      amountController.text = Com().roundToDecimals(qtyTotal, decimals);
      totalController.text = Com().roundToDecimals(totalPrice, decimals);
    });
    buySellBottomSheet(type);
  }

  changeTabState(int value) {
    setState(() {
      val = value;
    });
  }

  void buySellBottomSheet(OrderTypes type) {
    var symbol = widget.coin.symbol!.replaceFirst(widget.fiatType.name, "");
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // set this to true
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        double width = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width,
                          alignment: Alignment.center,
                          child: Text(
                            '${type.name.toUpperCase()} $symbol (${widget.fiatType.name})',
                            style: black14SemiBoldTextStyle,
                          ),
                        ),
                        height20Space,
                        Container(
                          width: double.infinity,
                          height: 0.7,
                          color: greyColor.withOpacity(0.4),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: fixPadding * 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 56.0,
                                width: 56.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  border: Border.all(
                                    width: 0.8,
                                    color: greyColor.withOpacity(0.5),
                                  ),
                                ),
                                child: Com.tokenImage(
                                    imageUrl: widget.coin.imgUrl!),
                              ),
                              widthSpace,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current $symbol ${type.name.toLowerCase()} Price',
                                    style: black14RegularTextStyle,
                                  ),
                                  height5Space,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        Com().roundToDecimals(
                                            widget.coin.closePrice!, decimals),
                                        style: black18SemiBoldTextStyle,
                                      ),
                                      widthSpace,
                                      Icon(
                                        Icons.arrow_drop_up,
                                        size: 26.0,
                                        color: primaryColor,
                                      ),
                                      Text(
                                        widget.coin.percentageChange!,
                                        style: primaryColor16MediumTextStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Enter Value Textfield
                        Theme(
                          data: ThemeData(
                            primaryColor: greyColor,
                          ),
                          child: TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            inputFormatters: Com.validateField(),
                            style: black16RegularTextStyle,
                            onChanged: (val) {
                              qtyPriceChange(priceController, amountController,
                                  OrderTypes.BUY);
                            },
                            maxLength: 20,
                            decoration: InputDecoration(
                              counterText: "",
                              labelText: 'Price',
                              labelStyle: black16RegularTextStyle,
                              suffix: Text(
                                widget.fiatType.name,
                                style: black16RegularTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 0.7),
                              ),
                            ),
                          ),
                        ),

                        height20Space,

                        // Amount TextField
                        Theme(
                          data: ThemeData(
                            primaryColor: greyColor,
                          ),
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: Com.validateField(),
                            style: black16RegularTextStyle,
                            onChanged: (val) {

                              qtyPriceChange(priceController, amountController,
                                  OrderTypes.BUY);
                            },
                            maxLength: 15,
                            decoration: InputDecoration(
                              counterText: "",
                              labelText: 'Quantity',
                              labelStyle: black16RegularTextStyle,
                              suffix: Text(
                                symbol,
                                style: black16RegularTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 0.7),
                              ),
                            ),
                          ),
                        ),
                        height20Space,

                        // Total TextField
                        Theme(
                          data: ThemeData(
                            primaryColor: greyColor,
                          ),
                          child: TextField(
                            inputFormatters: Com.validateWhiteSpace(
                                decimal: 8,
                                // You can specify the number of decimal places
                                regex: RegExp(
                                    r'[0-9.\s]') // Custom regex if needed
                                ),
                            controller: totalController,
                            keyboardType: TextInputType.number,
                            style: black16RegularTextStyle,
                            onChanged: (val) {
                              totalPriceChange(priceController, totalController,
                                  OrderTypes.BUY);
                            },
                            maxLength: 15,
                            decoration: InputDecoration(
                              /*enabled: false,*/
                              counterText: "",
                              labelText: 'Total',
                              labelStyle: black16RegularTextStyle,
                              suffix: Text(
                                widget.fiatType.name,
                                style: black16RegularTextStyle,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyColor, width: 0.7),
                              ),
                            ),
                          ),
                        ),
                        height5Space,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  percentageClick(25, type);
                                },
                                child: Text("25%",
                                    style: buySellPercentagesTextStyle)),
                            GestureDetector(
                                onTap: () {
                                  percentageClick(50, type);
                                },
                                child: Text("50%",
                                    style: buySellPercentagesTextStyle)),
                            GestureDetector(
                                onTap: () {
                                  percentageClick(75, type);
                                },
                                child: Text("75%",
                                    style: buySellPercentagesTextStyle)),
                            GestureDetector(
                                onTap: () {
                                  percentageClick(100, type);
                                },
                                child: Text("100%",
                                    style: buySellPercentagesTextStyle))
                          ],
                        ),
                        height20Space,
                        type == OrderTypes.BUY
                            ? Text("Available ${widget.fiatType.name}: "
                                "${widget.fiatType == FiatType.INR ? '₹' : '\$'} "
                                "${(double.parse(fiatWallet!.balance!) - double.parse(fiatWallet!.freezeAmount!)).toStringAsFixed(decimals)}")
                            : Text(
                                "Available $symbol: $selectedSymbolWalletBal"),
                        height5Space,
                        // SliderButton(label: "Slide to place Order",onSliderChanged: () => {placeOrder(type)})
                        // Buy Button
                        SliderButton(
                          action: () {
                            //print("SLIDE COMPLETE");
                            type == OrderTypes.BUY
                                ? placeOrder(OrderTypes.BUY)
                                : placeOrder(OrderTypes.SELL);
                          },
                          label: Text(
                            "Slide to place Order",
                            style: TextStyle(
                                color: Color(0xff4a4a4a),
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                          icon: Center(
                              child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 40.0,
                            //semanticLabel: 'Text to announce in accessibility modes',
                          )),
                          alignLabel: Alignment.center,
                          width: double.infinity,
                          height: 60,
                          radius: 20,
                          buttonColor: type == OrderTypes.BUY
                              ? Colors.green
                              : Colors.red,
                          backgroundColor: Color(0xfff4f7f2),
                          highlightedColor: Colors.white,
                          vibrationFlag: false,
                          dismissible: false,
                          // baseColor: Colors.red,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /*qtyPriceChange(TextEditingController _price, TextEditingController _volume,
      OrderTypes type) {
    if (_price.text == "" || _volume.text == "") {
      totalController.text ="0";
      return;
    }
    double price = double.parse(_price.text);
    double qty = double.parse(_volume.text);
    double mul = 0;
    if (type == OrderTypes.BUY) {
      List<OrderResponse> selectedArr = allOrders.sell!;
      if (selectedArr.length > 0) {

        for (OrderResponse it in selectedArr) {
          double processPrice = price > double.parse(it.price) ? double.parse(it.price) : price;
          double numVol = qty;
          double numQty = it.totalQty!;
          if (numVol > numQty) {
            mul = mul + (processPrice * numQty);
            qty = numVol - numQty;
          } else if (numVol < numQty) {
            mul = mul + (processPrice * numVol);
            qty = 0;
            break;
          } else {
            mul = mul + (processPrice * numVol);
            qty = 0;
            break;
          }
        }
        if (qty > 0) {
          mul = mul + (price * qty);
        }
      } else {
        if (qty > 0) {
          mul = mul + (price * qty);
        }
      }
      totalController.text = Com().roundToDecimals(mul, decimals);
    } else {
      List<OrderResponse> selectedArr = allOrders.buy!;
      if (selectedArr.length > 0) {
        for (OrderResponse it in selectedArr) {
          if(double.parse(it.price) >= price) {
            double numQty = it.totalQty!;
            double price = double.parse(it.price);
            if (qty > numQty) {
              mul = mul + (price * numQty);
              qty = qty - numQty;
            } else if (qty < numQty) {
              mul = mul + (price * qty);
              qty = 0;
              break;
            } else {
              mul = mul + (price * qty);
              qty = 0;
              break;
            }
          }
        }
        if (qty > 0) {
          mul = mul + (double.parse(_price.text) * qty);
        }
      }else {
        if (qty > 0) {
          mul = mul + (price * qty);
        }
      }
      totalController.text = Com().roundToDecimals(mul, decimals);
    }
  }*/
  qtyPriceChange(TextEditingController _price, TextEditingController _volume,
      OrderTypes type) {
    if (_price.text == "" || _volume.text == "") {
      totalController.text = "0";
      return;
    }
    double price = double.parse(_price.text);
    double qty = double.parse(_volume.text);
    double total = price * qty;
    totalController.text = Com().roundToDecimals(total, decimals);
  }

  totalPriceChange(TextEditingController _price, TextEditingController _total,
      OrderTypes type) {
    if (_price.text == "" || _total.text == "") {
      amountController.text = "0";
      return;
    }
    double price = double.parse(_price.text);
    double total = double.parse(_total.text);
    double qty = total / price;
    amountController.text = Com().roundToDecimals(qty, decimals);
  }

  percentageClick(int val, OrderTypes type) {
    if (priceController.text.isEmpty) return;
    double _fiatBalance = double.parse(fiatWallet!.balance!) -
        double.parse(fiatWallet!.freezeAmount!);
    double total = type == OrderTypes.BUY
        ? ((_fiatBalance * val) / 100)
        : ((double.parse(selectedSymbolWalletBal) * val) / 100);
    if (type == OrderTypes.BUY) {
      double selectedCoinPrice = double.parse(priceController.text);
      double qty = total / selectedCoinPrice;
      if (qty.toString().contains('e')) {
        qty = 0.0;
      }
      setState(() {
        amountController.text = Com().roundToDecimals(qty, decimals).toString();
        totalController.text =
            Com().roundToDecimals(total, decimals).toString();
      });
    } else {
      double price = double.parse(priceController.text) * total;
      if (total.toString().contains('e')) {
        total = 0.0;
      }
      setState(() {
        amountController.text =
            Com().roundToDecimals(total, decimals).toString();
        totalController.text =
            Com().roundToDecimals(price, decimals).toString();
      });
    }
  }

  moveCursorToEnd(TextEditingController controller) {
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
  }

  placeOrder(OrderTypes type) {
    // Navigator.pop(context);
    double total = double.parse(totalController.text);

    if (priceController.text.isEmpty ||
        double.parse(priceController.text) <= 0.0) {
      showToast('Check Price Field.',
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return;
    }
    double price = double.parse(priceController.text);
    if (amountController.text.isEmpty ||
        double.parse(amountController.text) <= 0.0) {
      showToast('Check Amount Field.',
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return;
    }
    // print('AMOUNT CONTROLLER ${amountController.text}');
    double volume = double.parse(amountController.text);
    if (volume.toString().contains('e')) {
      showToast('Quantity too low for processing');
      return;
    }
    if (type == OrderTypes.SELL) {
      if (double.parse(Com().roundToDecimals(volume, decimals)) >
          double.parse(Com().roundToDecimals(
              double.parse(selectedSymbolWalletBal), decimals))) {
        showToast(
            'InSufficient ${widget.coin.symbol!.toUpperCase().replaceFirst(widget.fiatType.name, "")} to place order.');
        return;
      }
    } else {
      double presentAmt = double.parse(fiatWallet?.balance ?? "0.0") -
          double.parse(fiatWallet?.freezeAmount ?? "0.0");
      if (double.parse(Com().roundToDecimals(total, 3)) >
          double.parse(Com().roundToDecimals(presentAmt, 3))) {
        showToast('InSufficient ${widget.fiatType.name} to place order.');
        return;
      }
    }

    List<OrderPlacingModel> arr = [];
    if (total == 0) {
      showToast('Total is 0.',
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return;
    }
    if (total < 0) {
      showToast('Total is negative.',
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return;
    }
    if (RegExp(r'/^\d*\.?\d*$/').hasMatch(volume.toString())) {
      showToast('Qty contains symbols other then numbers.',
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return;
    }
    if (RegExp(r'/^\d*\.?\d*$/').hasMatch(price.toString())) {
      showToast('Price contains symbols other then numbers.',
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return;
    }
    LoadingOverlay.showLoader(context);
    if (type == OrderTypes.BUY) {
      print('This is Executed here plese check');

      List<OrderResponse> selectedArr = allOrders.sell!;
      int entry = selectedArr
          .indexWhere((element) => price > double.parse(element.price));
      if (selectedArr.length > 0 && entry != -1) {
        for (OrderResponse it in selectedArr) {
          double numVol = volume;
          double numQty = it.totalQty!;
          double processPrice =
              price > double.parse(it.price) ? price : price;
          if (numVol > numQty) {
            var obj = OrderPlacingModel(
                price:   processPrice.toString(), qty: numQty.toString());
            arr.add(obj);
            volume = numVol - numQty;
          } else if (numVol < numQty) {

            var obj = OrderPlacingModel(
                price: double.parse(processPrice.toString()).toString(),
                qty: numVol.toString());
            arr.add(obj);
            volume = 0.0;
            break;
          } else {
            var obj = OrderPlacingModel(
                price: processPrice.toString(), qty: numVol.toString());
            arr.add(obj);
            volume = 0.0;
            break;
          }
        }
        if (volume > 0.000000) {
          var obj = OrderPlacingModel(
              price: price.toString(), qty: volume.toString());
          arr.add(obj);
        }
      } else {
        if (volume > 0) {
          var obj = OrderPlacingModel(
              price: price.toString(), qty: volume.toString());
          arr.add(obj);
        }
      }
    } else {
      List<OrderResponse> selectedArr = allOrders.buy!;
      if (selectedArr.length > 0) {
        for (OrderResponse it in selectedArr) {
          if (kDebugMode) {
            print("VOLUME $volume");
          }
          if (double.parse(it.price) >= price) {
            double numQty = it.totalQty!;
            double price = double.parse(it.price);
            if (volume > numQty) {
              var obj = OrderPlacingModel(
                  price: price.toString(), qty: numQty.toString());
              arr.add(obj);
              volume = volume - numQty;
              if (kDebugMode) {
                print("VOLUME 1 $volume");
              }
            } else if (volume < numQty) {
              var obj = OrderPlacingModel(
                  price: price.toString(), qty: volume.toString());
              arr.add(obj);
              if (kDebugMode) {
                print("VOLUME 2 $volume");
              }
              volume = 0.0;
              break;
            } else {
              var obj = OrderPlacingModel(
                  price: price.toString(), qty: numQty.toString());
              if (kDebugMode) {
                print("VOLUME 3 $volume");
              }
              arr.add(obj);
              volume = 0.0;
              break;
            }
          }
        }
        if (volume > 0.000000) {
          var obj = OrderPlacingModel(
              price: price.toString(), qty: volume.toString());
          arr.add(obj);
        }
      } else {
        if (volume > 0) {
          var obj = OrderPlacingModel(
              price: price.toString(), qty: volume.toString());
          arr.add(obj);
        }
      }
    }
    if (arr.length == 0) {
      showToast('Order Process format is empty.',
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      LoadingOverlay.hideLoader(context);
      return;
    }
    double totalPrice = 0.0;
    double totalQty = 0.0;
    arr.forEach((it) {
      totalPrice = totalPrice + double.parse(it.price);
      totalQty = totalQty + double.parse(it.qty);
    });
    double vol = double.parse(amountController.text);
    if (double.parse(Com().roundToDecimals(vol, decimals)) !=
        double.parse(Com().roundToDecimals(totalQty, decimals))) {
      showToast('Quantity Mismatch.',
          gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      LoadingOverlay.hideLoader(context);
      return;
    }
    var obj = {
      "symbol": widget.coin.symbol!.toUpperCase(),
      "orderFormat": arr,
      "totalQty": double.parse(amountController.text).toString(),
      "totalPrice": total.toString(),
      "type": type.name.toString()
    };
    print(obj);
    print('The obj is ====>>>> ${obj}');
    arr.forEach((element) {
      print(element.toJson());
    });
    apiCalls.createUserOrder(obj, context);
  }
}
