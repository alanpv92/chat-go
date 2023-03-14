import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/theme.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * 5,
            vertical: SizeConfig.safeBlockVertical * 3),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    ThemeController.instance
                        .updateThemeData(newThemeMode: ThemeMode.dark);
                  },
                  child: Text('click'))
            ],
          ),
        ),
      )),
    );
  }
}
