import '../../api/ApiClientConst.dart';
import '../../api/ApiUtilMethod.dart';
import '../../api/TypeActions.dart';
import '../../api/model/signup/RoleRequest.dart';
import '../../api/model/signup/SignupRequest.dart';
import '../../common/ConstantString.dart';

class SignupApi{

  Future<void> role(RoleRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.getRole(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
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

  Future<void> signup(SignupRequest request, Function? callBack) async {

    await ApiClientConst.getApiClient()?.signup(request).then((response) async {
      if (response != null) {
        if (response.statuscode == 1) {
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


}
