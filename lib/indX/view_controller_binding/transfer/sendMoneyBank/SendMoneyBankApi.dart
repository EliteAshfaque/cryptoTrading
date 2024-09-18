
import 'package:get/get.dart';

import '../../../Api/ApiUtilMethod.dart';
import '../../../Api/TypeActions.dart';
import '../../../api/ApiClientConst.dart';
import '../../../api/model/AppSessionBasicRequest.dart';
import '../../../common/ConstantString.dart';
import '../../../utils/DialogBuilder.dart';
import '../../../utils/Utility.dart';



class SendMoneyBankApi{



  Future<void> sendMoney(AppSessionBasicRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.sendMoney(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if (callBack != null) {
            callBack(TypeActions.INSTANCE.SUCCESS, response);
          }

        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            DialogBuilder.INSTANCE.hideOpenDialog();
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
      ApiUtiMethod.INSTANCE.handleError(
           e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }


}
