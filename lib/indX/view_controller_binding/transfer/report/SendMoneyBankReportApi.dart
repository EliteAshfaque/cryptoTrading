import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../Api/ApiUtilMethod.dart';
import '../../../Api/TypeActions.dart';
import '../../../api/ApiClientConst.dart';
import '../../../api/model/login/LoginData.dart';
import '../../../api/model/transfer/DisputeRequest.dart';
import '../../../api/model/transfer/SendMoneyBankReportRequest.dart';
import '../../../common/ConstantString.dart';
import '../../../utils/DialogBuilder.dart';
import '../../../utils/Utility.dart';

class SendMoneyBankReportApi {
  GetStorage storage = Get.find();
  PackageInfo packageInfo = Get.find();

  Future<void> getReport(bool isFromClick, String topRows, int status, String fromDate, String toDate,String transactionId,String accountNo,bool isRecent, LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()
        ?.getDMTReport(SendMoneyBankReportRequest(topRows, status, "0", fromDate, toDate, "", transactionId, accountNo, false, isRecent,
        loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID, APP_ID, DEVICE_ID, "",
        packageInfo.version, DEVICE_ID))
        .then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (response.dmtReport != null &&
              response.dmtReport!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.dmtReport!);
            }
          } else {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Report is not available");
            }
          }
        } else {
          if ((response.msg ?? "").contains("(redirectToLogin)")) {
            if (isFromClick) {
              DialogBuilder.INSTANCE.hideOpenDialog();
            }
            Utility.INSTANCE.dialogIconOneButtonWithCallback(
                "error", "", response.msg!, false, "Ok", (value) {
              Utility.INSTANCE.logout(storage, true);
            });
          } else {
            if (callBack != null) {
              callBack(
                  TypeActions.INSTANCE.ERROR, response.msg ?? SOMETHING_WRONG);
            }
          }
        }
      } else {
        if (callBack != null) {
          callBack(TypeActions.INSTANCE.ERROR, SOMETHING_WRONG);
        }
      }
    }, onError: (e) {
      ApiUtiMethod.INSTANCE
          .handleError(e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError(obj, callBack);
    });
  }

  Future<void> submitDispute(int? tid, String? transactionId, String otp,String refID, bool isResend, LoginData loginData, Function? callBack) async {
    await ApiClientConst.getApiClient()?.submitDispute(DisputeRequest(tid,transactionId,isResend,otp,refID, loginData.loginTypeID, loginData.userID,
        loginData.session, loginData.sessionID, APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID))
        .then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if(callBack!=null){
            callBack(TypeActions.INSTANCE.SUCCESS,response);
          }
        } else {
          if ((response.msg ?? "").contains("(redirectToLogin)")) {
            DialogBuilder.INSTANCE.hideOpenDialog();
            Utility.INSTANCE.dialogIconOneButtonWithCallback("error", "", response.msg!, false, "Ok", (value) {
              Utility.INSTANCE.logout(storage, true);
            });
          } else {
            if (callBack != null) {
              callBack(
                  TypeActions.INSTANCE.ERROR, response.msg ?? SOMETHING_WRONG);
            }
          }
        }
      } else {
        if (callBack != null) {
          callBack(TypeActions.INSTANCE.ERROR, SOMETHING_WRONG);
        }
      }
    }, onError: (e) {
      ApiUtiMethod.INSTANCE
          .handleError(e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError(obj, callBack);
    });
  }
}
