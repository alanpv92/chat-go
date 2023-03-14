import 'package:easy_localization/easy_localization.dart';

class ErrorText {
  String randomError = tr('random_error');
}

class TextManger with ErrorText {
  TextManger._();
  static TextManger instance = TextManger._();
  factory TextManger() => instance;
}
