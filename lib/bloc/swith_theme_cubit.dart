import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    primaryColor: Colors.black,
    accentColor: Color.fromRGBO(94, 84, 82, 1),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    dividerColor: Colors.white,
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.w200),
      headline2: TextStyle(
          color: Colors.black45, fontSize: 14.0, fontWeight: FontWeight.w300),
      headline3: TextStyle(
          color: Colors.black45, fontSize: 10.0, fontWeight: FontWeight.w300),
      headline4: TextStyle(
          color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w300),
    ),
    brightness: Brightness.light,
  );

  static final _darkTheme = ThemeData(
    primaryColor: Colors.white,
    accentColor: Color.fromRGBO(94, 84, 82, 1),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
    ),
    textTheme: TextTheme(
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

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}
