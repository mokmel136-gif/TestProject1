
//
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app1/controller/ControllerImage.dart';
import 'package:my_app1/controller/GetSto.dart';
import 'package:my_app1/pages/Profile/ProfilePage.dart';
import 'package:my_app1/pages/Screens_Login/Login.dart';

import '../controller/ThemeController.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final authUser = AuthUser();

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final ProfileController con = Get.put(ProfileController());
    final user = AuthUser().getUser();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text("الإعدادات")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              //  عرض معلومات المستخدم في المنتصف
              Obx(
                () => GestureDetector(
                  onTap: () {
                    if (authUser.isLogin.value) {
                      Get.to(() => ProfilePage());
                    } else {
                      Get.to(() => Login());
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      // صورة المستخدم
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: con.image.value != null
                            ? FileImage(con.image.value!)
                            : null,
                        child: con.image.value == null
                            ? Icon(
                                Icons.account_circle,
                                size: 90,
                                color: con.isDarkMode.value
                                    ? const Color.fromARGB(255, 55, 55, 65)
                                    : const Color.fromARGB(255, 58, 110, 153),
                              )
                            : null,
                      ),
                      const SizedBox(height: 15),

                      // اسم المستخدم
                      Text(
                        authUser.isLogin.value
                            ? (user?.name ?? "بدون اسم")
                            : "الرجاء تسجيل الدخول",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // البريد الإلكتروني
                      Text(
                        authUser.isLogin.value ? (user?.email ?? "") : "",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
              Divider(thickness: 1),

              //  باقي الإعدادات
              Obx(
                () => SwitchListTile(
                  secondary: const Icon(Icons.dark_mode),
                  title: const Text("الوضع الداكن"),
                  value: themeController.isDark.value,
                  onChanged: themeController.toggleTheme,
                ),
              ),

              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('اتصل بنا'),
                onTap: () {
                  Get.snackbar("اتصل بنا", "البريد: example@email.com");
                },
              ),

              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('الأسئلة الشائعة'),
                onTap: () {
                  Get.snackbar("الأسئلة الشائعة", "سيتم إضافة المحتوى قريبًا");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
