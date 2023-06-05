import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';

import 'registerForm.dart';

@RoutePage(name: 'RegisterPageRoute')
class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // To Create the gradient effect in background. Might be modified.
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.01, 0.24],
          colors: [
            AppColors.myPurple,
            AppColors.bgColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: const AppRegisterForm(),
      ),
    );
  }
}
