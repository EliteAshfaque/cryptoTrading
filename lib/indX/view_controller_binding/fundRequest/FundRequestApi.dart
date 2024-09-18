import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/fundRequest/BankPaymentModeRequest.dart';
import '../../api/model/fundRequest/FundRequestRequest.dart';
import '../../api/model/login/LoginData.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';

class FundRequestApi{


  GetStorage storage = Get.find();

  Future<void> getBankAndMode(PackageInfo packageInfo,LoginData loginData, Function? callBack) async {
    /*if(Get.isRegistered<List<Bank>>(tag: BANK_AND_PAYMENT_MODE)){
      List<Bank> list = Get.find<List<Bank>>(tag: BANK_AND_PAYMENT_MODE);
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, list);
      }
    } else if(storage.hasData(BANK_AND_PAYMENT_MODE)){
      BankPaymentModeResponse response =BankPaymentModeResponse.fromJson(await storage.read(BANK_AND_PAYMENT_MODE));
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response.banks!);
      }
      await Get.delete<List<Bank>>(tag: BANK_AND_PAYMENT_MODE,force: true);
      await Get.putAsync<List<Bank>>(() async {return response.banks!;}, tag: BANK_AND_PAYMENT_MODE,permanent: true);

    }*/
    await ApiClientConst.getApiClient()?.getBankAndPaymentMode(BankPaymentModeRequest(1,loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1 ) {

          if(response.banks!=null && response.banks!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.banks!);
            }
            /*await storage.write(BANK_AND_PAYMENT_MODE, response.toJson());
            await Get.delete<BankPaymentModeResponse>(tag: BANK_AND_PAYMENT_MODE, force: true);
            await Get.putAsync<List<Bank>>(() async {return response.banks!;}, tag: BANK_AND_PAYMENT_MODE, permanent: true);*/
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Bank is not available");
            }
          }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            Utility.INSTANCE.dialogIconOneButtonWithCallback("error","", response.msg!,false, "Ok",(value){
              Utility.INSTANCE.logout(storage,true);
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
      ApiUtiMethod.INSTANCE.handleError(e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }


  Future<void> submitFundRequest(File? file,FundRequestRequest request, Function? callBack) async {



    await ApiClientConst.getApiClient()?.submitFundRequest(request,file: file).then((response) async {
      if (response != null) {
        if (response.statuscode == 1 ) {

            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.msg??"Success");
            }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            DialogBuilder.INSTANCE.hideOpenDialog();
            Utility.INSTANCE.dialogIconOneButtonWithCallback("error","", response.msg!,false, "Ok",(value){
              Utility.INSTANCE.logout(storage,true);
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
      ApiUtiMethod.INSTANCE.handleError(e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }


}
