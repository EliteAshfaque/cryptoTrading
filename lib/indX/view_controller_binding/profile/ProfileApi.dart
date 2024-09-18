import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/login/LoginData.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/userDetails/EditUser.dart';
import '../../api/model/userDetails/LogoutRequest.dart';
import '../../api/model/userDetails/UpdateUserRequest.dart';
import '../../api/model/userDetails/UserDetailResponse.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import '../dashboard/DashboardController.dart';

class ProfileApi{

  PackageInfo packageInfo = Get.find();

  Future<void> getProfile(GetStorage storage,LoginData loginData, Function? callBack) async {
    if(Get.isRegistered<UserDetailResponse>(tag: USER_DATA)){
      UserDetailResponse response = Get.find<UserDetailResponse>(tag: USER_DATA);
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response);
      }
    } else if(storage.hasData(USER_DATA)){
      UserDetailResponse response =UserDetailResponse.fromJson(await storage.read(USER_DATA));
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response);
      }
      await Get.delete<UserDetailResponse>(tag: USER_DATA,force: true);
      await Get.putAsync<UserDetailResponse>(() async {return response;}, tag: USER_DATA,permanent: true);

    }
    await ApiClientConst.getApiClient()?.getProfile(BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response);
          }
          await storage.write(USER_DATA, response.toJson());
          await Get.delete<UserDetailResponse>(tag: USER_DATA,force: true);
          await Get.putAsync<UserDetailResponse>(() async {return response;}, tag: USER_DATA,permanent: true);
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

  Future<void> getStoredProfile(GetStorage storage,Function? callBack) async {

    if(Get.isRegistered<UserDetailResponse>(tag: USER_DATA)){
      UserDetailResponse response = Get.find<UserDetailResponse>(tag: USER_DATA);
      if (callBack != null) {
        callBack(response);
      }
    } else if(storage.hasData(USER_DATA)){
      UserDetailResponse response =UserDetailResponse.fromJson(await storage.read(USER_DATA));
      if (callBack != null) {
        callBack(response);
      }
      await Get.delete<UserDetailResponse>(tag: USER_DATA,force: true);
      await Get.putAsync<UserDetailResponse>(() async {return response;}, tag: USER_DATA,permanent: true);

    }
  }

  Future<void> updateStoredProfile(GetStorage storage,UserDetailResponse response) async {

    await storage.write(USER_DATA, response.toJson());
    await Get.delete<UserDetailResponse>(tag: USER_DATA,force: true);
    await Get.putAsync<UserDetailResponse>(() async {return response;}, tag: USER_DATA,permanent: true);
  }

  Future<void> updateLoginData(GetStorage storage,LoginResponse response) async {

    await storage.write(LOGIN_DATA, response.toJson());
    Get.put(response,permanent: true);
    DashboardController controller =Get.find();
    controller.loginResponse=response;

  }

  Future<void> emailVerify(GetStorage storage,LoginData loginData, Function? callBack) async {

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

  Future<void> updateProfile(GetStorage storage,EditUser editUser,LoginData loginData, Function? callBack) async {
    await ApiClientConst.getApiClient()?.updateProfile(UpdateUserRequest( editUser,loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response.msg ?? "Profile Updated Successfully");
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

  Future<void> logout(GetStorage storage,String type,LoginData loginData, Function? callBack) async {
    await ApiClientConst.getApiClient()?.logout(LogoutRequest( type,loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          Utility.INSTANCE.logout(storage, true);
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
