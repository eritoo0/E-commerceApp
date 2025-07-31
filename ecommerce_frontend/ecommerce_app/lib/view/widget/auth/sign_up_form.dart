import 'package:ecommerce_app/view/widget/auth/custom_text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignUpForm({
    super.key,
    required this.fullNameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Full Name
        CustomTextField(
          controller: fullNameController,
          labelText: 'fullname',
          hintText: 'fullname_hint',
          icon: Icons.badge_outlined,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 20),

        // Email
        CustomTextField(
          controller: emailController,
          labelText: 'email',
          hintText: 'email_hint',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),

        // Phone
        CustomTextField(
          controller: phoneController,
          labelText: 'phone',
          hintText: 'phone_hint',
          icon: Icons.phone_android_outlined,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 20),

        // Password
        CustomTextField(
          controller: passwordController,
          labelText: 'password',
          hintText: 'password_hint',
          icon: Icons.lock_outline,
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
      ],
    );
  }
}
