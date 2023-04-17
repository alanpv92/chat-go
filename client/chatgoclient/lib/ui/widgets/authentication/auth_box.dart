import 'dart:developer';

import 'package:chatgoclient/config/size_config.dart';
import 'package:chatgoclient/controllers/authentication.dart';
import 'package:chatgoclient/manager/text.dart';
import 'package:chatgoclient/ui/widgets/common/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthBox extends StatefulWidget {
  const AuthBox({super.key});

  @override
  State<AuthBox> createState() => _AuthBoxState();
}

class _AuthBoxState extends State<AuthBox> {
  @override
  void initState() {
    AuthenticationController.instance.initTextControllers();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      AuthenticationController.instance.disposeTextController();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: SizeConfig.blockSizeVertical * 30,
      child: Card(
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Consumer(builder: (context, ref, _) {
            final authController = ref.watch(authenticationProvider);
           
            return Form(
              key: authController.formKey,
              child: Column(
                children: [
                  Visibility(
                    visible: authController.getAuthUserNameVisibility(),
                    child: CustomTextFormField(
                      controller: authController.userNameController,
                      hintText: TextManger.instance.userNameHint,
                      iconData: Icons.people,
                    ),
                  ),
                  CustomTextFormField(
                    controller: authController.emailController,
                    hintText: TextManger.instance.emailHint,
                    iconData: Icons.email,
                  ),
                  CustomTextFormField(
                    controller: authController.passwordController,
                    hintText: TextManger.instance.passwordHint,
                    iconData: Icons.remove_red_eye,
                    isPass: authController.isPassHidden,
                    onPressed: authController.changePasswordVisibility,
                    isPasswordHidden: authController.isPassHidden,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: SizeConfig.safeBlockHorizontal * 45,
                      child: authController.isloading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder()),
                              onPressed: authController.authenticateUser,
                              child: Text(authController.getAuthText())))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
