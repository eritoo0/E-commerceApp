import 'package:ecommerce_app/view/screen/home_screen/profile/profile_screen.dart';
import 'package:ecommerce_app/view/screen/home_screen/cart/cart_screen.dart';
import 'package:ecommerce_app/view/screen/home_screen/favorite/favorite_screen.dart';
import 'package:ecommerce_app/view/screen/home_screen/home/home.dart';
import 'package:ecommerce_app/view/widget/home/home_bottom_nav_bar.dart';
import 'package:ecommerce_app/view/widget/home/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/home/home_app_bar.dart';
import 'package:ecommerce_app/controller/home_screen/home/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenControllerImplement());

    const pages = [
      Home(),
      FavoritesScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return Obx(() {
      final index = controller.currentIndex.value;
      return Scaffold(
        backgroundColor: ColorApp.bgColor,
        appBar: index == 0
            ? const HomeAppBar(
                searchWidget: SearchField(),
              )
            : const PreferredSize(
                preferredSize: Size.fromHeight(0), child: SizedBox()),
        // : AppBar(
        //     title: Text(
        //       ["Favorite", "Cart", "Profile"][index - 1],
        //     ),
        //   ),
        body: pages[index],
        bottomNavigationBar: HomeBottomNav(
          currentIndex: index,
          onTap: controller.changeTab,
        ),
      );
    });
  }
}
