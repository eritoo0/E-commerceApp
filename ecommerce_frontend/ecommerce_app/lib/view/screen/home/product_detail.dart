import 'package:ecommerce_app/controller/home/product_detail_controller.dart';
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                controller.thumbnailUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, size: 100),
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
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        img["image_url"],
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) =>
                            const Icon(Icons.image, size: 50),
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
                  "\$${controller.price}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: controller.hasDiscount ? Colors.red : Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                if (controller.hasDiscount && controller.oldPrice != null)
                  Text(
                    "\$${controller.oldPrice}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // ---------- Stock ----------
            Obx(() => Text(
                  controller.stock.value > 0
                      ? "In stock: ${controller.stock.value}"
                      : "Out of stock",
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        controller.stock.value > 0 ? Colors.green : Colors.red,
                  ),
                )),
            const SizedBox(height: 16),

            // ---------- Description ----------
            Obx(() {
              if (controller.description.value.isEmpty) {
                return const SizedBox.shrink();
              }
              return Text(
                controller.description.value,
                style: const TextStyle(fontSize: 16, height: 1.5),
              );
            }),

            const SizedBox(height: 30),

            // ---------- Add to Cart Button ----------
            Obx(() => SizedBox(
                  width: double.infinity,
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
                )),
          ],
        ),
      ),
    );
  }
}
