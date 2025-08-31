import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/home/home_app_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorApp.bgColor,
      appBar: HomeAppBar(),
      body: Center(
        child: Text(
          "Home content goes here...",
          style: TextStyle(color: ColorApp.bodyFont),
        ),
      ),
    );
  }
}
