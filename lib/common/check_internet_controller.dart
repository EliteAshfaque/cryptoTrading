import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/coins/allCoins/allCoins.dart';

class CheckInternetController extends GetxService {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      _showSnackbar(
        message: "Please Connect to Internet",
        backgroundColor: Colors.black,
        icon: CupertinoIcons.wifi,
        duration: Duration(days: 1),
      );
    } else {


      _showSnackbar(
        message: "Connected to Internet",
        backgroundColor: Colors.green,
        icon: CupertinoIcons.check_mark,
        duration: Duration(seconds: 2),
      );

      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  void _showSnackbar({
    required String message,
    required Color backgroundColor,
    required IconData icon,
    required Duration duration,
  }) {
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      isDismissible: true,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      margin: EdgeInsets.all(30),
      backgroundColor: backgroundColor,
      duration: duration,
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}
