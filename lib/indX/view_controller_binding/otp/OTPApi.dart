
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/login/LoginData.dart';
import '../../api/model/userDetails/ChangePinPassRequest.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';

class OTPApi{
  GetStorage storage = Get.find();
  PackageInfo packageInfo =Get.find();

  Future<void> changePinPass(bool isPin ,String oldPass,String newPass,String confPass,LoginData loginData, Function? callBack) async {

    await ApiClientConst.getApiClient()?.changePinPass(ChangePinPassRequest(isPin, oldPass, newPass, confPass,
        loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID, APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if(isPin==false) {
            Utility.INSTANCE.logout(storage, true);
            Utility.INSTANCE.dialogIconOneButton("check","", response.msg ?? "Success", "Cancel");
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.msg ?? "Success");
            }
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
      ApiUtiMethod.INSTANCE.handleError(
           e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }


}
