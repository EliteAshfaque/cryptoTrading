
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/AppSessionBasicRequest.dart';
import '../../api/model/swap/SwappingCurrencyListResponse.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';

class SwapApi{
  GetStorage storage = Get.find();
  Future<void> getSwappingCurrencyList(AppSessionBasicRequest request, Function? callBack) async {
    if(Get.isRegistered<SwappingCurrencyListResponse>(tag: SWAPPING_CURRENCY_DATA)){
      SwappingCurrencyListResponse response =await Get.find<SwappingCurrencyListResponse>(tag: SWAPPING_CURRENCY_DATA);
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
      }
    } else if(storage.hasData(SWAPPING_CURRENCY_DATA)){
      SwappingCurrencyListResponse response = SwappingCurrencyListResponse.fromJson(await storage.read(SWAPPING_CURRENCY_DATA));
      if (callBack != null) {
        callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
      }
      await Get.delete<SwappingCurrencyListResponse>(tag: SWAPPING_CURRENCY_DATA,force: true);
      await Get.putAsync<SwappingCurrencyListResponse>(() async {return response;}, tag: SWAPPING_CURRENCY_DATA,permanent: true);

    }
    await ApiClientConst.getApiClient()?.getSwappingCurrencyList(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
          if(response.data!=null && response.data!.isNotEmpty) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response.data!);
            }
            await storage.write(SWAPPING_CURRENCY_DATA, response.toJson());
            await Get.delete<SwappingCurrencyListResponse>(tag: SWAPPING_CURRENCY_DATA,force: true);
            await Get.putAsync<SwappingCurrencyListResponse>(() async {return response;}, tag: SWAPPING_CURRENCY_DATA,permanent: true);

          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR,  SOMETHING_WRONG);
            }
          }

        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
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
      ApiUtiMethod.INSTANCE.handleError(e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }

  Future<void> getSwappingCurrencyConversion(AppSessionBasicRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getSwappingCurrencyConversion(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response);
            }
        } else {
          if((response.msg??"").contains("(redirectToLogin)")){
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
      ApiUtiMethod.INSTANCE.handleError(e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }

  Future<void> submitBuySell(AppSessionBasicRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.submitBuySell(request).then((response) async {
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
      ApiUtiMethod.INSTANCE.handleError(e, callBack); // Original error.// Oops, new error.
    }).catchError((Object obj) {
      ApiUtiMethod.INSTANCE.handleError( obj, callBack);
    });
  }




}
