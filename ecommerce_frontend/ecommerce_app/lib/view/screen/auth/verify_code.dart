import 'package:ecommerce_app/controller/auth/verifycode_controller.dart';
import 'package:ecommerce_app/view/widget/auth/custom_body.dart';
import 'package:ecommerce_app/view/widget/auth/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/constant/color.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    VerifycodeControllerImplement controller =
        Get.put(VerifycodeControllerImplement());

    return Scaffold(
      backgroundColor: ColorApp.bgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.bgColor,
        elevation: 0,
        title: Text(
          "verifyCode".tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTitle(title: "check_code".tr),
            const SizedBox(height: 10),
            CustomBody(bodyText: "check_code_sentence".tr),
            const SizedBox(height: 24),
            OtpTextField(
              numberOfFields: 5,
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                controller.goToResetCode();
              }, // end onSubmit
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
