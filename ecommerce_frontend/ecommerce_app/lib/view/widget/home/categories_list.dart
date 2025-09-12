import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/core/constant/routes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesList extends StatelessWidget {
  final List categories;

  const CategoriesList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final String categoryName = category["name"] ?? 'Batatata';
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoute.products,
                arguments: {
                  'categoryId': category['id'],
                  'categoryName': category['name'] ?? 'Batata',
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: ColorApp.primaryColor,
                    radius: 40,
                    backgroundImage: category["image_url"] != null
                        ? NetworkImage(category["image_url"])
                        : null,
                    child: category["image_url"] == null
                        ? const Icon(Icons.category)
                        : null,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    categoryName,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
