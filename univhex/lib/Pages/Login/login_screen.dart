import 'dart:math';

import 'package:auto_route/auto_route.dart';
import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:univhex/Constants/current_user.dart';

import 'package:univhex/Router/app_router.gr.dart';
import 'loginForm.dart';

@RoutePage(name: "LoginPageRoute")
class LoginScreen extends HookWidget {
  LoginScreen({Key? key, this.email}) : super(key: key);
  String? email;
  @override
  Widget build(BuildContext context) {
    final controller =
        useAnimationController(duration: const Duration(seconds: 15))
          ..repeat(reverse: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CurrentUser.addVerticalSpace(7),
              SizedBox(
                width: 280, // To set width of our Logo. Might be modified...
                child: Image.asset("assets/images/icon.png"),

                /*
                 Transform.rotate(
                  angle: pi /
                      2, // Rotate 90 degrees. Dart uses radians, not degrees, hence we use pi/2.
                  child: RotationTransition(
                    turns: controller,
                    child: Lottie.network(
                        'https://assets9.lottiefiles.com/packages/lf20_d6619szt.json'),
                  ),
                ),
                */
              ),
              Text("UNIVHEX", style: Theme.of(context).textTheme.displayMedium),
              CurrentUser.addVerticalSpace(2),
              AppLoginForm(), // The form widget called here.
              Row(
                // Dont have An account? Sign Up!
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      context.router.push(const RegisterPageRoute());
                    },
                    child: const Text("Sign-Up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
