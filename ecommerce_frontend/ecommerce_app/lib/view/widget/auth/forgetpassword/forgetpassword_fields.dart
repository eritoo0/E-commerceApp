import 'package:ecommerce_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetpasswordFields extends StatelessWidget {
  final TextEditingController emailController;

  const ForgetpasswordFields({
    super.key,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return Column(
      children: [
        // Email Field
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) return 'required'.tr;
            final emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailReg.hasMatch(value)) return 'email_not_valid'.tr;
            return null;
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: 'email'.tr,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            hintText: 'email_hint'.tr,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            prefixIcon: const Icon(Icons.email_outlined),
            prefixIconColor: ColorApp.iconColor,
            border: roundedBorder,
            enabledBorder: roundedBorder,
            focusedBorder: roundedBorder,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
