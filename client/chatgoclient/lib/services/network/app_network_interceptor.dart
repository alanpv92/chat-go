import 'dart:developer';

import 'package:chatgoclient/manager/api.dart';
import 'package:dio/dio.dart';

class AppNetworkInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(response.requestOptions.path.toString());
    if (response.requestOptions.path.contains(ApiManger.loginUrl) ||
        response.requestOptions.path.contains(ApiManger.registerUrl)) {
      Map<String, dynamic> data = response.data ?? {};
      if (data.containsKey('token')) {
        //create an function in usermangement to store token
      }
    }
    super.onResponse(response, handler);
  }

  
}
