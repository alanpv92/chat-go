import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/authentication.dart';
import 'package:chatgoclient/controllers/theme.dart';
import 'package:chatgoclient/manager/asset.dart';
import 'package:chatgoclient/manager/theme.dart';
import 'package:chatgoclient/ui/screens/authentication.dart';
import 'package:chatgoclient/ui/widgets/providers/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // AppNetwork.instance.postRequest(
  //     path: ApiManger.loginUrl,
  //     args: {"email": "test1@gmail.com", "password": "qwerty"});
  // AuthenticationController()
  //     .loginUser(email: "test1@gmail.com", password: "qwerty");
  runApp(ProviderScope(
      child: EasyLocalization(
          supportedLocales: const [Locale('en', 'US')],
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
      home: const AuthenticationScreen(),
    );
  }
}
