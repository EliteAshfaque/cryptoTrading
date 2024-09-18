import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/TypeActions.dart';
import '../../api/model/AppSessionBasicRequest.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/balance/AllowedWallet.dart';
import '../../api/model/balance/BalanceData.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/transfer/DetailsByUserIdResponse.dart';
import '../../api/model/transfer/WalletTransferRequest.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import '../dashboard/DashboardController.dart';
import 'TransferApi.dart';

class WalletToWalletTransferController extends GetxController {
  var receiverIdError="".obs;
  var sourceError="".obs;
  var destinationError="".obs;
  var modeError="".obs;
  var amountError="".obs;



  var selectedDestination=AllowedWallet().obs;

  var inputReceiverId ="";
   TextEditingController receiverIdController = TextEditingController();
   TextEditingController destinationController = TextEditingController();
   TextEditingController amountController = TextEditingController();

  TransferApi api = TransferApi();
  PackageInfo packageInfo = Get.find();

  var dataByUserIdResponse = DetailsByUserIdResponse().obs;
  LoginResponse loginResponse =Get.find();

  DashboardController dashboardController =Get.find();
  BalanceData balanceData =Get.arguments;




  @override
  void onInit() async {
    if(balanceData.allowedWallet!=null && balanceData.allowedWallet!.isNotEmpty) {
      selectedDestination.value = balanceData.allowedWallet![0];
      destinationController.text=selectedDestination.value.walletName??"";
    }
    if(balanceData.walletTransferType == 1){
      receiverIdController.text="${loginResponse.data!.prefix}${loginResponse.data!.userID}";
      dataByUserIdResponse.value=DetailsByUserIdResponse(name: loginResponse.data!.name,emailId: loginResponse.data!.emailID,mobile: loginResponse.data!.mobileNo,statuscode: 1,userId: loginResponse.data!.userID);
    }
    super.onInit();
  }

  Future<void> getUserData( String userId) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Details ...', isCancelabel: false);
    await api.getUserDetails(AppSessionBasicRequest(
        request: userId,
        appSession: BasicRequest(loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
            APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        dataByUserIdResponse.value =response;
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }






  Future<void> transferApi() async {
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
        await dashboardController.currencyList(true, null);
        dashboardController.isBalCryptoApi=true;
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }


  @override
  void dispose() {
    receiverIdController.dispose();
    destinationController.dispose();
    amountController.dispose();
    super.dispose();
  }


}
