import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_app1/controller/ControllerImage.dart';
import 'package:my_app1/controller/GetSto.dart' show AuthUser;

import '../../../controller/ThemeController.dart';
import '../../../pages/bottomNavBar.dart';
import '../../widgets/CustomElevatedbuttonu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // جلب بيانات المستخدم المخزنة
    final us = AuthUser().authUser;

    // جلب ThemeController للتحكم في الوضع الليلي / النهاري
    final ThemeController themeController = Get.find<ThemeController>();

    // جلب ProfileController لإدارة صورة الملف الشخصي
    final ProfileController con = Get.put(ProfileController());

    return Obx(() {
      // مراقبة تغييرات الوضع الليلي
      final isDarkMode = themeController.isDark.value;

      return Scaffold(
        backgroundColor: isDarkMode
            ? const Color.fromARGB(255, 55, 55, 65) // لون داكن للخلفية
            : const Color.fromARGB(255, 58, 110, 153), // لون رئيسي فاتح
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 160), // مسافة علوية لإزاحة محتوى الصفحة
              // صورة المستخدم + أيقونة تغيير الصورة
              Obx(
                () => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // دائرة لعرض صورة المستخدم أو أيقونة حساب افتراضية
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage: con.image.value != null
                          ? FileImage(con.image.value!)
                          : null,
                      child: con.image.value == null
                          ? Icon(
                              Icons.account_circle,
                              size: 110,
                              color: con.isDarkMode.value
                                  ? const Color.fromARGB(255, 55, 55, 65)
                                  : const Color.fromARGB(255, 58, 110, 153),
                            )
                          : null,
                    ),
                    // زر الكاميرا لتغيير الصورة
                    Positioned(
                      bottom: -1,
                      right: 6,
                      child: GestureDetector(
                        onTap: () {
                          final auth = AuthUser();
                          if (auth.authUser != null) {
                            con.pickImage(auth.authUser!.email);
                          }
                        },
                        // عند الضغط، يتم اختيار صورة جديدة
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: con.isDarkMode.value
                                ? const Color.fromARGB(255, 55, 55, 65)
                                : const Color.fromARGB(255, 58, 110, 153),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // بطاقة معلومات المستخدم (الاسم والبريد الإلكتروني)
              Container(
                height: 260,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 239, 237, 237),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      offset: Offset(0, 10),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // اسم المستخدم
                    ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: isDarkMode
                            ? const Color.fromARGB(255, 55, 55, 65)
                            : const Color.fromARGB(255, 58, 110, 153),
                      ),
                      title: Text(
                        "الاسم",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? const Color.fromARGB(255, 55, 55, 65)
                              : const Color.fromARGB(255, 58, 110, 153),
                        ),
                      ),
                      subtitle: Text(
                        us!.name, // عرض اسم المستخدم
                        style: TextStyle(
                          fontSize: 23,
                          color: isDarkMode
                              ? const Color.fromARGB(255, 55, 55, 65)
                              : const Color.fromARGB(255, 58, 110, 153),
                        ),
                      ),
                    ),

                    Divider(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 55, 55, 65)
                          : const Color.fromARGB(255, 58, 110, 153),
                    ),

                    // بريد المستخدم الإلكتروني
                    ListTile(
                      leading: Icon(
                        Icons.email,
                        color: isDarkMode
                            ? const Color.fromARGB(255, 55, 55, 65)
                            : const Color.fromARGB(255, 58, 110, 153),
                      ),
                      title: Text(
                        "البريد الإلكتروني",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? const Color.fromARGB(255, 58, 110, 153)
                              : const Color.fromARGB(255, 55, 55, 65),
                        ),
                      ),
                      subtitle: Text(
                        us.email, // عرض البريد الإلكتروني للمستخدم
                        style: TextStyle(
                          fontSize: 23,
                          color: isDarkMode
                              ? const Color.fromARGB(255, 55, 55, 65)
                              : const Color.fromARGB(255, 58, 110, 153),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // زر تسجيل الخروج
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Custombuttonu(
                      siz: Size(150, 70),
                      backg: Colors.white,
                      TextButton: "تسجيل خروج",
                      textStyle: TextStyle(
                        color: isDarkMode
                            ? const Color.fromARGB(255, 55, 55, 65)
                            : const Color.fromARGB(255, 58, 110, 153),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      onpr: () {
                        final auth = AuthUser();
                        final profileController = Get.find<ProfileController>();

                        // حذف الصورة الخاصة بالمستخدم الحالي
                        if (auth.authUser != null) {
                          auth.box.remove('userImage_${auth.authUser!.email}');
                        }

                        // تفريغ الصورة في الواجهة
                        profileController.image.value = null;

                        // تسجيل الخروج
                        auth.logOut();

                        // رسالة نجاح
                        Get.snackbar(
                          "تم تسجيل الخروج",
                          "تم تسجيل الخروج بنجاح ✅",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white70,
                          colorText: Colors.black,
                          duration: const Duration(seconds: 2),
                        );

                        Get.offAll(() => Bottomnavbar());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
