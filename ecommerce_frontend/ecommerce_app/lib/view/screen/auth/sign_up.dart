import 'package:ecommerce_app/controller/auth/signup_controller.dart';
import 'package:ecommerce_app/view/widget/auth/custom_body.dart';
import 'package:ecommerce_app/view/widget/auth/custom_title.dart';
import 'package:ecommerce_app/view/widget/auth/logo_auth.dart';
import 'package:ecommerce_app/view/widget/auth/sign_up_form.dart';
import 'package:ecommerce_app/view/widget/auth/signin_up_prompt.dart';
import 'package:ecommerce_app/view/widget/auth/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/auth/authButton.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpControllerImplement());

    return Scaffold(
      backgroundColor: ColorApp.bgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.bgColor,
        elevation: 0,
        title: Text(
          "login".tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LogoAuth(),
            CustomTitle(title: "welcome".tr),
            const SizedBox(height: 10),
            CustomBody(bodyText: "login_sentence".tr),
            const SizedBox(height: 24),
            SignUpForm(
              emailController: controller.emailController,
              passwordController: controller.passwordController,
              phoneController: controller.phoneController,
              fullNameController: controller.fullNameController,
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 20),
            AuthButton(
              label: "Signup".tr,
              onPressed: () {},
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
                  controller.goToSignUp();
                })
          ],
        ),
      ),
    );
  }
}
