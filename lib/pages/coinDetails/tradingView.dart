import 'package:cryptox/util/Enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../api/coins/allCoins/allCoins.dart';
import '../../constant/constant.dart';

class TradingView extends StatefulWidget {
  final CoinListings coin;
  final FiatType fiatType;

  const TradingView({Key? key, required this.coin, required this.fiatType})
      : super(key: key);

  @override
  _TradingView createState() => _TradingView();
}

class _TradingView extends State<
    TradingView> /* with AutomaticKeepAliveClientMixin<TradingView>*/ {
  //final GlobalKey webViewKey = GlobalKey();

  //bool showChart = false;
  //InAppWebViewController? webViewController;
  WebViewController controllerWebView =
      WebViewController.fromPlatformCreationParams(
          const PlatformWebViewControllerCreationParams());

  @override
  // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => true;

  @override
  void initState() {
    controllerWebView = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00FFFFFF))
      ..clearCache()
      /*..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          return NavigationDecision.prevent;
        },
        onPageStarted: (url) {

        },
        onWebResourceError: (error) {

          print(error.description);
        },

        onPageFinished: (url) {

        },


      ))*/
      ..loadRequest(
          Uri.parse(
              "https://1fx.app/assets/index.html?symbol=${widget.coin.symbol!}"),
          headers: {"mode": "no-cors", 'Access-Control-Allow-Origin': '*'});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tradingViewChart(),
    );
  }

  tradingViewWebView() {
    return WebViewWidget(controller: controllerWebView);
  }

  /*tradingViewWebView() {
    return InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(
            url: Uri.parse('https://1fx.in/assets/index.html?symbol=${widget.coin.symbol!}'),
            headers: {"mode": "no-cors", 'Access-Control-Allow-Origin': '*'}),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
          clearCache: true,
        )),
        onLoadStart: (controller, url) async {
          setState(() {});
        },
        onLoadStop: (controller, url) async {
          setState(() {});
        },
        onConsoleMessage: (controller, consoleMessage) {
          if (kDebugMode){print(consoleMessage);}
        });
  }*/

  tradingViewChart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height20Space,
        Expanded(
          child: tradingViewWebView(),
        ),
      ],
    );
  }
}
