import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/firestore.dart';
import 'package:univhex/Firebase/user_auth.dart';

import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/user_secure_storage.dart';
import 'package:univhex/Router/app_router.dart';
import 'package:univhex/Router/router_observer.dart';
import 'package:univhex/Router/router_singleton.dart';
import 'package:univhex/Theme/theme_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Router/app_router.gr.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AppUser? user;
  // await UserSecureStorage.deleteStorage();
  String? email = await UserSecureStorage.getEmail();
  String? password = await UserSecureStorage.getPassword();
  bool isLogged = await authUser(email, password);

  if (isLogged) {
    user = await readUserfromDB(await UserSecureStorage.getFirebaseUID());
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
  final bool isLogged;
  AppUser? user;
  List<NavigatorObserver> _createObservers() {
    return [NavigationLogger()];
  }

  @override
  Widget build(BuildContext context) {
    //CurrentUser.user = Constants.TestUser;

    return MaterialApp.router(
      title: 'Univhex',
      theme: darkTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routerDelegate: getIt<AppRouter>().delegate(
          navigatorObservers: _createObservers,
          initialRoutes: [
            if (isLogged) const AppRoute(),
            if (!isLogged) const AuthRoute()
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
      isLogged: isLogged,
    );
  }
}
