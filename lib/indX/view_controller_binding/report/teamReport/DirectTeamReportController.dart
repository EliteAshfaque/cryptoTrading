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

class DirectTeamReportController extends GetxController {

  ReportApi api = ReportApi();
  LoginResponse loginResponse =Get.find();
  var searchTeamList = <ReportData>[].obs;
  List<ReportData> teamList = <ReportData>[];
  var isApiCalled=false.obs;

  List<String> statusList=["All","Active","Deactive"];
  List<String> legList=["All","Left","Right"];

  var filterStatus= "All";
  var filterLeg= "All";
  var filterFromDate= "";
  var filterToDate= "";
  TextEditingController searchController = TextEditingController(text: "");
  final TextEditingController filterFromDateController = TextEditingController();
  final TextEditingController filterToDateController = TextEditingController();
  final TextEditingController filterLegController = TextEditingController(text: "All");
  final TextEditingController filterStatusController = TextEditingController(text: "All");
  var todayDate= DateTime.now();
  late DateTime pickedFromDate, pickedEndDate;

  @override
  void onInit() async{
    super.onInit();
    pickedFromDate=todayDate;
    pickedEndDate=todayDate;
    filterFromDate=Utility.INSTANCE.formatDate(todayDate);
    filterToDate=filterFromDate;
    filterFromDateController.text =filterFromDate ;
    filterToDateController.text=filterFromDate;
    await getDirectTeam(false);

  }



  Future<void> getDirectTeam(bool isFromClick) async {
    if(isFromClick){
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Team ...', isCancelabel: false);}
    await api.getDirectTeam(isFromClick, filterLeg=="Left"?"L":filterLeg=="Right"?"R":"All",
        filterFromDate,filterToDate,
        filterStatus=="Active"?"1":filterStatus=="Deactive"?"0":"All", loginResponse.data!, (action, response) async {
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
  filterFromDateController.dispose();
  filterToDateController .dispose();
  filterLegController .dispose();
  filterStatusController .dispose();

    super.dispose();
  }

  openFromDate(context) async {
    await Utility.INSTANCE.openCalender(context,DateTime(2023),pickedFromDate ,pickedEndDate,(value){
      if(value!=null) {
        pickedFromDate = value;
        filterFromDateController.text = Utility.INSTANCE.formatDate(value);
        if (filterToDateController.text.isEmpty) {
          pickedEndDate = pickedFromDate;
          filterToDateController.text = filterFromDateController.text;
        }
      }
    });

  }

  openToDate(context) async {

    await Utility.INSTANCE.openCalender(context,pickedFromDate ,pickedEndDate ,todayDate,(value){
      if(value!=null) {
        pickedEndDate = value;
        filterToDateController.text = Utility.INSTANCE.formatDate(value);
        if (filterFromDateController.text.isEmpty) {
          pickedFromDate = pickedEndDate;
          filterFromDateController.text = filterToDateController.text;
        }
      }
    });
  }

}