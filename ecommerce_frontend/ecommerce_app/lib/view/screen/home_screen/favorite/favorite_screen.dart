import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/controller/home_screen/favorite/favorite_controller.dart';
import 'package:ecommerce_app/controller/home_screen/home/home_controller.dart';
import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.find<HomeControllerImplement>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Favorites')),
      body: GetBuilder<FavoritesController>(
        builder: (favCtrl) {
          final favProducts = homeCtrl.products
              .where((p) => favCtrl.favorites[p['id']] == true)
              .toList();

          if (favProducts.isEmpty) {
            return const Center(child: Text('No favorites yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: favProducts.length,
            itemBuilder: (context, index) {
              final product = favProducts[index] as Map<String, dynamic>;
              return GestureDetector(
                onTap: () =>
                    Get.toNamed(AppRoute.productDetails, arguments: product),
                child: Card(
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: product['thumbnail_url'] ?? '',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(Icons.image),
                    ),
                    title: Text(product['name'] ?? 'Unnamed'),
                    subtitle: Text("${product['price']} DA"),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () => favCtrl.toggle(product['id'] as int),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
