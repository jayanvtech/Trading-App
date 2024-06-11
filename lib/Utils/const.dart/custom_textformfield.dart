// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String? labelText;
  String? hintText;
  IconData? icon;
  VoidCallback? onClick;
  String? errorMessage;
  bool obscureText = false;

  CustomTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.icon,
    this.hintText,
    this.onClick,
    this.errorMessage,
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
        hintText: hintText,
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
        labelText: labelText,
        suffixIcon: IconButton(onPressed: onClick, icon: Icon(icon)),
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