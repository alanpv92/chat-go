import 'package:chatgoclient/data/custom%20types/custom_types.dart';

abstract class AppNetworkInterface {
  Future<AppNetworkResponse> getRequest({required String path,required Map<String,dynamic> args});
  Future<AppNetworkResponse> postRequest({required String path,required Map<String,dynamic> args});
  Future<AppNetworkResponse> patchRequest({required String path,required Map<String,dynamic> args});
  Future<AppNetworkResponse> deleteRequest({required String path,required Map<String,dynamic> args});
}
