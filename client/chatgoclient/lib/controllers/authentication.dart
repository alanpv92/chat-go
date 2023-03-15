
import 'package:chatgoclient/controllers/base.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/data/custom%20types/custom_types.dart';
import 'package:chatgoclient/data/enums/app_enums.dart';
import 'package:chatgoclient/data/models/request/login.dart';
import 'package:chatgoclient/data/models/request/register.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/services/authentication/authentication.dart';
import 'package:chatgoclient/utils/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

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
  late GlobalKey<FormState> formKey;
  bool isPassHidden = true;

  AuthMode _authMode = AuthMode.login;

  String _authButtonText = TextManger.instance.authLoginButtonText;

  String _authModeToggleButtonText = TextManger.instance.registerRedirect;

  initTextControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    userNameController = TextEditingController();
    formKey = GlobalKey<FormState>();
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
      _authModeToggleButtonText = TextManger.instance.registerRedirect;
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

  Future authenticateUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    setLoadingStatus(true);
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    late AuthenticationResponse authenticationResponse;
    if (_authMode == AuthMode.login) {
      authenticationResponse = await _authenticationService.loginUser(
          loginRequest: LoginRequest(
              email: emailController.text, password: passwordController.text));
    } else {
      authenticationResponse = await _authenticationService.registerUser(
          registerRequest: RegisterRequest(
              email: emailController.text,
              password: passwordController.text,
              userName: userNameController.text));
    }

    authenticationResponse.fold((l) {
      CustomSnackBar.instance.showError(errorText: l);
    },
        (r) => UserMangementController.instance
            .populateAndNavigateOnAuthentication(user: r));
    setLoadingStatus(false);
  }
}
