import 'package:ecommerce_app/view/widget/auth/custom_text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email Field
        CustomTextField(
          controller: emailController,
          labelText: 'email'.tr,
          hintText: 'email_hint'.tr,
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        // Password Field
        CustomTextField(
          controller: passwordController,
          labelText: 'password'.tr,
          hintText: 'password_hint'.tr,
          icon: Icons.lock_outline,
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
      ],
    );
  }
}
