import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../Api/TypeActions.dart';
import '../../../api/model/AppSessionBasicRequest.dart';
import '../../../api/model/BasicRequest.dart';
import '../../../api/model/login/LoginResponse.dart';
import '../../../api/model/transfer/BankAccountsData.dart';
import '../../../common/ConstantString.dart';
import '../../../utils/DialogBuilder.dart';
import '../../../utils/Utility.dart';
import '../../dashboard/DashboardController.dart';
import 'SendMoneyBankApi.dart';

class SendMoneyBankController extends GetxController {

  var amountError = "".obs;
  var modeError = "".obs;
  LoginResponse loginResponse = Get.find();
  final TextEditingController modeController = TextEditingController(text: "IMPS");
  final TextEditingController amountController = TextEditingController();
  SendMoneyBankApi api = SendMoneyBankApi();
  PackageInfo packageInfo = Get.find();
  int selectedModeOID=771;

  List<String> modeList=["IMPS","NEFT","RTGS"];
  List<int> modeOIDList=[771,772,773];
  BankAccountsData bankData = Get.arguments[0] ?? BankAccountsData();
  int fromWalletId = Get.arguments[1]??0;
  DashboardController dashboardController =Get.find();

  /*@override
  void onInit() {

    super.onInit();
  }*/


  void submitTransaction() {

    amountError.value = "";

    if (amountController.text.trim().isEmpty) {
      amountError.value = "Enter Amount";
      return;
    }
    sendMoney();
  }

  Future<void> sendMoney() async {
    DialogBuilder.INSTANCE
        .showLoadingIndicator('', "Sending Money ...", isCancelabel: false);

    await api.sendMoney(
        AppSessionBasicRequest(request: jsonDecode('{"Amount":"${amountController.text.trim()}","BankId":"${bankData.id ?? 0}","WalletID":"$fromWalletId","OID":"$selectedModeOID"}') ,appSession: BasicRequest(
            loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
            APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)),
        (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {

          amountError.value = "";
          amountController.text = "";
          Utility.INSTANCE.dialogIconOneButton("check", "", response.msg ?? "Transfer Successfully", "Cancel");
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
    modeController.dispose();
    amountController.dispose();

    super.dispose();
  }
}
