import 'package:chatgoclient/controllers/base.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/services/storage/app_storage.dart';
import 'package:chatgoclient/utils/custom_snack_bar.dart';
import 'package:chatgoclient/utils/stroage/user_box.dart';
import 'package:flutter/services.dart';

class AppController extends BaseController {
  AppController._();
  static AppController instance = AppController._();
  factory AppController() => instance;

  initApp() async {
    try {
      await AppStorage.instance.initAppStorage();
      await UserMangementController.instance.initToken();
      await UserMangementController.instance.checkAuthStatus();
    } catch (e) {
      CustomSnackBar.instance
          .showError(errorText: TextManger.instance.randomError);
      await Future.delayed(const Duration(seconds: 2));
      SystemNavigator.pop();
    }
  }

  disposeAppOnLogOut() async {
    await UserBoxStorage.instance.deleteToken();
   await UserMangementController.instance.userMangementControllerDisposer();
  }
}
