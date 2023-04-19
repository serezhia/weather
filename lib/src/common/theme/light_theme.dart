import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        16,
      ),
      borderSide: const BorderSide(
        width: 2,
      ),
    ),
  ),
);
