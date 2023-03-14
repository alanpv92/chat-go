import 'dart:developer';

import 'package:chatgoclient/controllers/base.dart';
import 'package:chatgoclient/data/enums/app_enums.dart';
import 'package:chatgoclient/data/models/request/login.dart';
import 'package:chatgoclient/data/models/request/register.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/services/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationProvider =
    ChangeNotifierProvider((ref) => AuthenticationController());

class AuthenticationController extends BaseController {
  AuthenticationController._();
  static AuthenticationController instance = AuthenticationController._();
  factory AuthenticationController() => instance;
  final AuthenticationService _authenticationService = AuthenticationService();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController userNameController;
  bool isPassHidden = true;

  AuthMode _authMode = AuthMode.login;

  String _authButtonText =TextManger.instance.authLoginButtonText;

  String _authModeToggleButtonText = TextManger.instance.registerRedirect;

  initTextControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    userNameController = TextEditingController();
  }

  disposeTextController() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
  }

  clearTextControllers() {
    emailController.clear();
    passwordController.clear();
    userNameController.clear();
    isPassHidden = false;
  }

  toggleAuthMode() {
    if (_authMode == AuthMode.login) {
      _authMode = AuthMode.register;
      _authButtonText = TextManger.instance.authRegisterButtonText;
      _authModeToggleButtonText = TextManger.instance.loginRedirect;
    } else {
      _authMode = AuthMode.login;
      _authButtonText = TextManger.instance.authLoginButtonText;
      _authModeToggleButtonText =TextManger.instance.registerRedirect ;
    }
    clearTextControllers();
    isPassHidden = true;
    notifyListeners();
  }

  changePasswordVisibility() {
    isPassHidden = !isPassHidden;
    notifyListeners();
  }

  getAuthUserNameVisibility() => _authMode == AuthMode.register;
  getAuthText() => _authButtonText;

  getAuthModeToggleText() => _authModeToggleButtonText;

  Future<void> loginUser(
      {required String email, required String password}) async {
    final response = await _authenticationService.loginUser(
        loginRequest: LoginRequest(email: email, password: password));
    log(response.toString());
    //perfrom actions based after building ui
  }

  Future<void> registerUser(
      {required String email,
      required String password,
      required String userName}) async {
    final response = await _authenticationService.register(
        registerRequest: RegisterRequest(
                email: email, password: password, userName: userName)
            .getRequestData());
    log(response.toString());
    //perfrom actions based after building ui
  }
}
