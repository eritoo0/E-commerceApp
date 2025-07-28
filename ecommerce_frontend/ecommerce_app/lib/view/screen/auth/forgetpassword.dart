import 'package:ecommerce_app/controller/auth/forgetpassword_controller.dart';
import 'package:ecommerce_app/view/widget/auth/custom_body.dart';
import 'package:ecommerce_app/view/widget/auth/custom_title.dart';
import 'package:ecommerce_app/view/widget/auth/forgetpassword_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/auth/authbutton.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetpasswordControllerImplement controller =
        Get.put(ForgetpasswordControllerImplement());

    return Scaffold(
      backgroundColor: ColorApp.bgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.bgColor,
        elevation: 0,
        title: Text(
          "forgetPassword".tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTitle(title: "check_email".tr),
            const SizedBox(height: 10),
            CustomBody(bodyText: "check_email_sentence".tr),
            const SizedBox(height: 24),
            ForgetpasswordFields(
              emailController: controller.emailController,
            ),
            const SizedBox(height: 20),
            AuthButton(
              label: "check_email".tr,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
