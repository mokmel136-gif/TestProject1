import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app1/utils/icons_map.dart';
import '../controller/ThemeController.dart';

class ProductCategoryCard extends StatelessWidget {
  final String title;
  final String icon; // جاي كـ String من الـ API
  final VoidCallback onTap;

  const ProductCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    // اطبع قيمة الأيقونة للتأكد
    print("🟢 ProductCategoryCard -> icon: $icon");

    // حوّل النص إلى IconData من الـ Map
    final IconData selectedIcon = IconsMap[icon] ?? Icons.help;

    return Obx(() {
      final isDarkMode = themeController.isDark.value;
      return GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 6,
          color: isDarkMode
              ? const Color.fromARGB(255, 55, 55, 65)
              : const Color.fromARGB(255, 226, 226, 233),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selectedIcon,
                size: 40,
                color: isDarkMode
                    ? const Color.fromARGB(255, 100, 180, 220)
                    : const Color.fromARGB(255, 24, 140, 182),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }
}
