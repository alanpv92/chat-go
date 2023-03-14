import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? iconData;
  final bool isPass;
  final void Function()? onPressed;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.iconData,
      this.isPass=false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPass,
      controller: controller,
      style: Theme.of(context).textTheme.headlineSmall,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(onPressed: onPressed, icon: Icon(iconData),color: isPass?null:Colors.blue)),
    );
  }
}
