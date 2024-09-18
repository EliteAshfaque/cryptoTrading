import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/login/LoginData.dart';
import '../../api/model/login/LoginWithOTPRequest.dart';
import '../../api/model/userDetails/LogoutRequest.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';

class SplashApi{

  Future<void> logout(GetStorage storage,PackageInfo packageInfo,String type,LoginData loginData, Function? callBack) async {
    await ApiClientConst.getApiClient()?.logout(LogoutRequest( type,loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          Utility.INSTANCE.logout(storage, false);
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

  Future<void> sendOTP(LoginWithOTPRequest request, Function? callBack) async {
    await ApiClientConst.getApiClient()?.loginWithOTP(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response);
          }

        }else if (response.statuscode == -2) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.REGISTER, response);
          }
        } else {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.ERROR, response.msg ?? SOMETHING_WRONG);
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

  Future<void> validateLoginWithOTP(storage,LoginWithOTPRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.validateLoginWithOTP(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          Get.put(response,permanent: true);
          await storage.write(LOGIN_DATA, response.toJson());
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response);
          }

        } else {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.ERROR, response.msg ?? SOMETHING_WRONG);
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
  /*Future<void> signup(SignupRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.signup(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response);
          }

        } else {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.ERROR, response.msg ?? SOMETHING_WRONG);
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
  }*/
}
