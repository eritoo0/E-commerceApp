import 'package:ecommerce_app/core/constant/image_asset.dart';
import 'package:flutter/material.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            print("Google tapped");
          },
          child: Image.asset(
            ImageAsset.googleIcon,
            width: 50,
            height: 50,
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            print("Facebook tapped");
          },
          child: Image.asset(
            ImageAsset.facebookIocn,
            width: 50,
            height: 50,
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            print("Twitter tapped");
          },
          child: Image.asset(
            ImageAsset.twitterIcon,
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }
}
