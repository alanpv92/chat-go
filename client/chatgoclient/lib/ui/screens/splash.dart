import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/app.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppController.instance.initApp();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            SizedBox(
                width: SizeConfig.safeBlockHorizontal * 70,
                child: const LinearProgressIndicator(
                  minHeight: 12,
                ))
          ],
        ),
      ),
    );
  }
}
