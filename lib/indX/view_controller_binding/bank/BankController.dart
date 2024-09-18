import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/TypeActions.dart';
import '../../api/model/bank/BankData.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../utils/Utility.dart';
import 'BankApi.dart';

 class BankController extends GetxController {




   TextEditingController searchController = TextEditingController(text: "");
   LoginResponse loginResponse =Get.find();

   var searchBankList = <BankData>[].obs;
   List<BankData> bankList = <BankData>[];

  BankApi api = BankApi();
  var isApiLoadComplete=false.obs;


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  void onInit() async {
    super.onInit();
    getBank();
  }



  Future<void> getBank() async {
    await api.getBank( loginResponse.data!, (action, response) async {
      if (action == TypeActions.INSTANCE.SUCCESS) {
        bankList.clear();
        bankList.addAll(response);
        searchBankList.value=bankList;
      }else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
      isApiLoadComplete.value=true;
    });
  }


}