import 'package:get/get.dart';

abstract class CartController extends GetxController {
  void addToCart(Map<String, dynamic> product, {int qty = 1});
  void removeOne(int productId);
  void removeItem(int productId);
  void clearCart();
}

class CartControllerImplement extends CartController {
  /// { productId : { "product": productMap, "quantity": int } }
  final RxMap<int, Map<String, dynamic>> _items =
      <int, Map<String, dynamic>>{}.obs;

  Map<int, Map<String, dynamic>> get items => _items;

  @override
  void addToCart(Map<String, dynamic> product, {int qty = 1}) {
    // id might be int or string, so normalise to int
    final int id = (product['id'] is num)
        ? (product['id'] as num).toInt()
        : int.parse(product['id'].toString());

    if (_items.containsKey(id)) {
      final current = (_items[id]!['quantity'] as num).toInt();
      _items[id]!['quantity'] = current + qty;
    } else {
      _items[id] = {
        'product': product,
        'quantity': qty,
      };
    }
  }

  @override
  void removeOne(int productId) {
    if (!_items.containsKey(productId)) return;
    final current = (_items[productId]!['quantity'] as num).toInt();
    if (current > 1) {
      _items[productId]!['quantity'] = current - 1;
    } else {
      _items.remove(productId);
    }
  }

  @override
  void removeItem(int productId) => _items.remove(productId);

  @override
  void clearCart() => _items.clear();

  int get totalItems => _items.values.fold<int>(
        0,
        (sum, item) => sum + (item['quantity'] as num).toInt(),
      );

  double get totalPrice => _items.values.fold(
        0.0,
        (sum, item) {
          final p = item['product']['price'];
          final price =
              p is num ? p.toDouble() : double.tryParse(p.toString()) ?? 0.0;
          return sum + price * (item['quantity'] as int);
        },
      );
}
