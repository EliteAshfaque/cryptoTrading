import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/TypeActions.dart';
import '../../../api/model/dashboardData/IncomeDetails.dart';
import '../../../api/model/login/LoginResponse.dart';
import '../../../api/model/report/IncomeReport.dart';
import '../../../api/model/report/ReportData.dart';
import '../../../common/ConstantString.dart';
import '../../../utils/DialogBuilder.dart';
import '../../../utils/Utility.dart';
import '../ReportApi.dart';

class IncomeReportController extends GetxController {

  ReportApi api = ReportApi();
  LoginResponse loginResponse =Get.find();
  var searchIncomeList = <IncomeReport>[].obs;
  List<IncomeReport> incomeList = <IncomeReport>[];
  var levelList = <ReportData>[];
  var isApiCalled=false.obs;
  String defaultSymbol = Get.arguments[0];
  IncomeDetails incomeDetails = Get.arguments[1];

  var filterLevelNo= "0";
  var filterFromDate= "";
  var filterToDate= "";
  TextEditingController searchController = TextEditingController(text: "");
  final TextEditingController filterFromDateController = TextEditingController();
  final TextEditingController filterToDateController = TextEditingController();
  final TextEditingController filterLevelController = TextEditingController(text: "All");

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

    await getIncomeReport(false);

    if(incomeDetails.incomeCategoryID==1) {
      if(Get.isRegistered<List<ReportData>>(tag: "${LEVEL_LIST_DATA}_${incomeDetails.incomeOPID??0}")){
        levelList = Get.find<List<ReportData>>(tag: "${LEVEL_LIST_DATA}_${incomeDetails.incomeOPID??0}");
      }
      await getLevel();
    }


  }



  Future<void> getLevel() async {

    await api.getLevel( incomeDetails.incomeOPID??0,loginResponse.data!, (action, response) async {

      if (action == TypeActions.INSTANCE.SUCCESS) {
        levelList=response;
        levelList.insert(0, ReportData(levelNo: 0));
        await Get.delete<List<ReportData>>(tag: "${LEVEL_LIST_DATA}_${incomeDetails.incomeOPID??0}",force: true);
        await Get.putAsync<List<ReportData>>(() async {return levelList;}, tag: "${LEVEL_LIST_DATA}_${incomeDetails.incomeOPID??0}", permanent: true);
      }else if (action == TypeActions.INSTANCE.ERROR) {
       // Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        //Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }


  Future<void> getIncomeReport(bool isFromClick) async {
    if(isFromClick){
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Income ...', isCancelabel: false);}
    await api.getIncomeReport(isFromClick,incomeDetails.incomeCategoryID??0,incomeDetails.incomeOPID??0, filterLevelNo,
        filterFromDate,filterToDate, loginResponse.data!, (action, response) async {
      if(isFromClick){DialogBuilder.INSTANCE.hideOpenDialog();}
      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        incomeList.clear();
        searchIncomeList.clear();
        incomeList.addAll(response);
        searchIncomeList.value=incomeList;
      }else if (action == TypeActions.INSTANCE.ERROR) {
        searchIncomeList.value = <IncomeReport>[];
         incomeList = <IncomeReport>[];
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
  filterLevelController .dispose();

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