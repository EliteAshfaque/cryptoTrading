import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../Api/TypeActions.dart';
import '../../../api/model/bank/BankData.dart';
import '../../../api/model/login/LoginResponse.dart';
import '../../../api/model/transfer/AddUpdateBankRequest.dart';
import '../../../api/model/transfer/BankAccountsData.dart';
import '../../../common/ConstantString.dart';
import '../../../utils/DialogBuilder.dart';
import '../../../utils/Utility.dart';
import 'AddUpdateBankApi.dart';

class AddUpdateBankController extends GetxController {
  var bankError = "".obs;
  var ifscError = "".obs;
  var acNumError = "".obs;
  var acNameError = "".obs;
  LoginResponse loginResponse = Get.find();
  var selectedBankData = BankData();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController acNumController = TextEditingController();
  final TextEditingController acNameController = TextEditingController();
  AddUpdateBankApi api = AddUpdateBankApi();
  PackageInfo packageInfo = Get.find();

  BankAccountsData forUpdateBankData = Get.arguments ?? BankAccountsData();

  @override
  void onInit() {
    if ((forUpdateBankData.id ?? 0) > 0) {
      selectedBankData.ifsc = forUpdateBankData.ifsc ?? "";
      selectedBankData.bankName = forUpdateBankData.bankName ?? "";
      selectedBankData.id = forUpdateBankData.bankID ?? 0;

      bankController.text = forUpdateBankData.bankName ?? "";
      ifscController.text = forUpdateBankData.ifsc ?? "";
      acNumController.text = forUpdateBankData.accountNumber ?? "";
      acNameController.text = forUpdateBankData.accountHolder ?? "";
    }
    super.onInit();
  }

  /*Future<void> role(context, String reffralId) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Referral Details ...', isCancelabel: false);
    await api.role(RoleRequest(isSeller: true,referralID: reffralId.isEmpty?"1":reffralId, domain: DOMAIN, appid: APP_ID, imei: DEVICE_ID, regKey: "",
            version: packageInfo.version, serialNo: DEVICE_ID), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        inputReferrralId=reffralId.isEmpty?"1":reffralId;
        leg.value=response.legs??"L";
        roleResponse.value=response;
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }
*/
  void submitBankData(Function callBack) {
    bankError.value = "";
    ifscError.value = "";
    acNumError.value = "";
    acNameError.value = "";

    if (bankController.text.trim().isEmpty) {
      bankError.value = "Select Bank";
      return;
    } else if (ifscController.text.trim().isEmpty) {
      ifscError.value = "Enter IFSC Code";
      return;
    } else if (acNumController.text.trim().isEmpty) {
      acNumError.value = "Enter Account Number";
      return;
    } else if (acNameController.text.trim().isEmpty) {
      acNameError.value = "Enter Account Holder Name";
      return;
    }
    addBank("Adding Account ...","",0,callBack);
  }

  Future<void> addBank(String loaderMsg,String otp,int refId,Function? callBack) async {
    DialogBuilder.INSTANCE
        .showLoadingIndicator('', loaderMsg, isCancelabel: false);

    await api.addUpdateBankAccount(
        AddUpdateBankRequest(otp,refId,acNameController.text.trim(),acNumController.text.trim(),selectedBankData.id??0,bankController.text.trim(),
            ifscController.text.trim(),"",forUpdateBankData.id??0,
            loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
            APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID),
        (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        if((response.referenceID??0)>0){
          if(callBack!=null){
            callBack(response.referenceID??0);
          }
        }else{
          bankError.value = "";
          ifscError.value = "";
          acNumError.value = "";
          acNameError.value = "";

          bankController.text = "";
          ifscController.text = "";
          acNumController.text = "";
          acNameController.text = "";
          Utility.INSTANCE.dialogIconOneButtonBackScreen("check", "", response.msg ?? "Successfully Added", "Cancel");
        }

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
    bankController.dispose();
    ifscController.dispose();
    acNumController.dispose();
    acNameController.dispose();
    super.dispose();
  }
}
