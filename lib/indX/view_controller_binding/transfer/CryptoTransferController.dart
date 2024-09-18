import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/TypeActions.dart';
import '../../api/model/AppSessionBasicRequest.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/currencyList/LiveRateData.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/transfer/CryptoTransferRequest.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import '../dashboard/DashboardController.dart';
import '../gAuthSetup/GoogleAuthApi.dart';
import 'TransferApi.dart';

class CryptoTransferController extends GetxController {

  var addressError="".obs;
  var amountError="".obs;
  var inputReferrralId ="";
  var otpType=0.obs;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  TransferApi api = TransferApi();
  GoogleAuthApi apiGA = GoogleAuthApi();
  PackageInfo packageInfo = Get.find();

  LoginResponse loginResponse =Get.find();

  DashboardController dashboardController =Get.find();
  LiveRateData currencyItem = Get.arguments;
  var cryptoBalanceList=<LiveRateData>[].obs;

  @override
  void onInit() async {
    if(loginResponse.data!.isDoubleFactor == true){
      otpType.value=1;
    }
    getCryptoList();
    super.onInit();
  }


  void getCryptoList(){
    if (dashboardController.allCryptoList .isNotEmpty) {
      cryptoBalanceList.clear();
      for (var item in dashboardController.allCryptoList) {
        if (item.id == currencyItem.id) {
          cryptoBalanceList.add(item);
        } else if (item.isCoin == true && item.technologyId == currencyItem.technologyId && /*(*/item.isBalanceFromDB==false/*|| item.id == (isFromWallet==true?currencyItem.currencyId:currencyItem.id))*/) {
          cryptoBalanceList.add(item);
        }
      }

    }else{
      dashboardController.currencyList(false,(){
        if (dashboardController.allCryptoList .isNotEmpty) {
          cryptoBalanceList.clear();
          for (var item in dashboardController.allCryptoList) {
            if (item.id == currencyItem.id) {
              cryptoBalanceList.add(item);
            } else if (item.isCoin == true && item.technologyId == currencyItem.technologyId && /*(*/item.isBalanceFromDB==false/*|| item.id == (isFromWallet==true?currencyItem.currencyId:currencyItem.id))*/) {
              cryptoBalanceList.add(item);
            }
          }

        }
      });
    }
  }



  Future<void> transfer(bool isDialogOpen,String otp,int refId,Function? callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Transferring ...', isCancelabel: false);
    /*if(currencyItem.isBalanceFromDB==true){
      await api.transferCryptoDb(AppSessionBasicRequest(
          request: CryptoTransferRequest(OTP: otp,OTPType: otpType.value,ReferenceId: refId,Amount: amountController.text.trim(),
          ToAddress: addressController.text.trim(),TransferType: 2,ToWalletId: 0,FromCurrId: currencyItem.id??0,FromUserId: loginResponse.data!.userID),
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
            //await dashboardController.getCryptoBalanceApi(currencyItem.id??0,false);
            Utility.INSTANCE.showResponseDetailDialog("Transfer Details", response);
            // for(var item in cryptoBalanceList) {
            //   await  dashboardController.getCryptoBalanceApi(item.id??0,true, false);
            // }
            await dashboardController.currencyList(true,(){
              getCryptoList();
            });
            await dashboardController.balance(true);
            dashboardController.isBalCryptoApi=true;
          }

        } else if (action == TypeActions.INSTANCE.ERROR) {
          Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
        } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
          Utility.INSTANCE.dialogIconOneButton(
              "wifi_error", "Network Error", "No Internet Connection", "Cancel");
        }
      });
    }else{*/
      await api.transferCrypto(AppSessionBasicRequest(
          request: CryptoTransferRequest(OTP: otp,OTPType: otpType.value,ReferenceId: refId,Amount: amountController.text.trim(),
              ToAddress: addressController.text.trim(),TransferType: 2,ToWalletId: 0,FromCurrId: currencyItem.id??0,FromUserId: loginResponse.data!.userID),
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
            //await dashboardController.getCryptoBalanceApi(currencyItem.id??0,false);
            Utility.INSTANCE.showResponseDetailDialog("Transfer Details", response);
            // for(var item in cryptoBalanceList) {
            //   await  dashboardController.getCryptoBalanceApi(item.id??0,true, false);
            // }

            await dashboardController.currencyList(true,(){
              getCryptoList();
            });
            await dashboardController.balance(true);
            dashboardController.isBalCryptoApi=true;
          }

        } else if (action == TypeActions.INSTANCE.ERROR) {
          Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
        } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
          Utility.INSTANCE.dialogIconOneButton(
              "wifi_error", "Network Error", "No Internet Connection", "Cancel");
        }
      });
    /*}*/

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

    super.dispose();
  }


}
