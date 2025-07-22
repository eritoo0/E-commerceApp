import 'package:ecommerce_app/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/controller/onboarding_controller.dart';
import 'package:ecommerce_app/view/widget/onboarding/onboardingslider.dart';
import 'package:ecommerce_app/view/widget/onboarding/dots_indecators.dart';
import 'package:ecommerce_app/view/widget/onboarding/onboardingbutton.dart';
import 'package:ecommerce_app/core/constant/color.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingController());

    return Scaffold(
      backgroundColor: ColorApp.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child: SliderPage(), // PageView.builder is inside here
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: GetBuilder<OnBoardingController>(
                    builder: (controller) => Column(
                      children: [
                        DotsIndicator(
                          currentPage: controller.currentPage,
                          totalDots: onBoardingList.length,
                        ),
                        const Spacer(),
                        OnBoardingButtons(
                          currentPage: controller.currentPage,
                          onNext: controller.nextPage,
                          onSkip: controller.skip,
                        ),
                      ],
                    ),
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
