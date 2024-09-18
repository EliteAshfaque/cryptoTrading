import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/TypeActions.dart';
import '../../api/model/AppSessionBasicRequest.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/balance/AllowedWalletToCrypto.dart';
import '../../api/model/balance/BalanceData.dart';
import '../../api/model/currencyList/LiveRateResponse.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/transfer/DetailsByUserIdResponse.dart';
import '../../api/model/transfer/WalletTransferRequest.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import '../dashboard/DashboardController.dart';
import '../gAuthSetup/GoogleAuthApi.dart';
import 'TransferApi.dart';

class WalletToBlockChainTransferController extends GetxController {

  var addressError="".obs;
  var coinError="".obs;
  var amountError="".obs;
  var convertAmountError ="".obs;
  var isAmountFocused=false.obs;
  var convertedAmount=0.0.obs;
  var inputAmount=0.0.obs;
  var isConvertAmountFocused=false.obs;
  var liveRateResponse =LiveRateResponse().obs;
  var otpType=0.obs;
  var selectedCoin=AllowedWalletToCrypto().obs;

  var inputReceiverId ="";
  final TextEditingController addressController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController coinController = TextEditingController();
  final TextEditingController convertAmountController = TextEditingController();
  GoogleAuthApi apiGA = GoogleAuthApi();
  TransferApi api = TransferApi();
  PackageInfo packageInfo = Get.find();
  var dataByUserIdResponse = DetailsByUserIdResponse().obs;
  LoginResponse loginResponse =Get.find();

  DashboardController dashboardController =Get.find();
  BalanceData balanceData =Get.arguments;




  @override
  void onInit() async {
    addressController.text=dashboardController.balanceResponse.value.externalAddress??"";
    if(balanceData.allowedWalletToCripto!=null && balanceData.allowedWalletToCripto!.isNotEmpty) {
      selectedCoin.value = balanceData.allowedWalletToCripto![0];
      coinController.text=selectedCoin.value.symbolName??"";
      if(selectedCoin.value.isdoubbleFactor==true){
        otpType.value=1;
      }
      if(selectedCoin.value.symbolId!=balanceData.walletCurrencyID) {
        getLiveRate(selectedCoin.value.symbolId??0, balanceData.walletCurrencyID??0);
      }

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

  Future<void> getLiveRate( int fromCurrId,int toCurrId) async {


    await dashboardController.api.getLiveRate(fromCurrId, toCurrId,loginResponse.data!, (action, response) async {
      if (action == TypeActions.INSTANCE.SUCCESS) {
        liveRateResponse.value=response;
        dashboardController.currencyLiveRateMap["$fromCurrId-$toCurrId"]=response;
        setLiveRateData();
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  void setLiveRateData(){

      if (amountController.text.trim().isNotEmpty) {
        convertedAmount.value = double.parse(amountController.text.trim()) / (liveRateResponse.value.liveRate??0);
        if (convertedAmount.value.isNaN || convertedAmount.value.isInfinite) {
          convertAmountController.text = "";
        } else {
          convertAmountController.text = Utility.INSTANCE.formatedAmountNinePlace(convertedAmount.value);
        }
      }

  }


  Future<void> transferApi(bool isDialogOpen,String otp,int refId,Function? callBack) async {

    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Processing ...', isCancelabel: false);
    await api.transfer(AppSessionBasicRequest(
        request: WalletTransferRequest(ExternalAddress: addressController.text.toString().trim(),OTP: otp,OTPType: otpType.value,OTPRefId: refId,Amount: amountController.text.trim(),FromWalletId: balanceData.id,ToUserId: loginResponse.data!.userID,
            ToWalletId: selectedCoin.value.symbolId,ToWithdrwalType: 2),
        appSession: BasicRequest(loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
            APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        if(isDialogOpen==true){
          Get.back();
        }
        if(response.statuscode==-3){
          if(callBack!=null){
            callBack(response);
          }
        }else{
          /*  dashboardController.getCryptoBalanceApi(currencyItem.id??0,false);*/
          Utility.INSTANCE.showResponseDetailDialog("Withdrawal Details", response);
          await dashboardController.currencyList(true, null);
          await dashboardController.balance(true);
          dashboardController.isBalCryptoApi=true;
          // for(var item in dashboardController.displayBalCryptoList) {
          //   await dashboardController.getCryptoBalanceApi(item.id??0,true, false);
          // }
        }
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> sendOTPApi(bool isDialogOpen,Function? callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Sending OTP ...', isCancelabel: false);
    await apiGA.sendOTP(null, loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        if(callBack!=null){
          callBack(response);
        }
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> getGoogleAuthData(bool isDialogOpen, String otp, int refId,Function? callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting GAuth Data ...', isCancelabel: false);
    await apiGA.getGAuthData(null, otp, refId, loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();

      if (action == TypeActions.INSTANCE.SUCCESS) {
        if(isDialogOpen==true) {
          Get.back();
        }
        if (response.qrCodeSetupKey != null && response.qrCodeSetupKey!.isNotEmpty &&
            response.qrCodeSetupImageUrl != null && response.qrCodeSetupImageUrl!.isNotEmpty) {
          if (callBack != null) {
            callBack(response);
          }
        } else {
          Utility.INSTANCE.dialogIconOneButton("error", "","Setup data is not available","Cancel");
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
    addressController.dispose();
    amountController.dispose();
    coinController.dispose();
    convertAmountController.dispose();
    super.dispose();
  }


}
