
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/AppSessionBasicRequest.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/login/LoginData.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';

class MyStakeApi{
  GetStorage storage = Get.find();
  PackageInfo packageInfo = Get.find();

  Future<void> getMint( LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getWithdrawalMint(BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {


            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response);
            }

        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            Utility.INSTANCE.dialogIconOneButtonWithCallback("error","", response.msg!,false, "Ok",(value){
              Utility.INSTANCE.logout(storage, true);
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

  Future<void> getMintOld( LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getWithdrawalMintOld(BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {


          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response);
          }

        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            Utility.INSTANCE.dialogIconOneButtonWithCallback("error","", response.msg!,false, "Ok",(value){
              Utility.INSTANCE.logout(storage, true);
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

  Future<void> getStakeReport( LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getStakingDetailDb(BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {


          if(response.stackingDetailList!=null && response.stackingDetailList!.isNotEmpty){
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.stackingDetailList!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Staking Details is not available");
            }
          }


        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            Utility.INSTANCE.dialogIconOneButtonWithCallback("error","", response.msg!,false, "Ok",(value){
              Utility.INSTANCE.logout(storage, true);
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

  Future<void> getStakeOldReport( LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getStakingDetailDbOld(BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if(response.stackingDetailList!=null && response.stackingDetailList!.isNotEmpty){
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.stackingDetailList!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Old Staking Details is not available");
            }
          }


        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            Utility.INSTANCE.dialogIconOneButtonWithCallback("error","", response.msg!,false, "Ok",(value){
              Utility.INSTANCE.logout(storage, true);
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

  Future<void> withdrawalMint(int withdrwalType,int walletID,String amount, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.withdrawalMint(AppSessionBasicRequest(request: jsonDecode('{"WithdrwalType":$withdrwalType,"WalletID":$walletID,"Amount":$amount}'),
        appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response);
            }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            DialogBuilder.INSTANCE.hideOpenDialog();
            Utility.INSTANCE.dialogIconOneButtonWithCallback("error","", response.msg!,false, "Ok",(value){
              Utility.INSTANCE.logout(storage, true);
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

  Future<void> withdrawalOldMint(String amount, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.withdrawalMintOld(AppSessionBasicRequest(request: amount,
        appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
            APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response);
          }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            DialogBuilder.INSTANCE.hideOpenDialog();
            Utility.INSTANCE.dialogIconOneButtonWithCallback("error","", response.msg!,false, "Ok",(value){
              Utility.INSTANCE.logout(storage, true);
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
