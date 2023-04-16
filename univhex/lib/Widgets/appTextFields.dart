import 'package:flutter/material.dart';
import 'package:univhex/Widgets/appTextValidators.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.textHolder,
    required this.obscure,
    required this.borderRadius,
    this.icon,
    this.validator,
    this.controller,
  });

  final String textHolder;
  final Icon? icon;
  final FormFieldValidator? validator;
  final bool obscure;
  final double borderRadius;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        autocorrect: false,
        obscureText: obscure,
        enableSuggestions: false,
        validator: validator ?? defaultValidator,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon,
          labelText: textHolder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
