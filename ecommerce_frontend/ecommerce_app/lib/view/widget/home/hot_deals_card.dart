import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/controller/home_screen/favorite/favorite_controller.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HotDealCard extends StatelessWidget {
  //final Map product;
  final Map<String, dynamic> product;

  const HotDealCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favCtrl = Get.find<FavoritesController>();
    final int id = product["id"];

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoute.productDetails, arguments: product),
      child: SizedBox(
        width: 180,
        child: Card(
          color: ColorApp.bgColor,
          elevation: 3,
          shadowColor: Colors.black26,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ======= IMAGE + FAVORITE OVERLAY =======
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.3,
                      child: product["thumbnail_url"] != null
                          ? CachedNetworkImage(
                              imageUrl: product["thumbnail_url"],
                              fit: BoxFit.fill,
                              placeholder: (c, _) => const Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2)),
                              errorWidget: (c, _, __) => const Icon(
                                  Icons.image_not_supported,
                                  size: 60),
                            )
                          : const Icon(Icons.image_not_supported, size: 60),
                    ),
                    // Favorite icon button positioned in the top-right corner
                    Positioned(
                      top: 6,
                      right: 6,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.black.withOpacity(0.4),
                        child: Obx(() {
                          final isFav = favCtrl.favorites[id] ?? false;

                          (product["is_favorite"] == true);
                          return IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => favCtrl.toggle(id),
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.white,
                              size: 18,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              // ======= NAME =======
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Text(
                  product["name"] ?? "Unnamed",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              // ======= PRICE =======
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "\$${product["price"]} DA",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    if (product["old_price"] != null)
                      Flexible(
                        child: Text(
                          "\$${product["old_price"]}",
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // ======= SHORT DESCRIPTION + RATING=======
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      product["short_description"] ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          product["average_rating"]?.toString() ?? "0.0",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
