import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final primaryColor = Color(0xff082659);
final secondaryColor = Color(0xff51eec2);

final appTheme = ThemeData(
    appBarTheme: AppBarTheme(
backgroundColor: Colors.white70,

          toolbarHeight: 60.0.h ,

      elevation: 0,
      centerTitle: true,
// systemOverlayStyle: SystemUiOverlayStyle(
//
//       statusBarColor: Colors.white,
//       statusBarIconBrightness: Brightness.dark,
//     ),
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: primaryColor),
        iconColor: secondaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        )));
