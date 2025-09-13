import 'package:ecommerce_app/controller/home/home_controller.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerImplement>(
        builder: (controller) => Container(
              height: 44,
              decoration: BoxDecoration(
                color: ColorApp.bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorApp.iconColor.withOpacity(.25)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              child: TextField(
                  controller: controller.searchController,
                  textInputAction: TextInputAction.search,
                  cursorColor: ColorApp.primaryColor,
                  style: const TextStyle(color: ColorApp.titleFont),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search_rounded, color: ColorApp.iconColor),
                    hintText: "Search products",
                    hintStyle: TextStyle(color: ColorApp.loginFont),
                    border: InputBorder.none,
                  ),
                  onSubmitted: controller.onSearch),
            ));
  }
}
