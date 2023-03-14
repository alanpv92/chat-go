import 'package:chatgoclient/data/custom%20types/custom_types.dart';
import 'package:chatgoclient/data/interfaces/authentication.dart';
import 'package:chatgoclient/data/models/request/register.dart';
import 'package:chatgoclient/data/models/request/login.dart';
import 'package:chatgoclient/data/models/user.dart';
import 'package:chatgoclient/manager/api.dart';
import 'package:chatgoclient/services/network/app_network.dart';
import 'package:dartz/dartz.dart';

class AuthenticationService implements AuthenticationInterface {
  final AppNetwork _appNetwork = AppNetwork();

  @override
  Future<AuthenticationResponse> loginUser(
      {required LoginRequest loginRequest}) async {
    final response = await _appNetwork.postRequest(
        path: ApiManger.loginUrl, args: loginRequest.getRequestData());
    return response.fold(
        (l) => left(l.message), (r) => right(User.fromJson(r)));
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<AuthenticationResponse> register(
      {required RegisterRequest registerRequest}) async {
    final response = await _appNetwork.postRequest(
        path: ApiManger.loginUrl, args: registerRequest.getRequestData());
    return response.fold(
        (l) => left(l.message), (r) => right(User.fromJson(r)));
  }
}
