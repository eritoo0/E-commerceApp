import 'package:ecommerce_app/view/widget/auth/custom_text_form_fields.dart';
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
    return Column(
      children: [
        // Email Field
        CustomTextField(
            controller: emailController,
            labelText: 'email'.tr,
            hintText: 'email_hint'.tr,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 20),
      ],
    );
  }
}
