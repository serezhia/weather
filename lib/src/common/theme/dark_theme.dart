import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  iconTheme: const IconThemeData(color: Colors.white),
  colorScheme: const ColorScheme.dark(
    primary: Colors.black,
    secondary: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(
      fontFamily: 'Gilroy',
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.white.withOpacity(0.2),
    selectionHandleColor: Colors.white,
  ),
  fontFamily: 'Gilroy',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey;
        } else {
          return Colors.white;
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
