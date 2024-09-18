import 'package:cryptox/constant/api.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyWeb extends StatefulWidget {
  const PrivacyPolicyWeb({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyWeb createState() => _PrivacyPolicyWeb();
}


class _PrivacyPolicyWeb extends State<PrivacyPolicyWeb> {

  WebViewController controllerWebView = WebViewController.fromPlatformCreationParams(const PlatformWebViewControllerCreationParams());
  @override
  void initState() {
    controllerWebView = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00FFFFFF))
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) async {
          await launchUrl(Uri.parse(request.url),mode: LaunchMode.externalApplication);
          return NavigationDecision.prevent;
        },
        /*onPageStarted: (url) {

        },
        onWebResourceError: (error) {

        },
        onPageFinished: (url) {

        },*/
      ))
      ..loadRequest(Uri.parse(privacyPolicyUrl));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0.0,
        title: Text(
          'Privacy Policy',
          style: white16SemiBoldTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: WebViewWidget(controller: controllerWebView),
    );
  }
}






