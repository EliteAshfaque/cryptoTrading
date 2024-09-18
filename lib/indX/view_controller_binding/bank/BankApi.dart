


import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/bank/BankData.dart';
import '../../api/model/bank/BankResponse.dart';
import '../../api/model/login/LoginData.dart';
import '../../common/ConstantString.dart';
import '../../utils/Utility.dart';

class BankApi{
  GetStorage storage = Get.find();
  PackageInfo packageInfo = Get.find();
  Future<void> getBank(LoginData loginData, Function? callBack) async {
    if(Get.isRegistered<List<BankData>>(tag: BANK_DATA)){
      List<BankData> list = Get.find<List<BankData>>(tag: BANK_DATA);
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, list);
      }
    } else if(storage.hasData(BANK_DATA)){
      BankResponse response =BankResponse.fromJson(await storage.read(BANK_DATA));
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response.bankMasters!);
      }
      await Get.delete<List<BankData>>(tag: BANK_DATA,force: true);
      await Get.putAsync<List<BankData>>(() async {return response.bankMasters!;}, tag: BANK_DATA,permanent: true);

    }
    await ApiClientConst.getApiClient()?.bankList(BasicRequest(loginData.loginTypeID, loginData.userID, loginData.session, loginData.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.bankMasters!=null && response.bankMasters!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.bankMasters);
            }
            await storage.write(BANK_DATA, response.toJson());
            await Get.delete<List<BankData>>(tag: BANK_DATA, force: true);
            await Get.putAsync<List<BankData>>(() async {return response.bankMasters!;}, tag: BANK_DATA, permanent: true);
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Bank is not available");
            }
          }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
            Utility.INSTANCE.dialogIconOneButtonWithCallback("error","", response.msg!,false, "Ok",(value){
              Utility.INSTANCE.logout(storage,true);
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
