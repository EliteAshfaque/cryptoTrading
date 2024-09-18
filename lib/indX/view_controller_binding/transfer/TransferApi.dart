
import 'package:get/get.dart';

import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/AppSessionBasicRequest.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/transfer/UpdateBankRequest.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';

class TransferApi{

  Future<void> deleteBankAccount(UpdateBankRequest request, Function? callBack) async {
    await ApiClientConst.getApiClient()?.deleteBankAccount(request).then((response) async {
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

  Future<void> getBankAccounts(BasicRequest request, Function? callBack) async {
    await ApiClientConst.getApiClient()?.getBankAccounts(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {

          if(response.data!=null && response.data!.isNotEmpty){
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.SUCCESS, response);
            }
          }else{
            if (callBack != null) {
              callBack(TypeActions.INSTANCE.ERROR, "Account is not available");
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

  Future<void> getUserDetails(AppSessionBasicRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.dataByUserid(request).then((response) async {
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

  Future<void> transfer(AppSessionBasicRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.cryptoWithdrawal(request).then((response) async {
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

  Future<void> transferCryptoDb(AppSessionBasicRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.withdrawalCryptoDb(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1 || response.statuscode==-3) {
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
  Future<void> transferCrypto(AppSessionBasicRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.withdrawalCrypto(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1 || response.statuscode==-3) {
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
