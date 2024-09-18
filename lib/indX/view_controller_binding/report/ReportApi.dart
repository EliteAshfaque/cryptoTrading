import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/AppSessionBasicRequest.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/login/LoginData.dart';
import '../../api/model/report/BusinessRequest.dart';
import '../../api/model/report/IncomeWiseReportRequest.dart';
import '../../api/model/report/ReportRequest.dart';
import '../../api/model/report/TeamRequest.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';

class ReportApi{
  GetStorage storage = Get.find();
  PackageInfo packageInfo = Get.find();

  Future<void> getLedgerReport(bool isFromClick,int walletTypeId,String topRow,String fromDate,String toDate,String txnId, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getLedgerReport(ReportRequest( walletTypeId,
       false, false, topRow, 0, 0, fromDate, toDate, txnId, "", 0, "",
        loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.ledgerReport!=null && response.ledgerReport!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.ledgerReport!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Report is not available");
            }
          }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            if(isFromClick){
              DialogBuilder.INSTANCE.hideOpenDialog();
            }
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

  Future<void> getTotalTeam(bool isFromClick,String leg, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getTotalTeam(AppSessionBasicRequest(request:  TeamRequest(Leg: leg)/*jsonDecode('{"Leg":"$leg","LevelNo":0}')*/,appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
            APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.data!=null && response.data!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Team is not available");
            }
          }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            if(isFromClick){
              DialogBuilder.INSTANCE.hideOpenDialog();
            }
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

  Future<void> getDirectTeam(bool isFromClick,String leg,String fromDate,String toDate,String status, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getDirectTeam(AppSessionBasicRequest(request:  TeamRequest(Leg: leg,FromDate: fromDate,ToDate: toDate,Status:status ),appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.data!=null && response.data!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Team is not available");
            }
          }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            if(isFromClick){
              DialogBuilder.INSTANCE.hideOpenDialog();
            }
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

  Future<void> getLevel(int incomeOpid, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getBindLevel(AppSessionBasicRequest(request: incomeOpid,appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.data!=null && response.data!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Team is not available");
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

  Future<void> getSponsorTeam(bool isFromClick,String levelNo,/*String fromDate,String toDate,*/String status, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getSponsorList(AppSessionBasicRequest(request:  TeamRequest(LevelNo: levelNo,/*FromDate: fromDate,ToDate: toDate,*/Status:status ),appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.data!=null && response.data!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Team is not available");
            }
          }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            if(isFromClick){
              DialogBuilder.INSTANCE.hideOpenDialog();
            }
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

  Future<void> getIncomeReport(bool isFromClick,int incomeCategoryId,int incomeOPid,String levelNo,String fromDate,String toDate, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getIncomeReport(IncomeWiseReportRequest(incomeCategoryId,incomeOPid,fromDate,toDate,levelNo,
        loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.incomeWiseReport!=null && response.incomeWiseReport!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.incomeWiseReport!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Income is not available");
            }
          }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            if(isFromClick){
              DialogBuilder.INSTANCE.hideOpenDialog();
            }
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

  Future<void> getOPIDList(int userid, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getOpIdByUserID(AppSessionBasicRequest(request: userid,appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.data!=null && response.data!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Team is not available");
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

  Future<void> getDirectBusinessReport(bool isFromClick,int businessType,String fromDate,String toDate, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getDirectBusiness(AppSessionBasicRequest(request:  BusinessRequest(BusinessType: businessType,FromDate: fromDate,ToDate: toDate),appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.data!=null && response.data!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Business is not available");
            }
          }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            if(isFromClick){
              DialogBuilder.INSTANCE.hideOpenDialog();
            }
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

  Future<void> getSponsorBusinessReport(bool isFromClick,int businessType,String levelNo,String sponserId,String fromDate,String toDate, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getSponsorBusiness(AppSessionBasicRequest(request:  BusinessRequest(
        BusinessType: businessType,
        FromDate: fromDate,
        ToDate: toDate,
        LevelNo: levelNo,
        SponserId: sponserId),appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.data!=null && response.data!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Business is not available");
            }
          }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            if(isFromClick){
              DialogBuilder.INSTANCE.hideOpenDialog();
            }
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

  Future<void> getBinaryBusinessReport(bool isFromClick,int businessType,String leg,String fromDate,String toDate, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getBinaryBusiness(AppSessionBasicRequest(request:  BusinessRequest(
        BusinessType: businessType,
        FromDate: fromDate,
        ToDate: toDate,
        LevelNo: "0",
        Leg:  leg),appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.data!=null && response.data!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Business is not available");
            }
          }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            if(isFromClick){
              DialogBuilder.INSTANCE.hideOpenDialog();
            }
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

  Future<void> getSelfBusinessReport(bool isFromClick, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getSelfBusiness(AppSessionBasicRequest(appSession: BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.data!=null && response.data!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Business is not available");
            }
          }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            if(isFromClick){
              DialogBuilder.INSTANCE.hideOpenDialog();
            }
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
