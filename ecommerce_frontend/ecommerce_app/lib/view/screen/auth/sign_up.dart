import 'package:ecommerce_app/controller/auth/signup_controller.dart';
import 'package:ecommerce_app/core/functions/valid_input.dart';
import 'package:ecommerce_app/view/widget/auth/custom_body.dart';
import 'package:ecommerce_app/view/widget/auth/custom_text_form_fields.dart';
import 'package:ecommerce_app/view/widget/auth/custom_title.dart';
import 'package:ecommerce_app/view/widget/auth/logo_auth.dart';
import 'package:ecommerce_app/view/widget/auth/signin_up_prompt.dart';
import 'package:ecommerce_app/view/widget/auth/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/auth/authbutton.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorApp.bgColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorApp.bgColor,
          elevation: 0,
          title: Text(
            "signup".tr,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        body: GetBuilder<SignUpControllerImplement>(
          builder: (controller) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LogoAuth(),
                  CustomTitle(title: "welcome".tr),
                  const SizedBox(height: 10),
                  CustomBody(bodyText: "login_sentence".tr),
                  const SizedBox(height: 24),

                  // Full Name (Username validation)
                  CustomTextField(
                    controller: controller.fullNameController,
                    validator: (val) {
                      return validInput(val!, 3, 30, 'username');
                    },
                    labelText: 'fullname',
                    hintText: 'fullname_hint',
                    icon: Icons.badge_outlined,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 20),

                  // Email
                  CustomTextField(
                    controller: controller.emailController,
                    validator: (val) {
                      return validInput(val!, 6, 50, 'email');
                    },
                    labelText: 'email',
                    hintText: 'email_hint',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // Phone
                  CustomTextField(
                    controller: controller.phoneController,
                    validator: (val) {
                      return validInput(val!, 10, 15, 'phone');
                    },
                    labelText: 'phone',
                    hintText: 'phone_hint',
                    icon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 20),

                  // Password
                  CustomTextField(
                    controller: controller.passwordController,
                    validator: (val) {
                      return validInput(val!, 8, 30, 'password');
                    },
                    labelText: 'password',
                    hintText: 'password_hint',
                    icon: Icons.lock_outline,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),

                  const SizedBox(height: 16),

                  const SizedBox(height: 20),
                  AuthButton(
                    label: "signup".tr,
                    onPressed: () {
                      controller.signUp();
                    },
                  ),
                  const SizedBox(height: 40),
                  //  Social icons
                  const SocialIcons(),
                  const SizedBox(height: 30),
                  // Sign up prompt
                  SignInUpPrompt(
                      txtOne: "have_an_account".tr,
                      txtTwo: "login".tr,
                      onPressed: () {
                        controller.goToLogin();
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
