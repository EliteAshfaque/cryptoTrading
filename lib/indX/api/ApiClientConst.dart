import 'dart:io';

import 'package:cryptox/indX/api/web_service/ApiClient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClientConst {
  static ApiClient? api;
 static ApiClient? getApiClient(){
    if(api==null){
      Dio dio = Dio();
      dio.options.headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      };
      if(kDebugMode){
        dio.interceptors.add(PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90));
      }
      api = ApiClient(dio);
    }
    return api;
  }


}

