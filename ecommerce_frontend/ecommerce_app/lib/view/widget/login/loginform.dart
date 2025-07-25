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
          decoration: InputDecoration(
            labelText: 'email'.tr,
            hintText: 'Enter your email',
            prefixIcon: const Icon(Icons.email_outlined),
            border: roundedBorder,
            enabledBorder: roundedBorder,
            focusedBorder: roundedBorder,
          ),
        ),
        const SizedBox(height: 20),

        // Password Field
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password'.tr,
            hintText: 'Enter your password',
            prefixIcon: const Icon(Icons.lock_outline),
            border: roundedBorder,
            enabledBorder: roundedBorder,
            focusedBorder: roundedBorder,
          ),
        ),
      ],
    );
  }
}
