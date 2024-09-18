import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/TypeActions.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/balance/AllowedWithdrawalType.dart';
import '../../api/model/balance/BalanceData.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/transfer/BankAccountsData.dart';
import '../../api/model/transfer/UpdateBankRequest.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import '../dashboard/DashboardController.dart';
import 'TransferApi.dart';

class BankAccountsController extends GetxController {
  TransferApi api = TransferApi();
  PackageInfo packageInfo = Get.find();

  LoginResponse loginResponse = Get.find();
  TextEditingController searchController = TextEditingController(text: "");
  DashboardController dashboardController = Get.find();
  BalanceData balanceData = Get.arguments[0];
  AllowedWithdrawalType allowedWithdrawalType = Get.arguments[1];
  var searchBeneList = <BankAccountsData>[].obs;
  List<BankAccountsData> baneList = <BankAccountsData>[];
  var isApiCalled=false.obs;
  var isSattlmentAccountVerify=false.obs;

  @override
  void onInit() async {
    await getBankAccounts();
    super.onInit();
  }

Future<void> getBankAccounts() async {


    await api.getBankAccounts( BasicRequest(loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID), (action, response) async {

      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        isSattlmentAccountVerify.value=response.isSattlemntAccountVerify??false;
        baneList.clear();
        searchBeneList.clear();
        baneList.addAll(response.data!);
        searchBeneList.value=baneList;
      } else if (action == TypeActions.INSTANCE.ERROR) {
        searchBeneList.value = <BankAccountsData>[];
        baneList = <BankAccountsData>[];
        //Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> deleteBankAccount(int id,BankAccountsData removeObj) async {

    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Deleting Account ...', isCancelabel: false);
    await api.deleteBankAccount( UpdateBankRequest(id,loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        Utility.INSTANCE.dialogIconOneButton("check", "", response.msg??"Delete Successfully", "Cancel");
        baneList.remove(removeObj);
        searchController.text="";
        searchBeneList.value=baneList;
        getBankAccounts();
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }






  /*Future<void> transferApi() async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Transferring ...', isCancelabel: false);
    await api.transfer(AppSessionBasicRequest(
        request: WalletTransferRequest(Amount: amountController.text.trim(),FromWalletId: balanceData.id,ToUserId: dataByUserIdResponse.value.userId,
            ToWalletId: selectedDestination.value.toWalletId,ToWithdrwalType: 1),
        appSession: BasicRequest(loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
            APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        Utility.INSTANCE.dialogIconOneButton("check", "", response.msg??"Success", "Cancel");
        await dashboardController.balance(true);
        dashboardController.isBalCryptoApi=true;
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }*/

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
