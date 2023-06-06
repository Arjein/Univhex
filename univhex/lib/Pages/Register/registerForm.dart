import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';

import 'package:univhex/Router/app_router.gr.dart';

import 'package:univhex/Widgets/appTextFields.dart';
import 'package:univhex/Widgets/appTextValidators.dart';

import 'RegisterContinue.dart';

class AppRegisterForm extends StatefulWidget {
  const AppRegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AppRegisterForm> createState() => AppRegisterFormState();
}

class AppRegisterFormState extends State<AppRegisterForm> {
  final _registerFormKey = GlobalKey<FormState>();

  String? _name;
  String? _surname;
  String? _email;
  String? _password;
  String? _pwauth;
  // Controllers for the data we need to read.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pwauthController = TextEditingController();

  @override
  void initState() {
    // Initialize variables.
    super.initState();
    // Add Listeners
    _nameController.addListener(() {
      _name = _nameController.text;
    });
    _surnameController.addListener(() {
      _surname = _surnameController.text;
    });
    _emailController.addListener(() {
      _email = _emailController.text;
    });
    _passwordController.addListener(() {
      _password = _passwordController.text;
    });
    _pwauthController.addListener(() {
      _pwauth = _pwauthController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _registerFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Text(
                "Personal",
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              CurrentUser.addVerticalSpace(5),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: 150,
                  child: AppTextFormField(
                    textHolder: "Name",
                    obscure: false,
                    borderRadius: 20,
                    controller: _nameController,
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: AppTextFormField(
                    textHolder: "Surname",
                    obscure: false,
                    borderRadius: 20,
                    controller: _surnameController,
                  ),
                ),
              ]),
              CurrentUser.addVerticalSpace(1),
              AppTextFormField(
                textHolder: "E-mail",
                obscure: false,
                borderRadius: 20,
                icon: const Icon(Icons.mail_outline),
                validator: emailValidator,
                controller: _emailController,
              ),
              CurrentUser.addVerticalSpace(1),
              AppTextFormField(
                textHolder: "Password",
                obscure: true,
                borderRadius: 20,
                icon: const Icon(Icons.lock_person_outlined),
                validator: passwordValidator(_pwauthController),
                controller: _passwordController,
              ),
              CurrentUser.addVerticalSpace(1),
              AppTextFormField(
                textHolder: "Authenticate Password",
                obscure: true,
                borderRadius: 20,
                icon: const Icon(Icons.lock_person),
                validator: pwauthValidator(_passwordController),
                controller: _pwauthController,
              ),
              CurrentUser.addVerticalSpace(2),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size.fromHeight(40),
                  foregroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                onPressed: () {
                  if (validateForm(_registerFormKey, context)) {
                    context.router.push(RegisterContinueRoute(
                        email: _email!,
                        name: _name!,
                        surname: _surname!,
                        password: _password!));
                  }
                },
                child: const Text("Continue"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
