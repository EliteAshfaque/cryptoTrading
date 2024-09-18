import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/Utility.dart';


class TCPPController extends GetxController {


  String title =Get.arguments[0];
  String url =Get.arguments[1];
  var isError=false.obs;
  var isDataLoaded=false.obs;
  WebViewController webViewController = WebViewController.fromPlatformCreationParams(const PlatformWebViewControllerCreationParams());
  @override
  void onInit() async{
    super.onInit();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00FFFFFF))
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          Utility.INSTANCE.urlLaunch(request.url);
          return NavigationDecision.prevent;
        },
        onPageStarted: (url) {
          isDataLoaded.value=false;
          isError.value=false;
        },
        onWebResourceError: (error) {
          isError.value=true;
        },

        onPageFinished: (url) {
            isDataLoaded.value = true;
        },


      ))
      ..loadRequest(Uri.parse(url));
  }







}