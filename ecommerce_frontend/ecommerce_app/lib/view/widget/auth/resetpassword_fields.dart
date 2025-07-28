import 'package:ecommerce_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetpasswordFields extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController passwordController;

  const ResetpasswordFields({
    super.key,
    required this.passwordController,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return Column(
      children: [
        // Pass Field
        TextFormField(
          controller: passwordController,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) return 'required'.tr;
            final passwordReg =
                RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
            if (!passwordReg.hasMatch(value)) return 'password_not_valid'.tr;
            return null;
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            prefixIcon: const Icon(Icons.lock_outline),
            border: roundedBorder,
            prefixIconColor: ColorApp.iconColor,
            enabledBorder: roundedBorder,
            focusedBorder: roundedBorder,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
