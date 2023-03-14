import 'package:chatgoclient/manager/api.dart';
import 'package:chatgoclient/manager/asset.dart';
import 'package:chatgoclient/services/network/app_network.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  AppNetwork.instance.postRequest(
      path: ApiManger.loginUrl,
      args: {"email": "test1@gmail.com", "password": "qwerty"});
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
    return const MaterialApp();
  }
}
