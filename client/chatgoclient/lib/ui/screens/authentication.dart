import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/authentication.dart';
import 'package:chatgoclient/controllers/theme.dart';
import 'package:chatgoclient/ui/widgets/authentication/auth_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              const Spacer(),
              SizedBox(
                  height: SizeConfig.safeBlockVertical * 10,
                  child: FittedBox(
                      child: Text(
                    "Chat Go",
                    style: theme.textTheme.headlineLarge,
                  ))),
              const SizedBox(
                height: 20,
              ),
              const AuthBox(),
              const Spacer(),
              Consumer(
                builder: (context, ref, child) {
                  final authController = ref.watch(authenticationProvider);
                  return TextButton(
                      onPressed: authController.toggleAuthMode,
                      child: Text(authController.getAuthModeToggleText()));
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
