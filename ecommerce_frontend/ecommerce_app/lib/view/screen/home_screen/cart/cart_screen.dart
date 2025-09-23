import 'package:ecommerce_app/controller/home_screen/cart/cart_controller.dart';
import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartControllerImplement>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: Obx(() {
        if (cartCtrl.items.isEmpty) {
          return const Center(child: Text('Your cart is empty.'));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: cartCtrl.items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final entry = cartCtrl.items.entries.elementAt(i);
                  final product =
                      entry.value['product'] as Map<String, dynamic>;
                  final qty = entry.value['quantity'] as int;

                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.productDetails, arguments: product);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: (product['thumbnail_url'] != null &&
                                product['thumbnail_url'] != '')
                            ? NetworkImage(product['thumbnail_url'])
                            : const AssetImage(
                                    'assets/images/placeholder.png') // we add later
                                as ImageProvider,
                      ),
                      title: Text(product['name'] ?? 'Unnamed'),
                      subtitle: Text('${product['price']} DA'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => cartCtrl.removeOne(product['id']),
                          ),
                          Text('$qty',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => cartCtrl.addToCart(product),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ${cartCtrl.totalPrice.toStringAsFixed(2)} DA',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.snackbar('frgh jibk',
                          'Total: ${cartCtrl.totalPrice.toStringAsFixed(2)} DA');
                    },
                    child: const Text('frgh jibk'),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
