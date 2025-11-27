import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app1/pages/products/productSubcategory_screen.dart';

import '../../services_ِapi/api_service.dart';
import '../../widgets/SearchBarWidget.dart';
import '../../widgets/productCategory_card.dart';
import '../../models/category_item.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الأدوات وقطع الغيار")),
      body: Column(
        children: [
          const SearchBarWidget(),
          Expanded(
            child: FutureBuilder<List<CategoryItem>>(
              future: apiService.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('لا توجد فئات'));
                }

                final categories = snapshot.data!;

                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return ProductCategoryCard(
                      title: category.name,
                      icon: category.icon, // لازم يكون نص جاي من API
                      onTap: () {
                        Get.to(() => SubCategoryScreen(category: category));
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
