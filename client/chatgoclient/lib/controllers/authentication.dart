import 'dart:developer';

import 'package:chatgoclient/controllers/base.dart';
import 'package:chatgoclient/data/models/request/login.dart';
import 'package:chatgoclient/data/models/request/register.dart';
import 'package:chatgoclient/services/authentication/authentication.dart';

class AuthenticationController extends BaseController {
  final AuthenticationService _authenticationService = AuthenticationService();
  Future<void> loginUser(
      {required String email, required String password}) async {
    final response = await _authenticationService.loginUser(
        loginRequest: LoginRequest(email: email, password: password));
    log(response.toString());
    //perfrom actions based after building ui
  }

  Future<void> registerUser({required String email,required String password,required String userName})async{
       final response = await _authenticationService.register(
        registerRequest: RegisterRequest(email: email, password: password,userName: userName).getRequestData());
    log(response.toString());
    //perfrom actions based after building ui
  }
}
