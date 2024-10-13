import 'package:flutter/material.dart';

class MyTheme {
  // static const Color primary = Color.fromRGBO(167, 139, 250, 1);
  static const Color primary = Color.fromRGBO(145, 123, 219, 1);
  static const Color secondary = Color.fromRGBO(93, 78, 141, 0.6);
  
  static final ThemeData myTheme = ThemeData(
    primaryColor: primary,
    shadowColor: secondary,
    brightness: Brightness.light,
    fontFamily: 'Raleway',
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 10,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(backgroundColor: primary),
    ),
    floatingActionButtonTheme: 
      const FloatingActionButtonThemeData(backgroundColor: primary),
  );
}