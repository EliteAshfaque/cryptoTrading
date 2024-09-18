import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/TypeActions.dart';
import '../../../api/model/login/LoginResponse.dart';
import '../../../api/model/report/ReportData.dart';
import '../../../common/ConstantString.dart';
import '../../../utils/DialogBuilder.dart';
import '../../../utils/Utility.dart';
import '../ReportApi.dart';

class SponserTeamReportController extends GetxController {

  ReportApi api = ReportApi();
  LoginResponse loginResponse =Get.find();
  var searchTeamList = <ReportData>[].obs;
  List<ReportData> teamList = <ReportData>[];
  var levelList = <ReportData>[];
  var isApiCalled=false.obs;

  List<String> statusList=["All","Active","Deactive"];

  var filterStatus= "All";
  var filterLevelNo= "0";
  /*var filterFromDate= "";
  var filterToDate= "";*/
  TextEditingController searchController = TextEditingController(text: "");
 /* final TextEditingController filterFromDateController = TextEditingController();
  final TextEditingController filterToDateController = TextEditingController();*/
  final TextEditingController filterLevelController = TextEditingController(text: "All");
  final TextEditingController filterStatusController = TextEditingController(text: "All");
  /*var todayDate= DateTime.now();
  late DateTime pickedFromDate, pickedEndDate;*/

  @override
  void onInit() async{
    super.onInit();
   /* pickedFromDate=todayDate;
    pickedEndDate=todayDate;
    filterFromDate=Utility.INSTANCE.formatDate(todayDate);
    filterToDate=filterFromDate;
    filterFromDateController.text =filterFromDate ;
    filterToDateController.text=filterFromDate;*/

    if(Get.isRegistered<List<ReportData>>(tag: "${LEVEL_LIST_DATA}_0")){
      levelList = Get.find<List<ReportData>>(tag: "${LEVEL_LIST_DATA}_0");

    }

    await getSponserTeam(false);
    await getLevel();


  }



  Future<void> getLevel() async {

    await api.getLevel( 0,loginResponse.data!, (action, response) async {

      if (action == TypeActions.INSTANCE.SUCCESS) {
        levelList=response;
        levelList.insert(0, ReportData(levelNo: 0));
        await Get.delete<List<ReportData>>(tag: "${LEVEL_LIST_DATA}_0",force: true);
        await Get.putAsync<List<ReportData>>(() async {return levelList;}, tag: "${LEVEL_LIST_DATA}_0", permanent: true);
      }else if (action == TypeActions.INSTANCE.ERROR) {
       // Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        //Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }


  Future<void> getSponserTeam(bool isFromClick) async {
    if(isFromClick){
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Team ...', isCancelabel: false);}
    await api.getSponsorTeam(isFromClick, filterLevelNo,
       /* filterFromDate,filterToDate,*/
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
 /* filterFromDateController.dispose();
  filterToDateController .dispose();*/
  filterLevelController .dispose();
  filterStatusController .dispose();

    super.dispose();
  }

  /*openFromDate(context) async {
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
  }*/

}