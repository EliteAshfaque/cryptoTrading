
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/login/LoginData.dart';
import '../../api/model/recentPinActivity/RecentPinActivityData.dart';
import '../../api/model/recentPinActivity/RecentPinActivityResponse.dart';
import '../../common/ConstantString.dart';
import '../../utils/Utility.dart';

class RecentPinActivityApi{
  PackageInfo packageInfo = Get.find();
  GetStorage storage = Get.find();

  Future<void> getReport(LoginData loginData,bool isFromClick, Function? callBack) async {

    if(Get.isRegistered<List<RecentPinActivityData>>(tag: RECENT_PIN_ACTIVITY_DATA)){
      List<RecentPinActivityData> list = Get.find<List<RecentPinActivityData>>(tag: RECENT_PIN_ACTIVITY_DATA);
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, list);
      }
    } else if(storage.hasData(RECENT_PIN_ACTIVITY_DATA)){
      RecentPinActivityResponse response =RecentPinActivityResponse.fromJson(await storage.read(RECENT_PIN_ACTIVITY_DATA));
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
      }
      await Get.delete<List<RecentPinActivityData>>(tag: RECENT_PIN_ACTIVITY_DATA,force: true);
      await Get.putAsync<List<RecentPinActivityData>>(() async {return response.data!;}, tag: RECENT_PIN_ACTIVITY_DATA,permanent: true);

    }/*else{
      if(isFromClick){
        DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Recent Pin Activity ...', isCancelabel: false);
      }else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Recent Pin Activity ...', isCancelabel: false);
        });
      }
    }*/
    await ApiClientConst.getApiClient()?.getRecentPinActivity(BasicRequest(loginData.loginTypeID,loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      /*DialogBuilder.INSTANCE.hideOpenDialog();*/
      if (response != null) {
        if (response.statuscode == 1) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
            await storage.write(RECENT_PIN_ACTIVITY_DATA, response.toJson());
            await Get.delete<List<RecentPinActivityData>>(tag: RECENT_PIN_ACTIVITY_DATA, force: true);
            await Get.putAsync<List<RecentPinActivityData>>(() async {return response.data!;}, tag: RECENT_PIN_ACTIVITY_DATA, permanent: true);

        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            /*DialogBuilder.INSTANCE.hideOpenDialog();*/
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
     /* DialogBuilder.INSTANCE.hideOpenDialog();*/
      ApiUtiMethod.INSTANCE.handleError(e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
    /*  DialogBuilder.INSTANCE.hideOpenDialog();*/
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }








}
