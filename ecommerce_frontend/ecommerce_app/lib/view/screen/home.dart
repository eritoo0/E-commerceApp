import 'package:ecommerce_app/controller/home_controller.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/home/categories_list.dart';
import 'package:ecommerce_app/view/widget/home/home_app_bar.dart';
import 'package:ecommerce_app/view/widget/home/offer_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.bgColor,
      appBar: const HomeAppBar(),
      body: GetBuilder<HomeControllerImplement>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.statusRequest == StatusRequest.failure) {
            return const Center(child: Text("Something went wrong"));
          }

          if (controller.categories.isEmpty) {
            return const Center(child: Text("No categories found"));
          }

          return ListView(
            children: [
              const OfferBanner(),
              const SizedBox(height: 20),
              CategoriesList(categories: controller.categories),
            ],
          );
        },
      ),
    );
  }
}
