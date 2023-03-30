import 'package:chatgoclient/controllers/theme.dart';
import 'package:chatgoclient/firebase_options.dart';
import 'package:chatgoclient/manager/asset.dart';
import 'package:chatgoclient/manager/route.dart';
import 'package:chatgoclient/manager/theme.dart';
import 'package:chatgoclient/services/notifications/notification.dart';

import 'package:chatgoclient/ui/screens/splash.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await EasyLocalization.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(ProviderScope(
      child: EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: AssetManger.instance.transaltions,
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        darkTheme: ThemeManger.darkTheme(),
        themeMode: ThemeController.instance.currentThemeMode,
        theme: ThemeController.instance.getAppTheme(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        getPages: RouteManger.getPages(),
        home: const SplashScreen());
  }
}
