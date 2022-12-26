import "package:flutter/material.dart";
import 'package:univhex/Constants/Constants.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Pages/Home/home_screen.dart';
import 'package:univhex/Pages/Register/Register.dart';
import 'package:univhex/Pages/page_navigator.dart';

import 'loginForm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                CurrentUser.addVerticalSpace(3),
                SizedBox(
                  width: 280, // To set width of our Logo. Might be modified...
                  child: Image.asset("assets/images/icon.png"),
                ),
                Text(
                  "UNIVHEX",
                  style: Theme.of(context).textTheme.headline2,
                ),
                CurrentUser.addVerticalSpace(2.5),
                const AppLoginForm(), // The form widget called here.
                Row(
                  // Dont have An account? Sign Up!
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => const Register()),
                          ),
                        );
                      },
                      child: const Text("Sign-Up"),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    CurrentUser.user = Constants.TestUser;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) =>
                            UserPage(user: Constants.TestUser)),
                      ),
                    );
                  },
                  child: const Text("Test Access"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
