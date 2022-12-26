import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/Constants.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Widgets/appButtons.dart';

class RegisterContinue extends StatelessWidget {
  const RegisterContinue({
    super.key,
  });

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
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              CurrentUser.addVerticalSpace(10),
              const registerContinueForm(),
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
  });

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
          EntryButton(function: () {}, text: "Sign Up!"),
        ],
      ),
    );
  }
}
