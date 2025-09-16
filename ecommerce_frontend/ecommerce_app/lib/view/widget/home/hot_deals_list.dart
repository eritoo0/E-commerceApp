import 'package:ecommerce_app/view/widget/home/hot_deals_card.dart';
import 'package:flutter/material.dart';

class HotDealsList extends StatelessWidget {
  final List products;

  const HotDealsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox.shrink(); // hide if no deals
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "🔥 Hot Deals",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return HotDealCard(product: product);
            },
          ),
        ),
      ],
    );
  }
}
