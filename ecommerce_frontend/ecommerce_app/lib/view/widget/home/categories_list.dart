import 'package:flutter/material.dart';

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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                CircleAvatar(
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
                  category["name"].toString(),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
