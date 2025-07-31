import 'package:ecommerce_app/view/widget/auth/custom_text_form_fields.dart';
import 'package:flutter/material.dart';

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
    return Column(
      children: [
        // Pass Field
        CustomTextField(
          controller: passwordController,
          labelText: labelText,
          hintText: hintText,
          icon: Icons.lock_outline,
          keyboardType: TextInputType.text,
          obscureText: true,
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
