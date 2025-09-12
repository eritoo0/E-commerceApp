import 'package:ecommerce_app/view/screen/home/home.dart';
import 'package:ecommerce_app/view/widget/home/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/home/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Home(),
    Center(child: Text("Favorite Page")),
    Center(child: Text("Cart Page")),
    Center(child: Text("Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.bgColor,
      appBar: _currentIndex == 0
          ? const HomeAppBar()
          : AppBar(
              title: Text(
                ["Favorite", "Cart", "Profile"][_currentIndex - 1],
              ),
            ),
      body: _pages[_currentIndex],
      bottomNavigationBar: HomeBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
