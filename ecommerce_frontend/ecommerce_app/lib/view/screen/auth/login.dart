import 'package:ecommerce_app/view/widget/login/custom_body.dart';
import 'package:ecommerce_app/view/widget/login/custom_title.dart';
import 'package:ecommerce_app/view/widget/login/logo_auth.dart';
import 'package:ecommerce_app/view/widget/login/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/login/login_button.dart';
import 'package:ecommerce_app/view/widget/login/loginform.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(LoginController());
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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
            LogoAuth(),
            CustomTitle(title: "welcome".tr),
            const SizedBox(height: 10),
            CustomBody(bodyText: "login_sentence".tr),
            const SizedBox(height: 24),
            LoginFields(
              emailController: emailController,
              passwordController: passwordController,
            ),
            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Forgot password
                },
                child: Text(
                  'forgot_password'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ),

            const SizedBox(height: 20),
            LoginButton(
              label: "login".tr,
              onPressed: () {
                // TODO: Handle login
              },
            ),
            const SizedBox(height: 40),
            //  Social icons
            SocialIcons(),
            const SizedBox(height: 30),
            // Sign up prompt
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "don't_have_account".tr,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to sign-up
                  },
                  child: Text(
                    'signup'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: ColorApp.primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
