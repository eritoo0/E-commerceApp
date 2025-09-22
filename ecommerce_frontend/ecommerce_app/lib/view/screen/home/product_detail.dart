import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/controller/home/product_detail_controller.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/screen/home/full_screen_iamge_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final Map product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsControllerImplement(product));

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.productName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Main Thumbnail ----------
            // ---------- Main Thumbnail with Zoom ----------
            GestureDetector(
              onTap: () => Get.to(
                () => FullScreenImagePage(
                  imageUrl: controller.thumbnailUrl,
                  heroTag: 'product-${controller.productId}', // unique tag
                ),
              ),
              child: Hero(
                tag:
                    'product-${controller.productId}', // must match FullScreenImagePage
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: controller.thumbnailUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    errorWidget: (context, error, stackTrace) =>
                        const Icon(Icons.image, size: 100),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ---------- Gallery Images ----------
            Obx(() {
              if (controller.images.isEmpty) {
                return const SizedBox.shrink();
              }
              return SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.images.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final img = controller.images[index];
                    final heroTag = 'gallery-${controller.productId}-$index';
                    return GestureDetector(
                      onTap: () => Get.to(
                        () => FullScreenImagePage(
                          imageUrl: img["image_url"],
                          heroTag: heroTag,
                        ),
                      ),
                      child: Hero(
                        tag: heroTag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: img["image_url"],
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorWidget: (context, error, stack) =>
                                const Icon(Icons.image, size: 50),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: 20),

            // ---------- Name ----------
            Text(
              controller.productName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            // ---------- Category ----------
            if (controller.categoryName != null)
              Text(
                "Category: ${controller.categoryName}",
                style: const TextStyle(color: Colors.grey),
              ),

            const SizedBox(height: 12),

            // ---------- Price + Discount ----------
            Row(
              children: [
                Text(
                  "${controller.price} DA",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: controller.hasDiscount ? Colors.red : Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                if (controller.hasDiscount && controller.oldPrice != null)
                  Text(
                    "${controller.oldPrice} DA",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text('Quantity',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 20),
                Obx(() => Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: controller.decreaseQty,
                        ),
                        Text(
                          controller.quantity.value.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: controller.increaseQty,
                        ),
                      ],
                    )),
              ],
            ),

            const SizedBox(height: 16),

            // ---------- Stock ----------
            Obx(() => Text(
                  controller.stockLabel(controller.stock.value),
                  style: TextStyle(
                    color: controller.stock == 0 ? Colors.red : Colors.green,
                  ),
                )),
            const SizedBox(height: 16),

            // ---------- Description ----------
            Obx(() {
              final fullText = controller.description.value;
              if (fullText.isEmpty) return const SizedBox.shrink();

              const int previewLength = 120;
              final bool expanded = controller.isDescriptionExpanded.value;

              final displayText = expanded || fullText.length <= previewLength
                  ? fullText
                  : '${fullText.substring(0, previewLength)}…';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayText,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  if (fullText.length > previewLength)
                    TextButton(
                      onPressed: controller.toggleDescription,
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        expanded ? 'Show less' : 'Show more',
                        style: const TextStyle(color: ColorApp.primaryColor),
                      ),
                    ),
                ],
              );
            }),

            // ---------- Color Picker ----------
            if (controller.availableColors.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text('Color',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              Wrap(
                spacing: 10,
                children: controller.availableColors.map((color) {
                  return Obx(() {
                    final isSelected = controller.selectedColor.value == color;
                    return ChoiceChip(
                      label: Text(color),
                      selected: isSelected,
                      onSelected: (_) => controller.selectedColor.value = color,
                      selectedColor: ColorApp.primaryColor,
                    );
                  });
                }).toList(),
              ),
            ],

// ---------- Size Picker (only if brand requires size) ----------
            if (controller.requiresSize &&
                controller.availableSizes.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text('Size', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              Wrap(
                spacing: 10,
                children: controller.availableSizes.map((size) {
                  return Obx(() {
                    final isSelected = controller.selectedSize.value == size;
                    return ChoiceChip(
                      label: Text(size),
                      selected: isSelected,
                      onSelected: (_) => controller.selectedSize.value = size,
                      selectedColor: Colors.green.shade200,
                    );
                  });
                }).toList(),
              ),
            ],

            const SizedBox(height: 30),

            // ---------- Add to Cart Button ----------
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.stock.value > 0
                          ? controller.addToCart
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue,
                        disabledBackgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12), // small gap between buttons
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          controller.stock.value > 0 ? controller.buyNow : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.orange,
                        disabledBackgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        "Buy now",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
