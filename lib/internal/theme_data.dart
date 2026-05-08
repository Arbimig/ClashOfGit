import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.black,
  cardColor: Colors.grey[50],
  colorScheme: ColorScheme.light(
    secondary: Color.fromRGBO(94, 84, 82, 1),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
  ),
  canvasColor: Colors.grey[300],
  splashColor: Color.fromRGBO(94, 84, 82, 1),
  textTheme: TextTheme(
    bodySmall: TextStyle(
        color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.w300),
    displayLarge: TextStyle(
        color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.w200),
    displayMedium: TextStyle(
        color: Colors.black45, fontSize: 14.0, fontWeight: FontWeight.w300),
    displaySmall: TextStyle(
        color: Colors.black, fontSize: 10.0, fontWeight: FontWeight.w300),
    headlineMedium: TextStyle(
        color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w300),
    titleMedium: TextStyle(
        color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w300),
  ),
  brightness: Brightness.light,
);

final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.white,
  cardColor: Colors.grey[800],
  colorScheme: ColorScheme.dark(
    secondary: Color.fromRGBO(94, 84, 82, 1),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.black,
  ),
  canvasColor: Colors.grey[850],
  splashColor: Color.fromRGBO(94, 84, 82, 1),
  textTheme: TextTheme(
    bodySmall: TextStyle(
        color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.w300),
    displayLarge: TextStyle(
        color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300),
    displayMedium: TextStyle(
        color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w300),
    displaySmall: TextStyle(
        color: Colors.white54, fontSize: 10.0, fontWeight: FontWeight.w300),
    headlineMedium: TextStyle(
        color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w300),
    titleMedium: TextStyle(
        color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w300),
  ),
  brightness: Brightness.dark,
);
