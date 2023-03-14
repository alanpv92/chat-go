import 'package:flutter/material.dart';

class ThemeManger {
  static ThemeData lightTheme() => ThemeData.light().copyWith(
      primaryColor: Colors.lightBlue,
      
      textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.black,
            fontSize: 18
          ),
          headlineLarge: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w800,
      )));
  static ThemeData darkTheme() => ThemeData.dark().copyWith();
}
