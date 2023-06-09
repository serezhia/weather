import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    primary: Colors.white,
    secondary: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.black.withOpacity(0.2),
    selectionHandleColor: Colors.black,
  ),
  fontFamily: 'Gilroy',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.withOpacity(0.3);
        } else {
          return Colors.black;
        }
      }),
      elevation: MaterialStateProperty.all(0),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: const OutlineInputBorder(
      gapPadding: 20,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      borderSide: BorderSide(width: 2),
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
