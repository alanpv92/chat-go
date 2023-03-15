import 'package:chatgoclient/controllers/authentication.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            AuthenticationController.instance.logoutUser();
          },
          child: const Text('data'),
        ),
      ),
    );
  }
}
