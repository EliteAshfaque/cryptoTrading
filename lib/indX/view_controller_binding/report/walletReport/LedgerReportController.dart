import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/TypeActions.dart';
import '../../../api/model/balance/BalanceData.dart';
import '../../../api/model/login/LoginResponse.dart';
import '../../../api/model/report/LedgerReport.dart';
import '../../../utils/DialogBuilder.dart';
import '../../../utils/Utility.dart';
import '../ReportApi.dart';

class LedgerReportController extends GetxController {

  ReportApi api = ReportApi();
  LoginResponse loginResponse =Get.find();
  var searchList = <LedgerReport>[].obs;
  List<LedgerReport> list = <LedgerReport>[];
  var isApiCalled=false.obs;
  BalanceData parentItem= Get.arguments[0];
  List<BalanceData> walletList=Get.arguments[1];
  List<String> topCountList=["50","100","200","500","1000","1500","3000","ALL"];
  var filterWalletTypeId= 0;
  var filterWalletType= "";
  var filterTopRow= "50";
  var filterFromDate= "";
  var filterToDate= "";
  var filterTxnId= "";
  TextEditingController searchController = TextEditingController(text: "");
  final TextEditingController filterFromDateController = TextEditingController();
  final TextEditingController filterToDateController = TextEditingController();
  final TextEditingController filterTxnIdController = TextEditingController();
  final TextEditingController filterWalletTypeController = TextEditingController();
  final TextEditingController filterTopRowController = TextEditingController(text: "50");
  var todayDate= DateTime.now();
  late DateTime pickedFromDate, pickedEndDate;


  @override
  void onInit() async{
    super.onInit();
    filterWalletTypeId= parentItem.id??0;
    filterWalletType=parentItem.walletType??"";
    pickedFromDate=todayDate;
    pickedEndDate=todayDate;
    filterFromDate=Utility.INSTANCE.formatDate(todayDate);
    filterToDate=filterFromDate;
    filterFromDateController.text =filterFromDate ;
    filterToDateController.text=filterFromDate;
    filterWalletTypeController.text=filterWalletType;
    await getReport(false);

  }

  Future<void> getReport(bool isFromClick) async {
    if(isFromClick){
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Account Statement ...', isCancelabel: false);}
    await api.getLedgerReport(isFromClick, filterWalletTypeId,  filterTopRow=="ALL"?"5000":filterTopRow, filterFromDate, filterToDate,
        filterTxnId, loginResponse.data!, (action, response) async {
          if(isFromClick){
            DialogBuilder.INSTANCE.hideOpenDialog();
          }
      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        list.clear();
        searchList.clear();
        list.addAll(response);
        searchList.value=list;
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
  filterFromDateController.dispose();
    filterToDateController .dispose();
    filterTxnIdController .dispose();
    filterWalletTypeController .dispose();
    filterTopRowController.dispose();
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