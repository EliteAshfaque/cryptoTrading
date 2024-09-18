import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/TypeActions.dart';
import '../../../api/model/login/LoginResponse.dart';
import '../../../api/model/swap/SwapReportData.dart';
import '../../../utils/Utility.dart';
import 'SwapReportApi.dart';

class SwapReportController extends GetxController {

  SwapReportApi api = SwapReportApi();
  LoginResponse loginResponse =Get.find();
  var searchReportList = <SwapReportData>[].obs;
  List<SwapReportData> reportList = <SwapReportData>[];

  var isApiCalled=false.obs;




  var filterFromDate= "";
  var filterToDate= "";
  TextEditingController searchController = TextEditingController(text: "");
  final TextEditingController filterFromDateController = TextEditingController();
  final TextEditingController filterToDateController = TextEditingController();
 

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

      await getSwapReport();

  }






  Future<void> getSwapReport() async {

    await api.getSwapReport(loginResponse.data!, (action, response) async {
      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        reportList.clear();
        searchReportList.clear();
        reportList.addAll(response);
        searchReportList.value=reportList;
      }else if (action == TypeActions.INSTANCE.ERROR) {
        searchReportList.value = <SwapReportData>[];
        reportList = <SwapReportData>[];
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