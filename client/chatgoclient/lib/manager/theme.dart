import 'package:flutter/material.dart';

class ThemeManger {
  static ThemeData lightTheme() => ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.grey),
          headlineSmall: TextStyle(color: Colors.black, fontSize: 18),
          headlineMedium: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
          headlineLarge: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w800,
          )));
  static ThemeData darkTheme() => ThemeData.dark().copyWith();
}
