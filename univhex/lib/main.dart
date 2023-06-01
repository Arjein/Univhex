import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/user_auth.dart';

import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/user_secure_storage.dart';
import 'package:univhex/Pages/Login/login_screen.dart';
import 'package:univhex/Router/app_router.dart';
import 'package:univhex/Router/router_observer.dart';
import 'package:univhex/Router/router_singleton.dart';
import 'package:univhex/Theme/theme_constants.dart';

import 'Constants/Constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Kullanıcı giriş veya kayıt yaptıgında otomatik giriş yapıcaz --> flutter_secure_storage
// Yorum butonnu direk keyboardı accak
//

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppUser? user;
  String? email = await UserSecureStorage.getEmail();
  String? password = await UserSecureStorage.getPassword();
  bool isLogged = await authUser(email, password);
  debugPrint("Is Logged:" + isLogged.toString());
  if (isLogged) {
    user = await UserSecureStorage.getUser();
    CurrentUser.user = user;
    runApp(
      InitApp(isLogged: isLogged, user: CurrentUser.user!),
    );
  } else {
    runApp(InitApp(isLogged: isLogged));
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isLogged, this.user});
  bool isLogged;
  AppUser? user;
  List<NavigatorObserver> _createObservers() {
    return [NavigationLogger()];
  }
  
  @override
  Widget build(BuildContext context) {
    CurrentUser.user = Constants.TestUser;
    isLogged = true;
    return MaterialApp.router(
      title: 'Univhex',
      theme: darkTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routerDelegate: getIt<AppRouter>().delegate(
          navigatorObservers: _createObservers,
          initialRoutes: [
            if (isLogged) AppRoute(),
            if (!isLogged) AuthRoute()
          ]),
      routeInformationParser: getIt<AppRouter>().defaultRouteParser(),
    );
  }
}

class InitApp extends StatelessWidget {
  InitApp({super.key, required this.isLogged, this.user});
  final bool isLogged;
  AppUser? user;
  @override
  Widget build(BuildContext context) {
    CurrentUser.deviceHeight =
        MediaQuery.of(context).size.height; // Set CurrentUser's device height.
    CurrentUser.deviceWidth =
        MediaQuery.of(context).size.width; // Set CurrentUser's device width.

    return MyApp(
      isLogged: false,
    );
  }
}
