import 'package:ecommerce_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText.tr,
        hintText: hintText.tr,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        hintStyle: Theme.of(context).textTheme.bodySmall,
        prefixIcon: Icon(icon),
        prefixIconColor: ColorApp.iconColor,
        border: roundedBorder,
        enabledBorder: roundedBorder,
        focusedBorder: roundedBorder,
      ),
    );
  }
}
