import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const FullScreenImagePage({
    super.key,
    required this.imageUrl,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.black,
      body: GestureDetector(
        // onTap: () => Navigator.pop(context), // close on tap
        child: Center(
          child: Hero(
            tag: heroTag,
            child: PhotoView(
              imageProvider: NetworkImage(imageUrl),
              backgroundDecoration:
                  const BoxDecoration(color: Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }
}
