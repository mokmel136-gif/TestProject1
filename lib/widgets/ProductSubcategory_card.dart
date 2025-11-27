import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ThemeController.dart';

class ProductSubcategoryCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProductSubcategoryCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'ثلاجات':
        return Icons.kitchen;
      case 'غسالات':
        return Icons.local_laundry_service;
      case 'مكيفات':
        return Icons.ac_unit;
      case 'أفران':
        return Icons.kitchen_outlined;
      case 'أنابيب':
        return Icons.plumbing;
      case 'حنفيات':
        return Icons.water_damage;
      case 'مضخات':
        return Icons.invert_colors;
      case 'أسلاك':
        return Icons.electric_bolt;
      case 'مفاتيح':
        return Icons.toggle_on;
      case 'لمبات':
        return Icons.lightbulb;
      case 'دهانات جدران':
        return Icons.format_paint;
      case 'مواد طلاء':
        return Icons.palette;
      case 'معجون':
        return Icons.construction;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDarkMode = themeController.isDark.value;

      return Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 6,
          color: isDarkMode
              ? const Color.fromARGB(255, 55, 55, 65) // لون داكن للخلفية
              : const Color.fromARGB(255, 226, 226, 233), // اللون الأصلي
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            visualDensity: const VisualDensity(vertical: 2),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color.fromARGB(255, 75, 75, 85) // لون داكن للدائرة
                    : Colors.blue.shade50, // اللون الأصلي
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForCategory(title),
                color: isDarkMode
                    ? const Color.fromARGB(
                        255,
                        100,
                        180,
                        220,
                      ) // لون أزرق فاتح للوضع الداكن
                    : Colors.blue, // اللون الأصلي
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode
                    ? Colors.white // نص أبيض في الوضع الداكن
                    : Colors.black87, // اللون الأصلي
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward,
              size: 18,
              color: isDarkMode
                  ? const Color.fromARGB(
                      255,
                      150,
                      150,
                      150,
                    ) // لون رمادي للوضع الداكن
                  : Colors.grey[600], // اللون الأصلي
            ),
            onTap: onTap,
          ),
        ),
      );
    });
  }
}
