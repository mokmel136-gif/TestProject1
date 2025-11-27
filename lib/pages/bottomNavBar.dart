import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_app1/pages/products/shop_screen.dart';

import '../controller/BottomNavController.dart';
import '../controller/ThemeController.dart';
import 'CartScreen.dart';
import 'Settings.dart';
import 'home_screen.dart';

class Bottomnavbar extends StatelessWidget {
  Bottomnavbar({super.key});

  final List<Widget> _pages = [
    SettingsPage(),
    const CartScreen(),
    ShopScreen(),
    HomeScreen(),
  ];

  final BottomNavController navController = Get.put(BottomNavController());
  final ThemeController themeController =
      Get.find<ThemeController>(); // الحصول على ThemeController

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = themeController.isDark.value;

      return Scaffold(
        body: _pages[navController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: isDarkMode
              ? const Color.fromARGB(255, 45, 45, 55) // لون داكن للخلفية
              : const Color.fromARGB(255, 58, 110, 153), // اللون الأصلي
          selectedItemColor: isDarkMode
              ? const Color.fromARGB(
                  255,
                  100,
                  180,
                  220,
                ) // لون فاتح للعنصر المحدد
              : const Color.fromARGB(255, 255, 255, 255), // اللون الأصلي
          unselectedItemColor: isDarkMode
              ? const Color.fromARGB(
                  255,
                  150,
                  150,
                  150,
                ) // لون رمادي للعناصر غير المحددة
              : const Color.fromARGB(255, 114, 114, 111), // اللون الأصلي
          type: BottomNavigationBarType.fixed,
          currentIndex: navController.currentIndex.value,
          onTap: (index) {
            navController.navagationPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "الاعدادات",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "السلة",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              label: "قطع الغيار",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          ],
        ),
      );
    });
  }
}
