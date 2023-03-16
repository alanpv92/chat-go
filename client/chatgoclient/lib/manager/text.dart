import 'package:easy_localization/easy_localization.dart';

class ErrorText {
  String randomError = tr('random_error');
}

class AuthText {
  String userNameHint = "user name";
  String emailHint = "email";
  String passwordHint = "password";
  String authLoginButtonText = "Sign In";
  String authRegisterButtonText = "Sign Up";
  String registerRedirect = tr('auth_register_redirect');
  String loginRedirect = tr('auth_login_redirect');
}

class CommonText {
  String appTitle = "Chat Go";

}

class TextManger with ErrorText, AuthText,CommonText {
  TextManger._();
  static TextManger instance = TextManger._();
  factory TextManger() => instance;
}
