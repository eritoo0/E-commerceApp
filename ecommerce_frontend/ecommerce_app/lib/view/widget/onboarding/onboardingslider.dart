import 'package:ecommerce_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/controller/onboarding_controller.dart';
import 'package:ecommerce_app/data/datasource/static/static.dart';

class SliderPage extends StatelessWidget {
  const SliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    OnBoardingController controller = Get.find();

    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      itemCount: onBoardingList.length,
      itemBuilder: (context, i) => Column(
        children: [
          Text(
            onBoardingList[i].title!.tr,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: ColorApp.titleFont,
            ),
          ),
          const SizedBox(height: 80),
          Image.asset(
            onBoardingList[i].image!,
            width: 200,
            height: 230,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              onBoardingList[i].body!.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.6,
                color: ColorApp.bodyFont,
              ),
            ),
          )
        ],
      ),
    );
  }
}
