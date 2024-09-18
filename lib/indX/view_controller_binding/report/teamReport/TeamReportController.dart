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

class TeamReportController extends GetxController {

  ReportApi api = ReportApi();
  LoginResponse loginResponse =Get.find();
  var searchTeamList = <ReportData>[].obs;
  List<ReportData> teamList = <ReportData>[];
  var isApiCalled=false.obs;
  var leg= Get.arguments;
  List<String> legList=["All Team","Left Team","Right Team"];
  TextEditingController searchController = TextEditingController(text: "");
  var filterLeg= "".obs;
  @override
  void onInit() async{
    super.onInit();
    filterLeg.value=leg;
    await getTotalTeam(false);

  }



  Future<void> getTotalTeam(bool isFromClick) async {
    if(isFromClick){
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Account Statement ...', isCancelabel: false);}
    await api.getTotalTeam(isFromClick, filterLeg.value, loginResponse.data!, (action, response) async {
      if(isFromClick){DialogBuilder.INSTANCE.hideOpenDialog();}
      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        teamList.clear();
        searchTeamList.clear();
        teamList.addAll(response);
        searchTeamList.value=teamList;
      }else if (action == TypeActions.INSTANCE.ERROR) {
         searchTeamList.value = <ReportData>[];
         teamList = <ReportData>[];
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