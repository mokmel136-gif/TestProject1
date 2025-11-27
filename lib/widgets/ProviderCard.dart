// widgets/ProviderCard.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ThemeController.dart';
import '../models/provider_item.dart';

class ProviderCard extends StatelessWidget {
  final ProviderItem provider;
  final VoidCallback? onTap;

  const ProviderCard({
    super.key,
    required this.provider,
    this.onTap,
  });

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
              ? const Color.fromARGB(255, 55, 55, 65)
              : const Color.fromARGB(255, 226, 226, 233),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(provider.imageUrl),
              radius: 30,
              backgroundColor: isDarkMode
                  ? const Color.fromARGB(255, 75, 75, 85)
                  : Colors.grey[200],
            ),
            title: Text(
              provider.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  provider.rating.toString(),
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDarkMode
                  ? const Color.fromARGB(255, 150, 150, 150)
                  : Colors.grey[600],
            ),
            onTap: onTap, //  نستقبل الحدث من الخارج
          ),
        ),
      );
    });
  }
}
