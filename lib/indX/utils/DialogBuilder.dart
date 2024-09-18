import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/LoadingIndicator.dart';

enum DialogBuilder {

  INSTANCE;

  void showLoadingIndicator(String heading, String msg, {bool? isCancelabel=true}) {
    Get.dialog(
      barrierDismissible: isCancelabel??true,
      WillPopScope(
          onWillPop: () async => isCancelabel??true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: LoadingIndicator(
                  heading: heading,
                  text: msg,
                  textColor: Colors.black,
                ),
              ),
            ],
          )),
    );
  }

  void hideOpenDialog() {
    if(Get.isDialogOpen==true) {
      Get.back();
    }
  }
}
