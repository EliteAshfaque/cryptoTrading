import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/login/LoginData.dart';
import '../../api/model/support/CallMeRqstRequest.dart';
import '../../api/model/support/Change2FARequest.dart';
import '../../api/model/support/CompanyProfileData.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';

class SupportApi{

  PackageInfo packageInfo = Get.find();

  Future<void> change2FA(GetStorage storage,bool is2FA, String otp, String refId,LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.change2FA(Change2FARequest(is2FA,otp,refId,loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
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

  Future<void> getCompanyDetails(GetStorage storage,LoginData loginData, Function? callBack) async {
    if(Get.isRegistered<CompanyProfileData>(tag: COMPANY_PROFILE_DATA)){
      CompanyProfileData data = Get.find<CompanyProfileData>(tag: COMPANY_PROFILE_DATA);
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, data);
      }
    } else if(storage.hasData(COMPANY_PROFILE_DATA)){
      CompanyProfileData data =CompanyProfileData.fromJson(await storage.read(COMPANY_PROFILE_DATA));
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, data);
      }
      await Get.delete<CompanyProfileData>(tag: COMPANY_PROFILE_DATA,force: true);
      await Get.putAsync<CompanyProfileData>(() async {return data;}, tag: COMPANY_PROFILE_DATA,permanent: true);

    }
    await ApiClientConst.getApiClient()?.getCompanyProfile(BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response.companyProfile!);
          }
          await storage.write(COMPANY_PROFILE_DATA, response.companyProfile!.toJson());
          await Get.delete<CompanyProfileData>(tag: COMPANY_PROFILE_DATA,force: true);
          await Get.putAsync<CompanyProfileData>(() async {return response.companyProfile!;}, tag: COMPANY_PROFILE_DATA,permanent: true);
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


  Future<void> callMeRqst(GetStorage storage,String mobileNo,LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.callMeRequest(CallMeRqstRequest(mobileNo,loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response.msg??"Request Submitted");
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
