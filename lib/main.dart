import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app1/controller/AuthController.dart';
import 'package:my_app1/controller/GetSto.dart'; // AuthUser
import 'package:my_app1/controller/ThemeController.dart';
import 'package:my_app1/controller/app_search_controller.dart';
import 'package:my_app1/controller/shop_controller.dart';
import 'package:my_app1/models/subcategory_item.dart';
// import 'package:my_app1/controller/ProductController.dart';
import 'package:my_app1/pages/bottomNavBar.dart';
import 'package:my_app1/pages/splash_screen.dart';
import 'package:my_app1/pages/Screens_Login/Login.dart';
import 'package:my_app1/pages/SearchResultsScreen.dart';
import 'package:my_app1/pages/SubServiceScreen.dart';
import 'package:my_app1/pages/products/productSubcategory_screen.dart';
import 'package:my_app1/pages/products/products_screen.dart';
import 'package:my_app1/pages/products/shop_screen.dart';
import 'package:my_app1/pages/servicees_providers/ProviderScreen.dart';

import 'models/services_Item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // تهيئة GetStorage
  AuthUser().inti(); //  تحميل حالة تسجيل الدخول

  Get.put(ThemeController());
  Get.put(AppSearchController());
  // Get.put(ProductController());
  Get.put(AuthController());
  Get.put(ShopController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 58, 110, 153),
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 45, 45, 55),
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        themeMode: themeController.isDark.value
            ? ThemeMode.dark
            : ThemeMode.light,
 
       home: SplashScreen(),
        getPages: [
          GetPage(name: '/', page: () => Bottomnavbar()),
          GetPage(name: '/login', page: () => Login()),
          GetPage(name: '/SplashScreen', page: () => SplashScreen()),
          GetPage(
            name: '/productsScreen',
            page: () => ProductsScreen(
              subcategory: Get.arguments as SubCategoryItem,
            ), // ✅
          ),

          GetPage(
            name: '/subCategoryScreen',
            page: () => SubCategoryScreen(category: Get.arguments),
          ),
          GetPage(name: '/ShopScreen', page: () => ShopScreen()),
          GetPage(
            name: '/providerScreen',
            page: () => ProviderScreen(category: Get.arguments as String),
          ),
          GetPage(
            name: '/subServiceScreen',
            page: () => SubserviceScreen(service: Get.arguments as ServiceItem),
          ),

          GetPage(
            name: '/searchResultsScreen',
            page: () => const SearchResultsScreen(),
          ),
        ],
      ),
    );
  }
}
