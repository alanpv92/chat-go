import 'dart:developer';

import 'package:chatgoclient/controllers/base.dart';
import 'package:chatgoclient/manager/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = ChangeNotifierProvider((ref) => ThemeController());

class ThemeController extends BaseController {
  ThemeController._();
  static ThemeController instance = ThemeController._();
  factory ThemeController() => instance;

  ThemeMode currentThemeMode = ThemeMode.light;
  ThemeData getAppTheme() {
 
    if (currentThemeMode == ThemeMode.dark) {
      return ThemeManger.darkTheme();
    }
    return ThemeManger.lightTheme();
  }

  updateThemeData({required ThemeMode newThemeMode}) {
    currentThemeMode = newThemeMode;

    notifyListeners();
  }
}
