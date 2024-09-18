import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../api/TypeActions.dart';
import '../../../api/model/BasicRequest.dart';
import '../../../api/model/login/LoginResponse.dart';
import '../../../api/model/stakeNow/StakeHistory.dart';
import '../../../common/ConstantString.dart';
import '../../../utils/DialogBuilder.dart';
import '../../../utils/Utility.dart';
import '../StakeNowApi.dart';

class StakeReportController extends GetxController {

  StakeNowApi api = StakeNowApi();
  PackageInfo packageInfo = Get.find();
  LoginResponse loginResponse =Get.find();
  var searchReportList = <StakeHistory>[].obs;
  List<StakeHistory> reportList = <StakeHistory>[];
  var isApiCalled=false.obs;

  TextEditingController searchController = TextEditingController(text: "");

  @override
  void onInit() async{
    super.onInit();


    await getReport(false);


  }






  Future<void> getReport(bool isFromClick) async {
    if(isFromClick){
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting History ...', isCancelabel: false);}
    await api.getReport(BasicRequest(
        loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID), (action, response) async {
      if(isFromClick){DialogBuilder.INSTANCE.hideOpenDialog();}
      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {

        reportList.addAll(response);
        searchReportList.value=reportList;
      }else if (action == TypeActions.INSTANCE.ERROR) {
       // Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }


@override
  void dispose() {
  searchController.dispose();


    super.dispose();
  }



}