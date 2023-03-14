import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomSnackBar {
  CustomSnackBar._();
  static CustomSnackBar instance = CustomSnackBar._();
  factory CustomSnackBar() => instance;
  _showSnackBar({required String message, required Color color}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(
        message,
        style: Theme.of(Get.context!)
            .textTheme
            .headlineSmall!
            .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(20),
      backgroundColor: color,
    ));
  }

  showError({required String errorText}) {
    _showSnackBar(message: errorText, color: Colors.red);
  }
}
