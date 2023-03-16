import 'dart:developer';

import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:hasura_connect/hasura_connect.dart';

class AppHasuraInterceptor extends Interceptor {
  @override
  Future<void>? onConnected(HasuraConnect connect) async {
    log('hasura is connected');
  }

  @override
  Future<void>? onDisconnected() async {
    log('hasura is disconnected');
  }

  @override
  Future? onError(HasuraError request, HasuraConnect connect) async {
    return request;
  }

  @override
  Future? onRequest(Request request, HasuraConnect connect) async {
    final token = UserMangementController.instance.token;
    
    if (token != null) {
      request.headers["authorization"] = "Bearer $token";
      return request;
    }
    return request;
  }

  @override
  Future? onResponse(Response data, HasuraConnect connect) async {
    return data;
  }

  @override
  Future<void>? onSubscription(Request request, Snapshot snapshot) async {}

  @override
  Future<void>? onTryAgain(HasuraConnect connect) async {}
}
