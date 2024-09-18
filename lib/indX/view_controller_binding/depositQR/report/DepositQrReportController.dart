import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/TypeActions.dart';
import '../../../api/model/depositQr/AutoDepositHistory.dart';
import '../../../api/model/fundRequest/FundRequestReport.dart';
import '../../../api/model/login/LoginResponse.dart';
import '../../../utils/Utility.dart';
import 'DepositQrReportApi.dart';

class DepositQrReportController extends GetxController {

  DepositQrReportApi api = DepositQrReportApi();
  LoginResponse loginResponse =Get.find();
  var searchList = <AutoDepositHistory>[].obs;
  List<AutoDepositHistory> list = <AutoDepositHistory>[];
  var isApiCalled=false.obs;

  /*List<String> statusList=["All","Requested","Accepted","Rejected"];*/
  /*var filterStatusId= 0;
  var filterStatusValue= "All";*/
  var filterFromDate= "";
  var filterToDate= "";
  TextEditingController searchController = TextEditingController(text: "");
  final TextEditingController filterFromDateController = TextEditingController();
  final TextEditingController filterToDateController = TextEditingController();
  /*final TextEditingController filterStatusController = TextEditingController(text: "All");*/
  var todayDate= DateTime.now();
  late DateTime pickedFromDate, pickedEndDate;
  int currencyId= Get.arguments;


  @override
  void onInit() async{
    super.onInit();

    pickedFromDate=todayDate;
    pickedEndDate=todayDate;
    filterFromDate=Utility.INSTANCE.formatDate(todayDate);
    filterToDate=filterFromDate;
    filterFromDateController.text =filterFromDate ;
    filterToDateController.text=filterFromDate;
    await getReport(false);

  }

  Future<void> getReport(bool isFromClick) async {
    if(isFromClick){
      isApiCalled.value=false;
      list.clear();
      searchList.clear();
    }
    await api.getReport(currencyId, filterFromDate, filterToDate,
         loginResponse.data!, (action, response) async {

      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        list.clear();
        searchList.clear();
        list.addAll(response);
        searchList.value=list;
      }else if (action == TypeActions.INSTANCE.ERROR) {
        searchList.value = <AutoDepositHistory>[];
        list = <AutoDepositHistory>[];
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
   /* filterStatusController .dispose();*/
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