import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Widgets/appButtons.dart';
import 'package:univhex/Widgets/appTextFields.dart';

class AppLoginForm extends StatefulWidget {
  const AppLoginForm({super.key});

  @override
  AppLoginFormState createState() {
    return AppLoginFormState();
  }
}

class AppLoginFormState extends State<AppLoginForm> {
  final _loginFormKey =
      GlobalKey<FormState>(); // To validate our data, we need to use a form.
  final _emailController = TextEditingController(); // Controller for email.
  final _passwordController =
      TextEditingController(); // Controller for Password.
  String? _email;
  String? _password;
  @override
  void initState() {
    // intialize variables.
    super.initState();
    _emailController.addListener(() {
      _email = _emailController.text;
    });
    _passwordController.addListener(() {
      _password = _passwordController.text;
    });
  }

  _submitLoginForm() async {
    _loginFormKey.currentState?.save();
    if (_loginFormKey.currentState != null &&
        _loginFormKey.currentState!.validate()) {
      debugPrint(
          "Login Succesfull!\nSubmitted Login Form\nE-mail: $_email, Password: $_password");
    }
  }

  @override
  void dispose() {
    // Delete vars from Ram. Space allocation++.
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _loginFormKey,
      child: Column(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
          AppTextFormField(
            textHolder: "E-mail",
            obscure: false,
            borderRadius: 20,
            icon: const Icon(Icons.person),
            controller: _emailController,
          ),

          AppTextFormField(
            textHolder: "Password",
            obscure: true,
            borderRadius: 20,
            icon: const Icon(Icons.password),
            controller: _passwordController,
          ),
          CurrentUser.addVerticalSpace( 2),
          EntryButton(text: "Sign In", function: _submitLoginForm),
        ],
      ),
    );
  }
}
