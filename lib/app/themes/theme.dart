import 'package:flutter/material.dart';
import 'package:mandar_trip/app/themes/color_constanta.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorConstants.white,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade700),
        borderRadius: BorderRadius.circular(10),
      ),
      hintStyle: const TextStyle(
        fontSize: 14,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline1: const TextStyle(
        letterSpacing: -1.5,
        fontSize: 48,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headline2: const TextStyle(
        letterSpacing: -1.0,
        fontSize: 40,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headline3: const TextStyle(
        // letterSpacing: -1.0,
        fontSize: 32,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headline4: const TextStyle(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headline5: const TextStyle(
        color: Colors.black,
        fontSize: 19,
        fontWeight: FontWeight.w600,
      ),
      headline6: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      subtitle1: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      subtitle2: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      caption: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      overline: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.5,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorConstants.gray900,
    appBarTheme: AppBarTheme(backgroundColor: ColorConstants.gray900, elevation: 0),
    bottomAppBarColor: ColorConstants.gray800,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(10),
      ),
      hintStyle: const TextStyle(
        fontSize: 14,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline1: TextStyle(
        letterSpacing: -1.5,
        fontSize: 48,
        color: Colors.grey.shade50,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        letterSpacing: -1.0,
        fontSize: 40,
        color: Colors.grey.shade50,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        letterSpacing: -1.0,
        fontSize: 32,
        color: Colors.grey.shade50,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headline5: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      headline6: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      subtitle1: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      subtitle2: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      caption: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      overline: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.5,
      ),
    ),
  );
}
