import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/TypeActions.dart';
import '../../../api/model/login/LoginResponse.dart';
import '../../../api/model/transfer/SendMoneyBankReport.dart';
import '../../../utils/DialogBuilder.dart';
import '../../../utils/Utility.dart';
import 'SendMoneyBankReportApi.dart';

class SendMoneyBankReportController extends GetxController {
  SendMoneyBankReportApi api = SendMoneyBankReportApi();
  LoginResponse loginResponse = Get.find();
  var searchReportList = <SendMoneyBankReport>[].obs;
  List<SendMoneyBankReport> reportList = <SendMoneyBankReport>[];

  var isApiCalled = false.obs;

  List<String> topCountList=["50","100","200","500","1000","1500","3000","All"];
  List<String> statusList=["All","Pending","Success","Failed","Refunded"];
  var filterStatusId = 0;
  var filterStatus = "All";
  var filterIsRecent = true;
  var filterTopRows = "50";
  var filterFromDate = "";
  var filterToDate = "";
  var filterTransactionId = "";
  var filterAccountNo = "";
  TextEditingController searchController = TextEditingController(text: "");
  final TextEditingController filterFromDateController = TextEditingController();
  final TextEditingController filterToDateController = TextEditingController();
  final TextEditingController filterAcNOController = TextEditingController();
  final TextEditingController filterTxnIdController = TextEditingController();
  final TextEditingController filterTopRowController = TextEditingController(text: "50");
  final TextEditingController filterStatusController = TextEditingController(text: "All");

  var todayDate = DateTime.now();
  late DateTime pickedFromDate, pickedEndDate;

  get filterBusinessTypeController => null;

  @override
  void onInit() async {
    super.onInit();
    pickedFromDate = todayDate;
    pickedEndDate = todayDate;
    filterFromDate = Utility.INSTANCE.formatDate(todayDate);
    filterToDate = filterFromDate;
    filterFromDateController.text = filterFromDate;
    filterToDateController.text = filterFromDate;

    await getReport(false);
  }

  Future<void> getReport(bool isFromClick) async {
    if (isFromClick) {
      DialogBuilder.INSTANCE
          .showLoadingIndicator('', 'Getting Report ...', isCancelabel: false);
    }
    await api.getReport(isFromClick, filterTopRows, filterStatusId, filterFromDate, filterToDate, filterTransactionId, filterAccountNo, filterIsRecent,
        loginResponse.data!, (action, response) async {
      if (isFromClick) {
        DialogBuilder.INSTANCE.hideOpenDialog();
      }
      isApiCalled.value = true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        reportList.clear();
        searchReportList.clear();
        reportList.addAll(response);
        searchReportList.value = reportList;
      } else if (action == TypeActions.INSTANCE.ERROR) {
        searchReportList.value = <SendMoneyBankReport>[];
        reportList = <SendMoneyBankReport>[];
        // Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> submitDispute(int? tid, String? transactionId, String otp,String refID, bool isResend, Function? callBack) async {

      DialogBuilder.INSTANCE.showLoadingIndicator('', 'Submitting Dispute ...', isCancelabel: false);

    await api.submitDispute( tid,  transactionId,  otp,refID,  isResend, loginResponse.data!, (action, response) async {
        DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        if(response.isOTPRequired==true){
          if(callBack!=null){
            callBack(response);
          }
        }else{
          Utility.INSTANCE.dialogIconOneButton("check","", response.msg??"Dispute Submitted", "Cancel");
          getReport(true);
        }

      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    filterFromDateController.dispose();
    filterToDateController.dispose();

    super.dispose();
  }

  openFromDate(context) async {
    await Utility.INSTANCE.openCalender(
        context, DateTime(2023), pickedFromDate, pickedEndDate, (value) {
      if (value != null) {
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
    await Utility.INSTANCE.openCalender(
        context, pickedFromDate, pickedEndDate, todayDate, (value) {
      if (value != null) {
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
