import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/constant/color.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      height: 150,
      decoration: BoxDecoration(
        color: ColorApp.primaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          // ===== Decorative Circles (background layer) =====
          Positioned(
            top: -15,
            right: -13,
            child: _circle(150),
          ),
          Positioned(
            bottom: 10,
            left: 100,
            child: _circle(80),
          ),
          Positioned(
            top: 10,
            left: 5,
            child: _circle(40),
          ),

          // ===== Content (foreground layer) =====
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Text info
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "🔥 25% OFF ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "On selected electronics",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: ColorApp.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Shop Now"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: ColorApp.secoundColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(size / 2),
      ),
    );
  }
}
