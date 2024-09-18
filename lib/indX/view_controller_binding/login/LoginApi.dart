
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/login/LoginRequest.dart';
import '../../api/model/login/OTPRequest.dart';
import '../../api/model/login/OTPResendRequest.dart';
import '../../common/ConstantString.dart';

class LoginApi{
  GetStorage storage = Get.find();
  Future<void> login(LoginRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.login(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {


          Get.put(response,permanent: true);
          await storage.write(LOGIN_DATA, response.toJson());
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response);
          }

        }else if (response.statuscode == 2) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.OTP, response);
          }
        }else if (response.statuscode == 3) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.GAUTH, response);
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

  Future<void> validateOTP(OTPRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.validateOTP(request).then((response) async {
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

  Future<void> resendOTP(OTPResendRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.resendOTP(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response.msg??"OTP Sent Successfully");
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

  Future<void> validateGAuthPin(OTPRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.validateGAuthPin(request).then((response) async {
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
      ApiUtiMethod.INSTANCE.handleError(
           e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }

  Future<void> forgetPassword(LoginRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.forgetPassword(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response.msg??"Password sent successfully on your mobile no and email id");
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
      ApiUtiMethod.INSTANCE.handleError(
           e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }
}
