import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  // الحالة الحالية: true = Dark, false = Light
  var isDarkMode = false.obs;
  final box = GetStorage();
  var isDark = false.obs;
  @override
  void onInit() {
    isDark.value = box.read('isDark') ?? false;
    super.onInit();
  }

// لتبديل الوضع

  void toggleTheme(bool value) {
    isDark.value = value;
    box.write('isDark', value);
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
    update();
  }
}
