import 'package:ecommerce_app/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myServices = Get.find<MyServices>();
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text("HI ${myServices.sharedPreferences.getString("username")}"),
        //centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            // --- User Info Card ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          const AssetImage('assets/images/fbicon.png'),
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(width: 20),
                    // Name & Email
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Eritoo',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'eritoobnz@gmail.com',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // TODO: Navigate to Edit Profile
                      },
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- Options List ---
            _ProfileTile(
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              onTap: () {},
            ),
            _ProfileTile(
              icon: Icons.favorite_border,
              title: 'Favorites',
              onTap: () {},
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
            _ProfileTile(
              icon: Icons.logout,
              title: 'Log Out',
              color: Colors.red,
              onTap: () {
                () async {
                  await myServices.sharedPreferences.remove('token');
                  await myServices.sharedPreferences.remove('access');
                  await myServices.sharedPreferences.remove('refresh');
                  await myServices.sharedPreferences.remove('id');
                  await myServices.sharedPreferences.remove('username');
                  await myServices.sharedPreferences.remove('email');
                  await myServices.sharedPreferences.remove('phone');
                  Get.offAllNamed('/login');
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable ListTile widget
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
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.blueGrey),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: color ?? Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
