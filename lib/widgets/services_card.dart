// widgets/services_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ThemeController.dart';

// import 'package:my_app1/controllers/theme_controller.dart';

class ServicesCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ServicesCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDarkMode = themeController.isDark.value;

      return InkWell(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.only(top: 5),
          elevation: 6,
          color: isDarkMode
              ? const Color.fromARGB(255, 55, 55, 65)
              : const Color.fromARGB(255, 226, 226, 233),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: isDarkMode
                      ? const Color.fromARGB(255, 100, 180, 220)
                      : const Color.fromARGB(255, 24, 140, 182),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode
                        ? Colors.white
                        : const Color.fromARGB(255, 24, 140, 182),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
