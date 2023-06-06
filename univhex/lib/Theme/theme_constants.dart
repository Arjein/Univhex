import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  // Dark Theme Data
  // Design details for Dark Theme
  brightness: Brightness.dark,
  primarySwatch: AppColors.myPurpleMaterial,
  // useMaterial3: true,
  fontFamily: GoogleFonts.poppins().fontFamily,

  scaffoldBackgroundColor: AppColors.bgColor,
  appBarTheme:
      const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: AppColors.obsidianInvert,
    showSelectedLabels: true,
    showUnselectedLabels: false,
  ),
);
