import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';

ThemeData darkTheme = ThemeData(
  // Dark Theme Data
  // Design details for Dark Theme
  brightness: Brightness.dark,
  primarySwatch: AppColors.myPurpleMaterial,
  // fontFamily: GoogleFonts.comfortaa().fontFamily,
  backgroundColor: AppColors.bgColor,
  scaffoldBackgroundColor: AppColors.bgColor,
  appBarTheme:
      const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.myPink,
    unselectedItemColor: AppColors.obsidianInvert,
    backgroundColor: AppColors.bgColor,
    showSelectedLabels: true,
    showUnselectedLabels: false,
  ),
);
