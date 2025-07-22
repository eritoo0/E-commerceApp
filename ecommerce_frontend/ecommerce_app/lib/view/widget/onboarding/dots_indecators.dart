import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/constant/color.dart';

class DotsIndicator extends StatelessWidget {
  final int currentPage;
  final int totalDots;

  const DotsIndicator({
    super.key,
    required this.currentPage,
    required this.totalDots,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        bool isActive = index == currentPage;
        return AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: isActive ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? ColorApp.primaryColor : Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
