import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.black,
    cardColor: Colors.grey[50],
    accentColor: Color.fromRGBO(94, 84, 82, 1),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    canvasColor: Colors.grey[200],
    // dividerColor: Colors.white,
    textTheme: TextTheme(
      caption: TextStyle(
          color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.w300),
      headline1: TextStyle(
          color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.w200),
      headline2: TextStyle(
          color: Colors.black45, fontSize: 14.0, fontWeight: FontWeight.w300),
      headline3: TextStyle(
          color: Colors.black, fontSize: 10.0, fontWeight: FontWeight.w300),
      headline4: TextStyle(
          color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w300),
    ),
    brightness: Brightness.light,
  );

  final ThemeData darkTheme  = ThemeData(
    primaryColor: Colors.white,
    cardColor: Colors.grey[800],
    accentColor: Color.fromRGBO(94, 84, 82, 1),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
    ),
    canvasColor: Colors.grey[850],
    splashColor: Color.fromRGBO(94, 84, 82, 1),
    textTheme: TextTheme(
      caption: TextStyle(
          color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.w300),
      headline1: TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300),
      headline2: TextStyle(
          color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w300),
      headline3: TextStyle(
          color: Colors.white54, fontSize: 10.0, fontWeight: FontWeight.w300),
      headline4: TextStyle(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w300),
    ),
    brightness: Brightness.dark,
  );