import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/home/searchbar.dart';
import 'package:ecommerce_app/view/widget/home/icon_with_badge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSize {
  final IconButton? iconButton;
  const HomeAppBar({super.key, this.iconButton});

  @override
  Size get preferredSize => const Size.fromHeight(96);
  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorApp.bgColorLangBeg, ColorApp.bgColorLangEnd],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              if (iconButton != null) ...[
                iconButton!,
                const SizedBox(width: 12),
              ],
              // Search field
              const Expanded(child: SearchField()),

              const SizedBox(width: 12),

              // Notification icon with badge
              IconWithBadge(
                icon: Icons.notifications_none_rounded,
                count: 2, // adding real cpunt
                onTap: () {
                  // show notifs
                  Get.snackbar("Notifications", "Open notifications",
                      snackPosition: SnackPosition.TOP);
                },
              ),

              const SizedBox(width: 8),

              // Cart icon with badge
              IconWithBadge(
                icon: Icons.shopping_cart_outlined,
                count: 1, // fill with real count
                onTap: () {
                  // go to cart page
                  Get.snackbar("Cart", "Open cart",
                      snackPosition: SnackPosition.TOP);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
