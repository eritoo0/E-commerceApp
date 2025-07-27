import 'package:ecommerce_app/core/constant/image_asset.dart';
import 'package:flutter/material.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
        image: DecorationImage(
          image: AssetImage(ImageAsset.authlogo),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
