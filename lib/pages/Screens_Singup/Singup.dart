import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app1/controller/AuthController.dart';
import 'package:my_app1/widgets/CustomElevatedbuttonu.dart';
import 'package:my_app1/widgets/CustomTextForm.dart';
import 'package:my_app1/widgets/CustomTextbuttonu.dart';
import 'package:my_app1/controller/ThemeController.dart';

import '../Screens_Login/Login.dart';

class Singup extends StatelessWidget {
  Singup({super.key});

  final AuthController authController = Get.find<AuthController>();
  final TextEditingController cEmaill = TextEditingController();
  final TextEditingController cPassword = TextEditingController();
  final TextEditingController cName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(() {
      final isDarkMode = themeController.isDark.value;
      return Scaffold(
        backgroundColor: isDarkMode
            ? const Color.fromARGB(255, 55, 55, 65)
            : const Color.fromARGB(255, 58, 110, 153),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 111),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isDarkMode
                          ? const Color.fromARGB(255, 55, 55, 65)
                          : const Color.fromARGB(180, 154, 154, 154),
                    ),
                  ),
                  Container(
                    height: 500,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    margin: EdgeInsets.symmetric(vertical: 140, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isDarkMode
                          ? const Color.fromARGB(255, 55, 55, 65)
                          : const Color.fromARGB(255, 226, 226, 233),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          offset: Offset(0, 10),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'انشاء حساب',
                            style: TextStyle(
                              color: Color.fromARGB(255, 58, 110, 153),
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 40),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextForm(
                                  conText: cName,
                                  Validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'يرجى إدخال الاسم';
                                    }
                                    if (value.length < 3) {
                                      return 'يجب أن يكون الاسم مكونًا من ثلاث احرف على الاقل';
                                    }
                                    if (value
                                        .split(' ')
                                        .any((sp) => sp.isEmpty)) {
                                      return 'لا يسمح بعدد من المسافات';
                                    }
                                    if (!RegExp(
                                      r'^[\u0600-\u06FFa-zA-Z\s]+$',
                                    ).hasMatch(value)) {
                                      return 'يرجى إدخال أحرف فقط (عربية أو إنجليزية) بدون أرقام أو رموز';
                                    }
                                    if (RegExp(r'[0-9٠-٩]').hasMatch(value)) {
                                      return 'غير مسموح بالأرقام العربية أو الإنجليزية';
                                    }
                                    if (RegExp(
                                      r'[.,،\-_!@#$%^&*()]',
                                    ).hasMatch(value)) {
                                      return 'غير مسموح بالفواصل أو الرموز الخاصة';
                                    }
                                    return null;
                                  },
                                  labText: ' الاسم',
                                  labelColor: Color.fromARGB(255, 58, 110, 153),
                                  ic: Icon(
                                    Icons.account_circle,
                                    color: Color.fromARGB(255, 58, 110, 153),
                                    size: 25,
                                  ),
                                ),
                                SizedBox(height: 30),
                                CustomTextForm(
                                  conText: cEmaill,
                                  Validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'الرجاء إدخال البريد الإلكتروني';
                                    }
                                    final RgEx = RegExp(
                                      r'^[\w\.]+@([\w-]+\.)+[\w-]{2,3}$',
                                    );
                                    if (!RgEx.hasMatch(value)) {
                                      return 'الرجاء إدخال بريد إلكتروني بشكل صحيح';
                                    }
                                    return null;
                                  },
                                  labText: ' البريد الإلكتروني',
                                  labelColor: Color.fromARGB(255, 58, 110, 153),
                                  ic: Icon(
                                    Icons.email,
                                    color: Color.fromARGB(255, 58, 110, 153),
                                    size: 25,
                                  ),
                                ),
                                SizedBox(height: 30),
                                CustomTextForm(
                                  obscureText: true,
                                  conText: cPassword,
                                  Validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'الرجاء إدخال كلمة المرور';
                                    }
                                    if (value.length < 8) {
                                      return 'يجب أن تكون كلمة المرور اكثر من 8';
                                    }
                                    return null;
                                  },
                                  labText: ' كلمة المرور',
                                  labelColor: Color.fromARGB(255, 58, 110, 153),
                                  ic: Icon(
                                    Icons.lock,
                                    color: Color.fromARGB(255, 58, 110, 153),
                                    size: 25,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Obx(
                                  () => authController.isLoading.value
                                      ? CircularProgressIndicator()
                                      : Custombuttonu(
                                          siz: Size(260, 70),
                                          backg: Color.fromARGB(
                                            255,
                                            58,
                                            110,
                                            153,
                                          ),
                                          TextButton: " انشاء حساب",
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                          onpr: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              authController.register(
                                                name: cName.text,
                                                email: cEmaill.text,
                                                password: cPassword.text,
                                              );
                                            }
                                          },
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              CustomTextbuttonu(
                TextBu: "هل لديك حساب؟ تسجيل الدخول",
                onprtext: () {
                  Get.to(() => Login());
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
