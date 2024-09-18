import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Api/TypeActions.dart';
import '../../api/model/balance/BalanceData.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/myStake/StakingDetailData.dart';
import '../../api/model/report/ReportData.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import '../dashboard/DashboardController.dart';
import 'MyStakeApi.dart';

class MyStakeReportController extends GetxController {

  MyStakeApi api = MyStakeApi();
  LoginResponse loginResponse =Get.find();
  DashboardController dashboardController=Get.find();
   TextEditingController amountController = TextEditingController();
  var amountError="".obs;
  var reortList = <ReportData>[].obs;
  var isApiCalled=false.obs;
  var isOldApiCalled=false.obs;
  var withdrawlabelMint=0.0.obs;
  var withdrawlabelOldMint=0.0.obs;
  var list = <StakingDetailData>[].obs;
  var listOld = <StakingDetailData>[].obs;
  List<BalanceData> listWallet = Get.arguments;
  @override
  void onInit() async{
    super.onInit();

    await getMint();
    await getReport();
    await getOldMint();
    await getOldReport();
  }






  Future<void> getMint() async {

    await api.getMint( loginResponse.data!, (action, response) async {
      if (action == TypeActions.INSTANCE.SUCCESS) {
        withdrawlabelMint.value=response.withdrawlabelMint??0;
      }else if (action == TypeActions.INSTANCE.ERROR) {
       Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  Future<void> getReport() async {

    await api.getStakeReport( loginResponse.data!, (action, response) async {
      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        list.value=response??<StakingDetailData>[];
      }else if (action == TypeActions.INSTANCE.ERROR) {
      // Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  Future<void> getOldMint() async {

    await api.getMintOld( loginResponse.data!, (action, response) async {
      if (action == TypeActions.INSTANCE.SUCCESS) {
        withdrawlabelOldMint.value=response.withdrawlabelMint??0;
      }else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  Future<void> getOldReport() async {

    await api.getStakeOldReport( loginResponse.data!, (action, response) async {
      isOldApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        listOld.value=response??<StakingDetailData>[];
      }else if (action == TypeActions.INSTANCE.ERROR) {
        //Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  Future<void> withdrawalMint(int withdrwalType,int walletID,String amount, Function? callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Withdrawal Mint ...', isCancelabel: false);
    await api.withdrawalMint(  withdrwalType, walletID, amount,loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        if(callBack!=null){
          callBack(response);
        }
        //Utility.INSTANCE.dialogIconOneButton("check","", response, "Cancel");
        await getMint();
        await getReport();
        /*if(withdrwalType==1){
          await dashboardController.balance(true);
        }else{
          // for(var item in dashboardController.displayBalCryptoList) {
          //   await dashboardController.getCryptoBalanceApi(item.id??0,true, false);
          // }
          await dashboardController.currencyList(true, null);
        }*/
        await dashboardController.balance(true);
        await dashboardController.currencyList(true, null);
        dashboardController.isBalCryptoApi=true;

      }else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }


  Future<void> withdrawalOldMint(String amount, Function? callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Withdrawal Mint ...', isCancelabel: false);
    await api.withdrawalOldMint( amount,loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        if(callBack!=null){
          callBack(response);
        }
       // Utility.INSTANCE.dialogIconOneButton("check","", response, "Cancel");
        await getOldMint();
        await getOldReport();
         await dashboardController.balance(true);
        await dashboardController.currencyList(true, null);
        dashboardController.isBalCryptoApi=true;
        // for(var item in dashboardController.displayBalCryptoList) {
        //   await dashboardController.getCryptoBalanceApi(item.id??0,true, false);
        // }
      }else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }


  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}