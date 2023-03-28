

import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/manager/api.dart';
import 'package:dio/dio.dart';

class AppNetworkInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {

    if (response.requestOptions.path.contains(ApiManger.loginUrl) ||
        response.requestOptions.path.contains(ApiManger.registerUrl)) {
      Map<String, dynamic> data = response.data ?? {};
      if (data.containsKey('token')) {
        await UserMangementController.instance.storeToken(token: data['token']);
      }
    }
    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = UserMangementController.instance.token;
    if(token!=null){
    options.headers["authorization"] = "Bearer $token";
    }
    super.onRequest(options, handler);
  }
}
