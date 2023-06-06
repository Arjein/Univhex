import 'package:flutter/material.dart';

/*
White 0.15
aqua 0.05
blue 0.3
purple 0.3
pink 0.2

pembeden aquaya
#f0a3ff
#b2ccff
#6efaff

 */
class AppColors {
  static const Color myBlack = Color(0xFF212834);
  static const Color obsidianInvert = Color(0XFFdad8d5);
  // static const Color bgColor = Color(0xFF121212);
  static const Color bgColor = Color(0x00000000);
  static const Color myBlue = Color(0xFF567CFF);
  static const Color myLightBlue = Color(0xFF8EA8FF);
  static const Color myAqua = Color(0xFF7AF8FF);
  static const Color myPink = Color(0xFFD875FF);
  static const Color myPurple = Color(0xFF8D4BE0);
  static const Color myGold = Color(0xFFAF9500);
  static const Color mySilver = Color(0XFFB4B4B4);
  static const Color myBronze = Color(0xFFAD8A56);

  static MaterialColor myBlackMaterial = generateMaterialColor(myBlack);
  static MaterialColor myBlueMaterial = generateMaterialColor(myBlue);
  static MaterialColor myLightBlueMaterial = generateMaterialColor(myLightBlue);
  static MaterialColor myAquaMaterial = generateMaterialColor(myAqua);
  static MaterialColor myPurpleMaterial = generateMaterialColor(myPurple);

  static MaterialColor generateMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}
