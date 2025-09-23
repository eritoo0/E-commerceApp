import 'package:ecommerce_app/core/constant/routes.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myServices = Get.find<MyServices>();
    final username =
        myServices.sharedPreferences.getString("username") ?? "Guest";
    final email =
        myServices.sharedPreferences.getString("email") ?? "user@example.com";

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: Column(
          children: [
            // ---- Header Section ----
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  // Avatar
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/images/fbicon.png'),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  // Name & Email
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, $username",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      // TODO: Navigate to Edit Profile
                    },
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ---- Action List ----
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _ProfileTile(
                      icon: Icons.shopping_bag_outlined,
                      title: 'My Orders',
                      onTap: () {},
                    ),
                    _ProfileTile(
                      icon: Icons.favorite_border,
                      title: 'Favorites',
                      onTap: () {
                        Get.toNamed(AppRoute.favorite);
                      },
                    ),
                    _ProfileTile(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {},
                    ),
                    _ProfileTile(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    _ProfileTile(
                      icon: Icons.logout,
                      title: 'Log Out',
                      color: Colors.red,
                      onTap: () async {
                        // Clear saved credentials
                        await myServices.sharedPreferences.remove('token');
                        await myServices.sharedPreferences.remove('access');
                        await myServices.sharedPreferences.remove('refresh');
                        await myServices.sharedPreferences.remove('id');
                        await myServices.sharedPreferences.remove('username');
                        await myServices.sharedPreferences.remove('email');
                        await myServices.sharedPreferences.remove('phone');
                        Get.offAllNamed('/login');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable list tile with rounded card look
class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const _ProfileTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.blueAccent),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: color ?? Colors.black87,
          ),
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
