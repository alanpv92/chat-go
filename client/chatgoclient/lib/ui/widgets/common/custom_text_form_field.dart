import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? iconData;
  final bool isPass;
  final void Function()? onPressed;
  final bool isPasswordHidden;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.iconData,
      this.isPass = false,
      this.onPressed,
      this.isPasswordHidden = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPass,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "this field is required";
        }
        return null;
      },
      style: Theme.of(context).textTheme.headlineSmall,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(
              onPressed: onPressed,
              icon: Icon(iconData),
              color: isPasswordHidden ? Colors.grey : Colors.blue)),
    );
  }
}
