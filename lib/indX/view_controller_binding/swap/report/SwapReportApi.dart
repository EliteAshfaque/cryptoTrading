
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../Api/ApiUtilMethod.dart';
import '../../../Api/TypeActions.dart';
import '../../../api/ApiClientConst.dart';
import '../../../api/model/BasicRequest.dart';
import '../../../api/model/login/LoginData.dart';
import '../../../common/ConstantString.dart';
import '../../../utils/Utility.dart';

class SwapReportApi {
  GetStorage storage = Get.find();
  PackageInfo packageInfo = Get.find();

  Future<void> getSwapReport(LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getSwapReport(BasicRequest(
        loginData.loginTypeID,
        loginData.userID,
        loginData.session,
        loginData.sessionID,
        APP_ID,
        DEVICE_ID,
        "",
        packageInfo.version,
        DEVICE_ID,isSeller: true)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (response.swapReport != null && response.swapReport!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.swapReport!);
            }
          } else {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Report is not available");
            }
          }
        } else {
          if ((response.msg ?? "").contains("(redirectToLogin)")) {
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
