import 'package:auto_route/auto_route.dart';
import "package:flutter/material.dart";
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Router/app_router.gr.dart';
import 'loginForm.dart';

@RoutePage(name: "LoginPageRoute")
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, this.email}) : super(key: key);
  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                width: 280, // To set width of our Logo. Might be modified...
                child: Image.asset("assets/images/icon.png"),
              ),
              Text("UNIVHEX", style: Theme.of(context).textTheme.displayMedium),
              CurrentUser.addVerticalSpace(2.5),
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
