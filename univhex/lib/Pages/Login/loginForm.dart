import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/cloud_storage.dart';
import 'package:univhex/Firebase/user_auth.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/user_secure_storage.dart';
import 'package:univhex/Router/app_router.dart';
import 'package:univhex/Router/empty_router_pages/app_router_empty.dart';
import 'package:univhex/Widgets/appButtons.dart';
import 'package:univhex/Widgets/appTextFields.dart';

class AppLoginForm extends StatefulWidget {
  AppLoginForm({
    super.key,
  });
  String? _email;
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
  String? _password = '';

  Future init() async {
    if (widget._email == null) {
      _email = await UserSecureStorage.getEmail() ?? '';
      // _password = await UserSecureStorage.getPassword() ?? '';
      debugPrint("Init:" + _email!);
    }
    setState(() {
      _emailController.text = _email!;
      _passwordController.text = _password!;
    });
  }

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
    init();
  }

  _submitLoginForm() async {
    _loginFormKey.currentState?.save();
    if (_loginFormKey.currentState != null &&
        _loginFormKey.currentState!.validate()) {
      if (await authUser(_email, _password)) {
        debugPrint("User Authenticated");
        AppUser? user = await readUserfromDB(_emailController.text);
        if (user != null && await UserSecureStorage.setUser(user)) {
          debugPrint("Başarıyla kaydettik usersecurestoragea Userı User:" +
              user.toString());
          CurrentUser.user = user;

          debugPrint(
              "Login Succesfull!\nSubmitted Login Form\nE-mail: $_email, Password: $_password");
          context.router.push(AppRoute());
        }
      }
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
          CurrentUser.addVerticalSpace(2),
          EntryButton(text: "Sign In", function: _submitLoginForm),
        ],
      ),
    );
  }
}
