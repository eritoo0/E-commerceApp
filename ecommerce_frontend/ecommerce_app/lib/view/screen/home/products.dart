import 'package:ecommerce_app/controller/home/products_controller.dart';
import 'package:ecommerce_app/view/widget/home/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/view/widget/home/products_grid.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final int categoryId = args['categoryId'];
    // final String categoryName = args['categoryName'];

    final scrollController = ScrollController();

    // Put controller with categoryId
    final controller = Get.put(ProductsControllerImplement(categoryId),
        tag: 'cat_$categoryId');

    return Scaffold(
      //appBar: AppBar(title: Text(categoryName)),
      appBar: HomeAppBar(
        iconButton: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black12),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<ProductsControllerImplement>(
        tag: 'cat_$categoryId',
        builder: (_) {
          if (controller.statusRequest == StatusRequest.loading &&
              controller.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.statusRequest == StatusRequest.failure) {
            return const Center(child: Text('Failed to load products'));
          }
          if (controller.products.isEmpty) {
            return const Center(child: Text('No products i n this category !'));
          }

          return ProductGrid(
            products: controller.products,
            scrollController: scrollController,
          );
        },
      ),
    );
  }
}
