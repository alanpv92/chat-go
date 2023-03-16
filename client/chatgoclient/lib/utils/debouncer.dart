import 'dart:async';

import 'package:flutter/material.dart';


class MyDebouncer {
  MyDebouncer._();
  static MyDebouncer instance = MyDebouncer._();
  factory MyDebouncer() => instance;
  Timer? _timer;
  fireApi(dynamic Function({required String searchQuery}) action,TextEditingController controller) {
    if (_timer?.isActive ?? false) {
      return;
    }
    _timer = Timer(
      const Duration(seconds: 2),
      () async {
      
        action(searchQuery: controller.text);
        _timer?.cancel();
      },
    );
  }
}
