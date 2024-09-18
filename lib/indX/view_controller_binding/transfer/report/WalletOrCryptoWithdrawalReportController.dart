import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/TypeActions.dart';
import '../../../api/model/login/LoginResponse.dart';
import '../../../api/model/transfer/WithdrawalWalletReport.dart';
import '../../../utils/DialogBuilder.dart';
import '../../../utils/Utility.dart';
import 'WalletOrCryptoWithdrawalReportApi.dart';

class WalletOrCryptoWithdrawalReportController extends GetxController {

  WalletOrCryptoWithdrawalReportApi api = WalletOrCryptoWithdrawalReportApi();
  LoginResponse loginResponse =Get.find();
  var searchReportList = <WithdrawalWalletReport>[].obs;
  List<WithdrawalWalletReport> reportList = <WithdrawalWalletReport>[];

  var isApiCalled=false.obs;



  int walletCurrencytId= Get.arguments[0];
  bool isFromCrypto= Get.arguments[1];
  var filterFromDate= "";
  var filterToDate= "";
  TextEditingController searchController = TextEditingController(text: "");
  final TextEditingController filterFromDateController = TextEditingController();
  final TextEditingController filterToDateController = TextEditingController();
 

  var todayDate= DateTime.now();
  late DateTime pickedFromDate, pickedEndDate;

  get filterBusinessTypeController => null;

  @override
  void onInit() async{
    super.onInit();
    pickedFromDate=todayDate;
    pickedEndDate=todayDate;
    filterFromDate=Utility.INSTANCE.formatDate(todayDate);
    filterToDate=filterFromDate;
    filterFromDateController.text =filterFromDate ;
    filterToDateController.text=filterFromDate;

    if(isFromCrypto==true){
      await getCryptoWithdrawalReport(false);
    }else{
      await getWalletWithdrawalReport(false);
    }



  }






  Future<void> getWalletWithdrawalReport(bool isFromClick) async {
    if(isFromClick){
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Withdrawal Report ...', isCancelabel: false);}
    await api.getWalletWithdrawalReport(isFromClick,walletCurrencytId,walletCurrencytId,
        filterFromDate,filterToDate, loginResponse.data!, (action, response) async {
      if(isFromClick){DialogBuilder.INSTANCE.hideOpenDialog();}
      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        reportList.clear();
        searchReportList.clear();
        reportList.addAll(response);
        searchReportList.value=reportList;
      }else if (action == TypeActions.INSTANCE.ERROR) {
        searchReportList.value = <WithdrawalWalletReport>[];
        reportList = <WithdrawalWalletReport>[];
       // Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  Future<void> getCryptoWithdrawalReport(bool isFromClick) async {
    if(isFromClick){
      DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Withdrawal Report ...', isCancelabel: false);}
    await api.getCryptoWithdrawalReport(isFromClick,walletCurrencytId,walletCurrencytId,
        filterFromDate,filterToDate, loginResponse.data!, (action, response) async {
          if(isFromClick){DialogBuilder.INSTANCE.hideOpenDialog();}
          isApiCalled.value=true;
          if (action == TypeActions.INSTANCE.SUCCESS) {
            reportList.clear();
            searchReportList.clear();
            reportList.addAll(response);
            searchReportList.value=reportList;
          }else if (action == TypeActions.INSTANCE.ERROR) {
            searchReportList.value = <WithdrawalWalletReport>[];
            reportList = <WithdrawalWalletReport>[];
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