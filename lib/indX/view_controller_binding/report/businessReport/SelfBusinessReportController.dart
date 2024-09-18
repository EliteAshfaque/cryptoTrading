import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/TypeActions.dart';
import '../../../api/model/login/LoginResponse.dart';
import '../../../api/model/report/ReportData.dart';
import '../../../utils/DialogBuilder.dart';
import '../../../utils/Utility.dart';
import '../ReportApi.dart';

class SelfBusinessReportController extends GetxController {

  ReportApi api = ReportApi();
  LoginResponse loginResponse =Get.find();
  var searchBusinessList = <ReportData>[].obs;
  List<ReportData> businessList = <ReportData>[];
  var isApiCalled=false.obs;
  TextEditingController searchController = TextEditingController(text: "");

  @override
  void onInit() async{
    super.onInit();
    await getBusinessReport(false);
  }




  Future<void> getBusinessReport(bool isFromClick) async {
    if(isFromClick){
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Business Report ...', isCancelabel: false);}
    await api.getSelfBusinessReport(isFromClick, loginResponse.data!, (action, response) async {
      if(isFromClick){DialogBuilder.INSTANCE.hideOpenDialog();}
      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        businessList.clear();
        searchBusinessList.clear();
        businessList.addAll(response);
        searchBusinessList.value=businessList;
      }else if (action == TypeActions.INSTANCE.ERROR) {
        searchBusinessList.value = <ReportData>[];
        businessList = <ReportData>[];
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