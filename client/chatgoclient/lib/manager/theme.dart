import 'package:flutter/material.dart';

class ThemeManger {
 static ThemeData lightTheme() => ThemeData.light().copyWith();
 static ThemeData darkTheme() => ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.black
 );
}
