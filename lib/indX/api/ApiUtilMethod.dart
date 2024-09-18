import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../routes/AppRoutes.dart';
import '../themes/ThemeColor.dart';
import '../utils/DialogBuilder.dart';

import 'TypeActions.dart';

enum ApiUtiMethod {
  INSTANCE;


  void handleError(Object obj, Function? callback) {
    if (obj.runtimeType == DioError) {
      DioError dioError = (obj as DioError);
      if (dioError.error is SocketException ||
          dioError.error is TimeoutException) {
        if (callback != null) {
          callback(
              TypeActions.INSTANCE.NETWROK_ERROR, dioError.message.toString());
        }
      } else if (dioError.type == DioErrorType.connectTimeout ||
          /*dioError.type == DioErrorType.connectionError ||*/
          dioError.type == DioErrorType.receiveTimeout ||
          dioError.type == DioErrorType.sendTimeout) {
        if (callback != null) {
          callback(
              TypeActions.INSTANCE.NETWROK_ERROR, dioError.message.toString());
        }
      } else {
        if (callback != null) {
          if (dioError.response != null) {
            if (dioError.response!.statusCode == 401) {
              DialogBuilder.INSTANCE.hideOpenDialog();
              dialogAuthExpired(dioError.response!.statusMessage.toString());
            } else {
              if (dioError.response?.data != null &&
                  dioError.response?.data["responseText"] != null) {
                callback(TypeActions.INSTANCE.ERROR,
                    dioError.response?.data["responseText"]);
              } else if (dioError.response?.data != null &&
                  dioError.response?.data["message"] != null) {
                callback(TypeActions.INSTANCE.ERROR,
                    dioError.response?.data["message"]);
              } else {
                callback(
                    TypeActions.INSTANCE.ERROR,
                    ("${dioError.response!.statusCode}\n${dioError.response!.statusMessage}"));
              }
            }
          } else {
            callback(TypeActions.INSTANCE.ERROR, dioError.error.toString());
          }
        }
      }
    } else {
      if (callback != null) {
        callback(TypeActions.INSTANCE.ERROR, obj.toString());
      }
    }
  }

  void dialogAuthExpired(String title) {
    Get.defaultDialog(
        barrierDismissible: false,
        title: title,
        titlePadding: const EdgeInsets.only(top: 18),
        contentPadding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        middleText: "Session has been expired, Please Login again.",
        middleTextStyle: const TextStyle(
            fontFamily: 'poppins',
            wordSpacing: 2,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w900),
        cancel: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(Get.overlayContext!).pop();
                GetStorage().erase();
               Get.offAllNamed(AppRoutes.login);
              },
              style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius:  BorderRadius.circular(30.0),
                          side: const BorderSide(color: green_2)))),
              child: const Text(
                "Login",
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: green_2,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              )),
        ));
  }
}
