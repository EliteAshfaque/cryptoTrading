import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../Api/ApiUtilMethod.dart';
import '../../../Api/TypeActions.dart';
import '../../../api/ApiClientConst.dart';
import '../../../api/model/AppSessionBasicRequest.dart';
import '../../../api/model/BasicRequest.dart';
import '../../../api/model/login/LoginData.dart';
import '../../../api/model/transfer/WithdrawalReportRequest.dart';
import '../../../common/ConstantString.dart';
import '../../../utils/DialogBuilder.dart';
import '../../../utils/Utility.dart';

class WalletOrCryptoWithdrawalReportApi {
  GetStorage storage = Get.find();
  PackageInfo packageInfo = Get.find();

  Future<void> getWalletWithdrawalReport(
      
      bool isFromClick,
      int currencyId,
      int walletId,
      String fromDate,
      String toDate,
      LoginData loginData,
      Function? callBack) async {
    

    await ApiClientConst.getApiClient()
        ?.withdrawalWalletReport(AppSessionBasicRequest(
            request: WithdrawalReportRequest(
                ToDate: toDate,
                FromDate: fromDate,
                CurrencyId: currencyId,
                WalletId: walletId),
            appSession: BasicRequest(
                loginData.loginTypeID,
                loginData.userID,
                loginData.session,
                loginData.sessionID,
                APP_ID,
                DEVICE_ID,
                "",
                packageInfo.version,
                DEVICE_ID)))
        .then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (response.withdrawalWalletReport != null &&
              response.withdrawalWalletReport!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS,
                  response.withdrawalWalletReport!);
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

  Future<void> getCryptoWithdrawalReport(
      bool isFromClick,
      int currencyId,
      int walletId,
      String fromDate,
      String toDate,
      LoginData loginData,
      Function? callBack) async {
    await ApiClientConst.getApiClient()
        ?.withdrawalCryptoReport(AppSessionBasicRequest(
            request: WithdrawalReportRequest(
                ToDate: toDate,
                FromDate: fromDate,
                CurrencyId: currencyId,
                WalletId: walletId),
            appSession: BasicRequest(
                loginData.loginTypeID,
                loginData.userID,
                loginData.session,
                loginData.sessionID,
                APP_ID,
                DEVICE_ID,
                "",
                packageInfo.version,
                DEVICE_ID)))
        .then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (response.withdrawalCryptoReport != null &&
              response.withdrawalCryptoReport!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS,
                  response.withdrawalCryptoReport!);
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
}
