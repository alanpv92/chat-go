import 'package:chatgoclient/controllers/base.dart';
import 'package:chatgoclient/controllers/chat.dart';
import 'package:chatgoclient/controllers/notifications.dart';
import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/manager/route.dart';
import 'package:chatgoclient/manager/text.dart';

import 'package:chatgoclient/services/storage/app_storage.dart';
import 'package:chatgoclient/utils/custom_snack_bar.dart';
import 'package:chatgoclient/utils/stroage/user_box.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

class AppController extends BaseController {
  AppController._();
  static AppController instance = AppController._();
  factory AppController() => instance;

  initApp() async {
    try {
      await AppStorage.instance.initAppStorage();
      await UserMangementController.instance.initToken();

      final status = await UserMangementController.instance.checkAuthStatus();
      if (status) {
        await NotificationController.instance.initFirebaseNotifications();
        NotificationController.instance.checkForNotification();
        Get.offAllNamed(Routes.homeScreen);
      } else {
        Get.offAllNamed(Routes.authScreen);
      }
    } catch (e) {
      // log(e.toString());
      CustomSnackBar.instance
          .showError(errorText: TextManger.instance.randomError);
      await Future.delayed(const Duration(seconds: 2));
      SystemNavigator.pop();
    }
  }

  disposeAppOnLogOut() async {
    await UserBoxStorage.instance.deleteToken();
    await UserMangementController.instance.userMangementControllerDisposer();
    await ChatController.instance.chatControllerDispose();
  }
}
