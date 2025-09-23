import 'package:ecommerce_app/controller/home_screen/home/products_controller.dart';
import 'package:ecommerce_app/view/widget/home/cateory_search_field.dart';
import 'package:ecommerce_app/view/widget/home/home_app_bar.dart';
import 'package:ecommerce_app/view/widget/home/products_grid.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final int categoryId = args['categoryId'];
    // final String categoryName = args['categoryName'];

    final scrollController = ScrollController();

    // Put controller with tag so each category has its own instance
    final controller = Get.put(
      ProductsControllerImplement(categoryId),
      tag: 'cat_$categoryId',
    );

    return GetBuilder<ProductsControllerImplement>(
      tag: 'cat_$categoryId',
      builder: (_) {
        return Scaffold(
          appBar: HomeAppBar(
            iconButton: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            searchWidget: CateorySearchBar(tag: 'cat_$categoryId'),
          ),
          body: Builder(
            builder: (context) {
              if (controller.statusRequest == StatusRequest.loading &&
                  controller.products.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.statusRequest == StatusRequest.failure) {
                return const Center(child: Text('Failed to load products'));
              }

              if (controller.products.isEmpty) {
                return const Center(
                    child: Text('No products in this category!'));
              }

              return ProductGrid(
                products: controller.products,
                scrollController: scrollController,
              );
            },
          ),
        );
      },
    );
  }
}
