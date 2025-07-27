import 'package:ecommerce_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
    OutlineInputBorder roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return Column(
      children: [
        TextFormField(
          controller: fullNameController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: 'fullname'.tr,
            hintText: 'fullname_hint'.tr,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            prefixIcon: const Icon(Icons.badge_outlined),
            prefixIconColor: ColorApp.iconColor,
            border: roundedBorder,
            enabledBorder: roundedBorder,
            focusedBorder: roundedBorder,
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: 'email'.tr,
            hintText: 'email_hint'.tr,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            prefixIcon: const Icon(Icons.email_outlined),
            prefixIconColor: ColorApp.iconColor,
            border: roundedBorder,
            enabledBorder: roundedBorder,
            focusedBorder: roundedBorder,
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: 'phone'.tr,
            hintText: 'phone_hint'.tr,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            prefixIcon: const Icon(Icons.phone_android_outlined),
            prefixIconColor: ColorApp.iconColor,
            border: roundedBorder,
            enabledBorder: roundedBorder,
            focusedBorder: roundedBorder,
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: 'password'.tr,
            hintText: 'password_hint'.tr,
            labelStyle: Theme.of(context).textTheme.bodySmall,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            prefixIcon: const Icon(Icons.lock_outline),
            prefixIconColor: ColorApp.iconColor,
            border: roundedBorder,
            enabledBorder: roundedBorder,
            focusedBorder: roundedBorder,
          ),
        ),
      ],
    );
  }
}
