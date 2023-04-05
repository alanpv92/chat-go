

import 'package:chatgoclient/data/custom%20types/custom_types.dart';
import 'package:chatgoclient/data/exceptions/app_newtork.dart';
import 'package:chatgoclient/manager/api.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/services/network/app_hasura_interceptor.dart';

import 'package:dartz/dartz.dart';
import 'package:hasura_connect/hasura_connect.dart';

class AppHasuraConnect {
  AppHasuraConnect._();
  static final AppHasuraConnect instance = AppHasuraConnect._();
  factory AppHasuraConnect() => instance;

  final HasuraConnect _hasuraConnect = HasuraConnect(ApiManger.graphqlUrl,
      interceptors: [AppHasuraInterceptor()]);

  Future<Either<AppNetworkException, Map<String, dynamic>>> query(
      {required String query}) async {
    try {
      final response = await _hasuraConnect.query(query);
      if (response['errors'] != null) {
        return left(AppNetworkException(
            message: TextManger.instance.randomError, status: 400));
      } else {
     
        return right(response['data']);
      }
    } catch (e) {
      return left(AppNetworkException(
          message: TextManger.instance.randomError, status: 400));
    }
  }

  Future<Either<AppNetworkException, Map<String, dynamic>>> mutation(
      {required String query}) async {
    try {
      final response = await _hasuraConnect.mutation(query);
      if (response['errors'] != null) {
        return left(AppNetworkException(
            message: TextManger.instance.randomError, status: 400));
      } else {
        return right(response['data']);
      }
    } catch (e) {
      return left(AppNetworkException(
          message: TextManger.instance.randomError, status: 400));
    }
  }

  Future<HasuraSubscriptionResponse> subscription(
      {required String query}) async {
    try {
      final response = await _hasuraConnect.subscription(query);
      return right(response);
    } catch (e) {
      return left(AppNetworkException(
          message: TextManger.instance.randomError, status: 400));
    }
  }
}
