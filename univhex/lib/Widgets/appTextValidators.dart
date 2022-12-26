import 'package:flutter/material.dart';

bool validateForm(GlobalKey<FormState> key, context) {
  if (key.currentState!.validate()) {
    return true;
  }
  return false;
}

FormFieldValidator emailValidator = (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your e-mail!';
  } else {
    String userMail = value.toString();
    bool isEdu = false;
    int? atIndex;
    for (int i = 0; i < userMail.length; i++) {
      if (userMail[i] == '@') {
        atIndex = i;
        break;
      }
    }
    if (atIndex == null) {
      return "Please enter a valid e-mail";
    } else {
      String schoolExtension = userMail.substring(
        atIndex + 1,
      );

      final splittedExtension = schoolExtension.split('.');
      for (int i = 0; i < splittedExtension.length; i++) {
        debugPrint(splittedExtension[i]);
        if (splittedExtension[i] == "edu") {
          isEdu = true;
        }
      }
      debugPrint(
          "@ index: $atIndex \n School Extension: $schoolExtension \n isEdu: $isEdu ");
      if (isEdu) {
        return null;
      }
      return "Sorry, Univhex is only for University Students.";
    }
  }
};

FormFieldValidator passwordValidator(TextEditingController currentPwAuth) {
  return (value) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$');

    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      }
      if (currentPwAuth.text != value) {
        return 'Passwords Does not Match!';
      } else {
        return null;
      }
    }
  };
}

FormFieldValidator pwauthValidator(TextEditingController currentPass) {
  return (value) {
    if (currentPass.text != value) {
      return 'Passwords Does not Match!';
    }
  };
}

FormFieldValidator defaultValidator = (value) {
  if (value == null || value.isEmpty) {
    return 'Woops!';
  }
  return null;
};

FormFieldValidator defaultValidatorDropDown(String text) {
  return ((value) {
    if (value == null || value.isEmpty) {
      return 'Please Select your $text';
    }
    return null;
  });
}
