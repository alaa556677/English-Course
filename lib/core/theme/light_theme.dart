import 'package:english/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.whiteColor,
/////////////////////////////////////////////////////////////////////////////////////////////////
  iconTheme: IconThemeData(
    color: AppColors.whiteColor
  ),
/////////////////////////////////////////////////////////////////////////////////////////////////
  drawerTheme: const DrawerThemeData(
    width: 240
  ),
/////////////////////////////////////////////////////////////////////////////////////////////////
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light
    ),
    backgroundColor: AppColors.transparent,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: AppColors.blackColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: AppColors.whiteColor,
    ),
  ),
/////////////////////////////////////////////////////////////////////////////////////////////////
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.transparent,
  ),
//////////////////////////////////////////////////////////////////////////////////////////////////
  textTheme: TextTheme(
    ///////////////////////////////////////////// display
    displayLarge: TextStyle(
      fontSize: 74,
      color: AppColors.whiteColor,
    ),
    displayMedium: TextStyle(
      fontSize: 64,
      color: AppColors.whiteColor,
    ),
    displaySmall: TextStyle(
      fontSize: 54,
      color: AppColors.whiteColor,
    ),
    //////////////////////////////////////////////// head
    headlineLarge: TextStyle(
      fontSize: 43,
      color: AppColors.whiteColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 36,
      color: AppColors.whiteColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 32,
      color: AppColors.whiteColor,
    ),
    ///////////////////////////////////////////// title
    titleLarge: TextStyle(
      fontSize: 30,
      color: AppColors.whiteColor,
    ),
    titleMedium: TextStyle(
      fontSize: 28,
      color: AppColors.whiteColor,
    ),
    titleSmall: TextStyle(
      fontSize: 26,
      color:  AppColors.whiteColor,
    ),
    ///////////////////////////////////////////// body
    bodyLarge: TextStyle(
      fontSize: 24,
      color:  AppColors.whiteColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 22,
      color: AppColors.whiteColor,
    ),
    bodySmall: TextStyle(
      fontSize: 20,
      color: AppColors.whiteColor,
    ),
    ////////////////////////////////////////////////// label
    labelLarge: TextStyle(
      fontSize: 18,
      color: AppColors.whiteColor,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      color: AppColors.whiteColor,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      color: AppColors.whiteColor,
    ),
  ),
);
