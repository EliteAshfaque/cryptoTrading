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

class DirectBusinessReportController extends GetxController {

  ReportApi api = ReportApi();
  LoginResponse loginResponse =Get.find();
  var searchBusinessList = <ReportData>[].obs;
  List<ReportData> businessList = <ReportData>[];
  var opidList = <ReportData>[];
  var isApiCalled=false.obs;


  var filterOPID=0;
  var filterBusinessType= "All";
  var filterFromDate= "";
  var filterToDate= "";
  TextEditingController searchController = TextEditingController(text: "");
  final TextEditingController filterFromDateController = TextEditingController();
  final TextEditingController filterToDateController = TextEditingController();
  final TextEditingController filterBusinessTypeController = TextEditingController(text: "All");

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

    if(Get.isRegistered<List<ReportData>>(tag: BUSINESS_TYPE_DATA)){
      opidList = Get.find<List<ReportData>>(tag: BUSINESS_TYPE_DATA);

    }
    await getBusinessReport(false);
    await getOPIDList();


  }



  Future<void> getOPIDList() async {

    await api.getOPIDList( 0,loginResponse.data!, (action, response) async {

      if (action == TypeActions.INSTANCE.SUCCESS) {
        opidList=response;
        opidList.insert(0,ReportData(oid: 0,name: "All"));
        await Get.delete<List<ReportData>>(tag: BUSINESS_TYPE_DATA,force: true);
        await Get.putAsync<List<ReportData>>(() async {return opidList;}, tag: BUSINESS_TYPE_DATA, permanent: true);
      }else if (action == TypeActions.INSTANCE.ERROR) {
       // Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        //Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }


  Future<void> getBusinessReport(bool isFromClick) async {
    if(isFromClick){
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Business Report ...', isCancelabel: false);}
    await api.getDirectBusinessReport(isFromClick,filterOPID,
        filterFromDate,filterToDate, loginResponse.data!, (action, response) async {
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
  filterFromDateController.dispose();
  filterToDateController .dispose();
  filterBusinessTypeController .dispose();

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