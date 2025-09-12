import 'package:ecommerce_app/view/screen/home/home.dart';
import 'package:ecommerce_app/view/widget/home/home_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/home/home_app_bar.dart';
import 'package:ecommerce_app/controller/home/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenControllerImplement());

    const pages = [
      Home(),
      Center(child: Text("Favorite Page")),
      Center(child: Text("Cart Page")),
      Center(child: Text("Profile Page")),
    ];

    return Obx(() {
      final index = controller.currentIndex.value;
      return Scaffold(
        backgroundColor: ColorApp.bgColor,
        appBar: index == 0
            ? const HomeAppBar()
            : AppBar(
                title: Text(
                  ["Favorite", "Cart", "Profile"][index - 1],
                ),
              ),
        body: pages[index],
        bottomNavigationBar: HomeBottomNav(
          currentIndex: index,
          onTap: controller.changeTab,
        ),
      );
    });
  }
}
