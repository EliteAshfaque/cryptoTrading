
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/AppSessionBasicRequest.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/balance/BalanceResponse.dart';
import '../../api/model/currencyList/GetCurrencyListResponse.dart';
import '../../api/model/currencyList/LiveRateData.dart';
import '../../api/model/dashboardData/DashboardData.dart';
import '../../api/model/dashboardData/StakeBalanceResponse.dart';
import '../../api/model/login/LoginData.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import '../pinPassword/ChangePinPass.dart';

class DashboardApi{
  GetStorage storage = Get.find();
  PackageInfo packageInfo = Get.find();


  Future<void> emailVerify(LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.emailVerify(BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session,
        loginData.sessionID, APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response.msg??"Verification link sent on your email id");
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

  Future<void> balance(bool isFromRefresh,LoginData loginData,size, Function? callBack) async {
    if(isFromRefresh==false){
    if(Get.isRegistered<BalanceResponse>(tag: BALANCE_DATA)){
      BalanceResponse response =await Get.find<BalanceResponse>(tag: BALANCE_DATA);
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response);
      }
    } else if(storage.hasData(BALANCE_DATA)){
      BalanceResponse response =BalanceResponse.fromJson(await storage.read(BALANCE_DATA));
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response);
      }
      await Get.delete<BalanceResponse>(tag: BALANCE_DATA,force: true);
      await Get.putAsync<BalanceResponse>(() async {return response;}, tag: BALANCE_DATA,permanent: true);
    }}
    await balanceApi( loginData,size,  callBack);
  }

  Future<void> balanceApi(LoginData loginData,size, Function? callBack) async {


    await ApiClientConst.getApiClient()?.balance(BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if(response.isPN==true){
          if(storage.hasData(PIN_SET)==true){
            await storage.remove(PIN_SET);
          }
          ChangePinPass.INSTANCE.showChangePinPassDialog(  size, "Update PIN Password","You have not created PIN Password or may be expired, Please set first before using this app.", false,() async {

              if(storage.hasData(PIN_SET)==false){
                await storage.write(PIN_SET, true);
            }
            await balanceApi( loginData,size,  callBack);
          });
        }else if(response.isPasswordExpired==true){
          ChangePinPass.INSTANCE.showChangePassDialog("Change Password","Your password has been expired, Please change before using this app.",false,null);
        }
        else if (response.statuscode == 1) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response);
          }

            if(storage.hasData(PIN_SET)==false){
              await storage.write(PIN_SET, true);
            }

          await storage.write(BALANCE_DATA, response.toJson());
          await Get.delete<BalanceResponse>(tag: BALANCE_DATA,force: true);
          await Get.putAsync<BalanceResponse>(() async {return response;}, tag: BALANCE_DATA,permanent: true);


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
  
  Future<void> dashboardData(bool isFromRefresh,LoginData loginData, Function? callBack) async {
    if(isFromRefresh==false){
    if(Get.isRegistered<DashboardData>(tag: DASHBOARD_DATA)){
      DashboardData response =await Get.find<DashboardData>(tag: DASHBOARD_DATA);
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response);
      }
    } else if(storage.hasData(DASHBOARD_DATA)){
      DashboardData response = DashboardData.fromJson(await storage.read(DASHBOARD_DATA));
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response);
      }
      await Get.delete<DashboardData>(tag: DASHBOARD_DATA,force: true);
      await Get.putAsync<DashboardData>(() async {return response;}, tag: DASHBOARD_DATA,permanent: true);

    }}
    await ApiClientConst.getApiClient()?.dashboardData(AppSessionBasicRequest(appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
          }
          await storage.write(DASHBOARD_DATA, response.data!.toJson());
          await Get.delete<DashboardData>(tag: DASHBOARD_DATA,force: true);
          await Get.putAsync<DashboardData>(() async {return response.data!;}, tag: DASHBOARD_DATA,permanent: true);



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

  Future<void> stakeBalance(bool isFromRefresh, LoginData loginData, Function? callBack) async {

    if(isFromRefresh==false) {
      if (Get.isRegistered<StakeBalanceResponse>(tag: STAKE_BALANCE_DATA)) {
        StakeBalanceResponse response = await Get.find<StakeBalanceResponse>(tag: STAKE_BALANCE_DATA);
        if (callBack != null) {
          callBack(TypeActions.INSTANCE.SUCCESS, response);
        }
      } else if (storage.hasData(STAKE_BALANCE_DATA)) {
        StakeBalanceResponse response = StakeBalanceResponse.fromJson(await storage.read(STAKE_BALANCE_DATA));
        if (callBack != null) {
          callBack(TypeActions.INSTANCE.SUCCESS, response);
        }
        await Get.delete<StakeBalanceResponse>(tag: STAKE_BALANCE_DATA, force: true);
        await Get.putAsync<StakeBalanceResponse>(() async {return response;}, tag: STAKE_BALANCE_DATA, permanent: true);
      }
    }
    await ApiClientConst.getApiClient()?.getStakeBalance( BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response);
          }
          await storage.write(STAKE_BALANCE_DATA, response.toJson());
          await Get.delete<StakeBalanceResponse>(tag: STAKE_BALANCE_DATA,force: true);
          await Get.putAsync<StakeBalanceResponse>(() async {return response;}, tag: STAKE_BALANCE_DATA,permanent: true);



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

  Future<void> currencyList(bool isFromRefresh,LoginData loginData, Function? callBack) async {

    if(isFromRefresh==false){
    if(Get.isRegistered<List<LiveRateData>>(tag: CURRENCY_LIST_DATA)){
      List<LiveRateData> list =await Get.find<List<LiveRateData>>(tag: CURRENCY_LIST_DATA);
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, list);
      }
    } else if(storage.hasData(CURRENCY_LIST_DATA)){
      GetCurrencyListResponse response = GetCurrencyListResponse.fromJson(await storage.read(CURRENCY_LIST_DATA));
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
      }
      await Get.delete<List<LiveRateData>>(tag: CURRENCY_LIST_DATA,force: true);
      await Get.putAsync<List<LiveRateData>>(() async {return response.data!;}, tag: CURRENCY_LIST_DATA,permanent: true);

    }}
    await ApiClientConst.getApiClient()?.currencyList(AppSessionBasicRequest(request: loginData.userID,appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if(response.data!=null && response.data!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
            await storage.write(CURRENCY_LIST_DATA, response.toJson());
            await Get.delete<List<LiveRateData>>(tag: CURRENCY_LIST_DATA, force: true);
            await Get.putAsync<List<LiveRateData>>(() async {return response.data!;}, tag: CURRENCY_LIST_DATA, permanent: true);
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Currency list is not available");
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


  Future<void> getCryptoBalance(LoginData loginData,int id,bool isFromBCBal,  Function? callBack) async {

    await ApiClientConst.getApiClient()?.getCryptoBalance(AppSessionBasicRequest(
        request: jsonDecode('{"currencyId":$id, "isFromBCBal":$isFromBCBal}'),appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if(response.data!=null ) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Balance is not available");
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

  Future<void> getLiveRate(int fromCurrId,int toCurrId,LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getLiveRate(AppSessionBasicRequest(
        request: jsonDecode('{"FromCurrId":$fromCurrId,"ToCurrId":$toCurrId}'),
        appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
            APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response);
          }


        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
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
      ApiUtiMethod.INSTANCE.handleError(e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }

  Future<void> getWalletDepositCurrencyMapping(int id,LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getWalletDepositCurrencyMapping(AppSessionBasicRequest(
        request: id,
        appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
            APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
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
      ApiUtiMethod.INSTANCE.handleError(e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }
}
