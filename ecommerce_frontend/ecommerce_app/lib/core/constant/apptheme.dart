import 'package:ecommerce_app/core/constant/color.dart';
import 'package:flutter/material.dart';

ThemeData themeEnFr = ThemeData(
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: ColorApp.bgColor,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: ColorApp.titleFont,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: ColorApp.titleFont,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.6,
      color: ColorApp.bodyFont,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      height: 1.6,
      color: ColorApp.loginFont,
    ),
  ),
);
ThemeData themeAr = ThemeData(
  fontFamily: 'Cairo',
  scaffoldBackgroundColor: ColorApp.bgColor,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: ColorApp.titleFont,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: ColorApp.titleFont,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 2,
      color: ColorApp.bodyFont,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 2,
      color: ColorApp.loginFont,
    ),
  ),
);
