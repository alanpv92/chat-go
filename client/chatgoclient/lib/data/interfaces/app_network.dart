import 'package:chatgoclient/data/custom%20types/custom_types.dart';

abstract class AppNetworkInterface {
  Future<AppNetworkResponse> getRequest();
  Future<AppNetworkResponse> postRequest();
  Future<AppNetworkResponse> patchRequest();
  Future<AppNetworkResponse> deleteRequest();
}
