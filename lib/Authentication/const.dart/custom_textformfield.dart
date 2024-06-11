import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final String errorMessage;
  bool obscureText = false;

  CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    required this.errorMessage,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      strutStyle: const StrutStyle(height: 1.0),
      controller: controller,
      focusNode: FocusNode(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(color: Colors.black),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(color: Colors.black),
        ),
        prefixIcon: Icon(icon),
        labelText: labelText,
      ),
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $errorMessage';
        }
        return null;
      },
    );
  }
}
