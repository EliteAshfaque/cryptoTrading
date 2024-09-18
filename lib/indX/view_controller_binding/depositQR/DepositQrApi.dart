
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/AppSessionBasicRequest.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/currencyList/LiveRateData.dart';
import '../../api/model/depositQr/GetTechnologyQrResponse.dart';
import '../../api/model/login/LoginData.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';

class DepositQrApi{
  PackageInfo packageInfo = Get.find();
  GetStorage storage = Get.find();

  Future<void> genrateQr(bool isFromClick,bool isFromWallet,LiveRateData item,LoginData loginData, Function? callBack) async {
    String storageKey = "${item.currencyName}_${item.technologyId}_${(isFromWallet==true?item.currencyId:item.id)}_${loginData.userID??0}";
    if(Get.isRegistered<GetTechnologyQrResponse>(tag: storageKey)){
      GetTechnologyQrResponse response = Get.find<GetTechnologyQrResponse>(tag: storageKey);
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response);
      }
    } else if(storage.hasData(storageKey)){
      GetTechnologyQrResponse response =GetTechnologyQrResponse.fromJson(await storage.read(storageKey));
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response);
      }
      await Get.delete<GetTechnologyQrResponse>(tag: storageKey,force: true);
      await Get.putAsync<GetTechnologyQrResponse>(() async {return response;}, tag: storageKey,permanent: true);

    }else{
      if(isFromClick){
        DialogBuilder.INSTANCE.showLoadingIndicator('', 'Generating QR ...', isCancelabel: false);
      }else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DialogBuilder.INSTANCE.showLoadingIndicator('', 'Generating QR ...', isCancelabel: false);
        });
      }
    }

    await ApiClientConst.getApiClient()?.generateTechnologyQr(AppSessionBasicRequest(
      request: item.technologyId??0,appSession: BasicRequest(loginData.loginTypeID,loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (response != null) {
        if (response.statuscode == 1) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response,isFromApi: true);
            }
            await storage.write(storageKey, response.toJson());
            await Get.delete<GetTechnologyQrResponse>(tag: storageKey, force: true);
            await Get.putAsync<GetTechnologyQrResponse>(() async {return response;}, tag: storageKey, permanent: true);

        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            DialogBuilder.INSTANCE.hideOpenDialog();
            Utility.INSTANCE.dialogIconOneButtonWithCallback("error","", response.msg!,false, "Ok",(value){
              Utility.INSTANCE.logout(Get.find(),true);
            });
          }else {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, response.msg ?? SOMETHING_WRONG);
            }
          }
        }
      } else {
        if (callBack != null) {
          callBack(TypeActions.INSTANCE.ERROR, SOMETHING_WRONG);
        }
      }
    }, onError: (e) {
      DialogBuilder.INSTANCE.hideOpenDialog();
      ApiUtiMethod.INSTANCE.handleError(e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      DialogBuilder.INSTANCE.hideOpenDialog();
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }

  Future<void> checkBalanceAutoDeposit(int id,LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.checkBalanceAutoDeposit(AppSessionBasicRequest(
      request: id,appSession: BasicRequest(loginData.loginTypeID,loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (response != null) {
        if (response.statuscode == 1) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response);
            }

        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            DialogBuilder.INSTANCE.hideOpenDialog();
            Utility.INSTANCE.dialogIconOneButtonWithCallback("error","", response.msg!,false, "Ok",(value){
              Utility.INSTANCE.logout(Get.find(),true);
            });
          }else {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, response.msg ?? SOMETHING_WRONG);
            }
          }
        }
      } else {
        if (callBack != null) {
          callBack(TypeActions.INSTANCE.ERROR, SOMETHING_WRONG);
        }
      }
    }, onError: (e) {
      DialogBuilder.INSTANCE.hideOpenDialog();
      ApiUtiMethod.INSTANCE.handleError(e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      DialogBuilder.INSTANCE.hideOpenDialog();
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }






}
