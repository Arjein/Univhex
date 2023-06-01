import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/Constants.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/user_auth.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/user_secure_storage.dart';
import 'package:univhex/Router/app_router.dart';
import 'package:univhex/Widgets/appButtons.dart';
import 'package:univhex/Widgets/appTextValidators.dart';

@RoutePage(name: "RegisterContinueRoute")
class RegisterContinue extends StatelessWidget {
  const RegisterContinue({
    super.key,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });
  final String name;
  final String surname;
  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.01,
            0.3,
          ],
          colors: [
            AppColors.myPurple,
            AppColors.myBlack,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Text(
                "University",
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              CurrentUser.addVerticalSpace(10),
              registerContinueForm(
                email: email,
                name: name,
                surname: surname,
                password: password,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class registerContinueForm extends StatefulWidget {
  const registerContinueForm({
    super.key,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });
  final String name;
  final String surname;
  final String email;
  final String password;

  @override
  State<registerContinueForm> createState() => _registerContinueFormState();
}

class _registerContinueFormState extends State<registerContinueForm> {
  final _registerFormKey = GlobalKey<FormState>();

  String? university;
  String? major;
  String? yearOfStudy;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        children: [
          CurrentUser.addVerticalSpace(2),
          DropdownButtonFormField(
            value: university,
            validator: defaultValidatorDropDown("University"),
            items:
                Constants.schools.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: const Text("Please Select Your University"),
            onChanged: (value) {
              setState(() {
                university = value!;
              });
            },
          ),
          CurrentUser.addVerticalSpace(2),
          DropdownButtonFormField(
            value: major,
            validator: defaultValidatorDropDown("Major"),
            items:
                Constants.fields.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                major = value!;
              });
            },
            hint: const Text("Please Select Your Major"),
          ),
          CurrentUser.addVerticalSpace(2),
          DropdownButtonFormField(
            value: yearOfStudy,
            validator: defaultValidatorDropDown("Year of Study"),
            items:
                Constants.years.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                yearOfStudy = value!;
              });
            },
            hint: const Text("Please Select Your Year of Study"),
          ),
          CurrentUser.addVerticalSpace(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  foregroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                onPressed: () async {
                  if (validateForm(_registerFormKey, context)) {
                    AppUser newUser = AppUser(
                      email: widget.email,
                      name: widget.name,
                      surname: widget.surname,
                      password: widget.password,
                      university: university,
                      fieldOfStudy: major,
                      yearOfStudy: yearOfStudy,
                      hexPoints: 0,
                    );
                    if (await registerUser(newUser)) {
                      await UserSecureStorage.setEmail(newUser.email!);
                      // Herşeyi poplayıp homeu puslicaz
                      context.router
                          .popUntil((route) => route.settings.name == '/auth');
                      context.router.push(LoginPageRoute());
                    }
                  }
                  ;
                },
                child: const Text("Sign Up!")),
          ),
        ],
      ),
    );
  }
}
