import 'dart:developer';

import 'package:chatgoclient/data/custom%20types/custom_types.dart';
import 'package:chatgoclient/data/exceptions/app_newtork.dart';
import 'package:chatgoclient/data/interfaces/app_network.dart';
import 'package:chatgoclient/manager/api.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/services/network/app_network_interceptor.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AppNetwork implements AppNetworkInterface {
  AppNetwork._();
  static AppNetwork instance = AppNetwork._();
  factory AppNetwork() => instance;
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiManger.apiBaseUrl))
    ..interceptors.add(AppNetworkInterceptor());
  @override
  Future<AppNetworkResponse> deleteRequest(
      {required String path, required Map<String, dynamic> args}) async {
    try {
      final response = await _dio.delete(path, data: args);

      return right(response.data);
    } on DioError catch (e) {
      log('error is ${e.response?.data}');
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['error'] != null &&
          e.response!.data['error'] != '') {
        return left(AppNetworkException(
            message: e.response!.data['error'],
            status: e.response!.statusCode ?? 400));
      } else {
        return left(AppNetworkException(
            message: TextManger.instance.randomError,
            status: e.response?.statusCode ?? 400));
      }
    } catch (e) {
      return left(AppNetworkException(
          message: TextManger.instance.randomError, status: 400));
    }
  }

  @override
  Future<AppNetworkResponse> getRequest(
      {required String path, required Map<String, dynamic> args}) async {
    try {
      final response = await _dio.get(path, data: args);
      log("response is $response");
      return right(response.data);
    } on DioError catch (e) {
      log('error is ${e.response?.data}');
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['error'] != null &&
          e.response!.data['error'] != '') {
        return left(AppNetworkException(
            message: e.response!.data['error'],
            status: e.response!.statusCode ?? 400));
      } else {
        return left(AppNetworkException(
            message: TextManger.instance.randomError,
            status: e.response?.statusCode ?? 400));
      }
    } catch (e) {
      return left(AppNetworkException(
          message: TextManger.instance.randomError, status: 400));
    }
  }

  @override
  Future<AppNetworkResponse> patchRequest(
      {required String path, required Map<String, dynamic> args}) async {
    try {
      final response = await _dio.patch(path, data: args);
      log("response is $response");
      return right(response.data);
    } on DioError catch (e) {
      log('error is ${e.response?.data}');
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['error'] != null &&
          e.response!.data['error'] != '') {
        return left(AppNetworkException(
            message: e.response!.data['error'],
            status: e.response!.statusCode ?? 400));
      } else {
        return left(AppNetworkException(
            message: TextManger.instance.randomError,
            status: e.response?.statusCode ?? 400));
      }
    } catch (e) {
      return left(AppNetworkException(
          message: TextManger.instance.randomError, status: 400));
    }
  }

  @override
  Future<AppNetworkResponse> postRequest(
      {required String path, required Map<String, dynamic> args}) async {
    try {
      final response = await _dio.post(path, data: args);
      return right(response.data);
    } on DioError catch (e) {
      log('error is ${e.response?.data}');
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['error'] != null &&
          e.response!.data['error'] != '') {
        return left(AppNetworkException(
            message: e.response!.data['error'],
            status: e.response!.statusCode ?? 400));
      } else {
        return left(AppNetworkException(
            message: TextManger.instance.randomError,
            status: e.response?.statusCode ?? 400));
      }
    } catch (e) {
      return left(AppNetworkException(
          message: TextManger.instance.randomError, status: 400));
    }
  }
}
