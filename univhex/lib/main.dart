import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Pages/Login/login_screen.dart';
import 'package:univhex/Theme/theme_constants.dart';


// Kullanıcı giriş veya kayıt yaptıgında otomatik giriş yapıcaz --> flutter_secure_storage
// Yorum butonnu direk keyboardı accak
// 

void main() => runApp(MyApp(
      isLogged: false,
    ));

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isLogged, this.user});
  final bool isLogged;

  AppUser? user;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Univhex',
      theme: darkTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const InitApp(),
    );
  }
}

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    CurrentUser.deviceHeight =
        MediaQuery.of(context).size.height; // Set CurrentUser's device height.
    CurrentUser.deviceWidth =
        MediaQuery.of(context).size.width; // Set CurrentUser's device width.
    return const LoginScreen();
  }
}
