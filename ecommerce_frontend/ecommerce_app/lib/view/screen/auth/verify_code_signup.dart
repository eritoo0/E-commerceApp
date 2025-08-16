import 'package:ecommerce_app/controller/auth/verifycode_signup_controller.dart';
import 'package:ecommerce_app/view/widget/auth/custom_body.dart';
import 'package:ecommerce_app/view/widget/auth/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/constant/color.dart';

class VerifyCodeSignup extends StatelessWidget {
  const VerifyCodeSignup({super.key});

  @override
  Widget build(BuildContext context) {
    VerifycodeSignupControllerImplement controller =
        Get.put(VerifycodeSignupControllerImplement());

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                numberOfFields: 6,
                borderColor: ColorApp.primaryColor,
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (code) {
                  controller.codeController.text = code;
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  controller.checkCode(code: verificationCode);
                }, // end onSubmit
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    controller.resendCode();
                  },
                  child: Text(
                    'resend_code'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
