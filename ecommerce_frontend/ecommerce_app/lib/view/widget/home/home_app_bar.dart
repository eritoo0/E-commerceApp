import 'package:ecommerce_app/controller/home_screen/cart/cart_controller.dart';
import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/core/constant/routes.dart';

import 'package:ecommerce_app/view/widget/home/icon_with_badge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSize {
  final IconButton? iconButton;
  final Widget searchWidget;
  const HomeAppBar({super.key, this.iconButton, required this.searchWidget});

  @override
  Size get preferredSize => const Size.fromHeight(96);
  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartControllerImplement>();

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
              Expanded(child: searchWidget),

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
                count: cartCtrl.totalItems,
                onTap: () {
                  Get.toNamed(AppRoute.cart);
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
