
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/login/LoginData.dart';
import '../../api/model/support/ReferralContentResponse.dart';
import '../../common/ConstantString.dart';
import '../../utils/Utility.dart';

class InviteReferralApi{
  GetStorage storage = Get.find();
  PackageInfo packageInfo = Get.find();

  Future<void> getReferalContent(LoginData loginData, Function? callBack) async {
    if(Get.isRegistered<ReferralContentResponse>(tag: REFERRAL_CONTENT_DATA)){
      ReferralContentResponse data = Get.find<ReferralContentResponse>(tag: REFERRAL_CONTENT_DATA);
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, data);
      }
    } else if(storage.hasData(REFERRAL_CONTENT_DATA)){
      ReferralContentResponse data =ReferralContentResponse.fromJson(await storage.read(REFERRAL_CONTENT_DATA));
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, data);
      }
      await Get.delete<ReferralContentResponse>(tag: REFERRAL_CONTENT_DATA,force: true);
      await Get.putAsync<ReferralContentResponse>(() async {return data;}, tag: REFERRAL_CONTENT_DATA,permanent: true);

    }
    await ApiClientConst.getApiClient()?.getReferralContent(BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response);
          }
          await storage.write(REFERRAL_CONTENT_DATA, response.toJson());
          await Get.delete<ReferralContentResponse>(tag: REFERRAL_CONTENT_DATA,force: true);
          await Get.putAsync<ReferralContentResponse>(() async {return response;}, tag: REFERRAL_CONTENT_DATA,permanent: true);
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
}
