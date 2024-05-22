import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextFieldType textFieldType;
  final String? hint;
  final EdgeInsets? contentPadding;
  final Function(String)? onSubmit;
  final FormFieldValidator? validator;

  const AuthTextField(
      {super.key,
      required this.controller,
      required this.textFieldType,
      this.hint,
      this.onSubmit,
      this.contentPadding,
      this.validator});

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(width: 1, color: Colors.black26));
    return AppTextField(
      textFieldType: textFieldType,
      controller: controller,
      cursorColor: Colors.white,
      onFieldSubmitted: onSubmit,
      validator: validator,
      suffixIconColor: Colors.white,
      textStyle: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          contentPadding: contentPadding,
          errorStyle: const TextStyle(color: Colors.white),
          labelStyle: const TextStyle(color: Colors.white),
          hintStyle: const TextStyle(color: Colors.white),
          focusedBorder: inputBorder,
          errorBorder: inputBorder,
          disabledBorder: inputBorder,
          enabledBorder: inputBorder,
          focusedErrorBorder: inputBorder,
          hintText: hint,
          border: inputBorder),
    );
  }
}
