import 'package:cryptox/api/base.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/bottom_bar.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/util/loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class TokenInterceptor extends Interceptor {

  final BuildContext context;

  TokenInterceptor({required this.context});

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {print('REQUEST[${options.method}] => PATH: ${options.path}');}
    // Checking token...
    String token = await getUserToken();
    if (token == KeyNotFound) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
      cleanSharedPrefs();
      // apiCalls.flush();
      showToast("Failed to get token locally.", gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return handler.reject(DioError(requestOptions: options,error: "Failed to get token locally."));
    }else {
      options.headers["Authorization"] = 'Bearer $token';
    }

    // Checking session Id...
    String sessionKey = await getValueForKey(sessionId);
    if (sessionKey == KeyNotFound) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
      cleanSharedPrefs();
      showToast("Failed to get session Id locally.", gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
      return handler.reject(DioError(requestOptions: options,error: "Failed to get session Id locally."));
    }else {
      options.headers["sessionid"] = sessionKey;
    }
    if(handler.isCompleted) return;
    return handler.next(options);
  }

  @override
  dynamic onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      print(response.data);
    }
    if (!response.data['success']) {
      ErrorBase res = ErrorBase.fromJson(response.data);
      if (res.result.error.contains('jwt') || res.result.error.toLowerCase()
          .contains('token') || res.result.error == "Users cannot call admin API." ||
          res.result.error.toLowerCase().replaceAll(RegExp(r'\s+'), '') == 'sessionexpired,pleaseloginagain.') {
        cleanSharedPrefs().then((value) {
          LoadingOverlay.hideLoader(context);
          if(value) {
            Navigator.pushReplacement(context,
                PageTransition(type: PageTransitionType.fade, child: BottomBar()));
          }else {
            Navigator.pushNamedAndRemoveUntil(context, '/login',(Route<dynamic> route) => false);
          }
        });
        // apiCalls.flush();
        return handler.reject(DioError(error: res.result.error,requestOptions: response.requestOptions));
      }
    }
    return handler.next(response);
  }

  @override
  dynamic onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');}
    return handler.next(err);
  }
}
