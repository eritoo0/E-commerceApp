import 'package:ecommerce_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData preIcon;
  final IconData? suffIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function()? onTapIcon;

  final bool? obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.preIcon,
    required this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.obscureText,
    this.suffIcon,
    this.onTapIcon,
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
      obscureText: obscureText == null || obscureText == false ? false : true,
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
        prefixIcon: Icon(preIcon),
        suffixIcon: suffIcon != null
            ? InkWell(
                onTap: onTapIcon,
                child: Icon(
                  obscureText == true ? Icons.visibility_off : Icons.visibility,
                  color: ColorApp.iconColor,
                ),
              )
            : null,
        prefixIconColor: ColorApp.iconColor,
        border: roundedBorder,
        enabledBorder: roundedBorder,
        focusedBorder: roundedBorder,
      ),
    );
  }
}
