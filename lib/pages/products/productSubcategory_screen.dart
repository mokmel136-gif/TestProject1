import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app1/controller/SubCategoryController.dart';
import 'package:my_app1/models/category_item.dart';
import '../../widgets/ProductSubcategory_card.dart';
import '../../widgets/SearchBarWidget.dart';
import '../CartScreen.dart';
import 'products_screen.dart';

class SubCategoryScreen extends StatelessWidget {
  final CategoryItem category;

  SubCategoryScreen({super.key, required this.category});

  final SubCategoryController subCategoryController =
      Get.put(SubCategoryController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      subCategoryController.loadSubCategories(category.id); // 
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => const CartScreen());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SearchBarWidget(),
          Expanded(
            child: Obx(() {
              if (subCategoryController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (subCategoryController.subcategories.isEmpty) {
                return const Center(child: Text("لا توجد فئات فرعية"));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: subCategoryController.subcategories.length,
                itemBuilder: (context, index) {
                  final sub = subCategoryController.subcategories[index];
                  return ProductSubcategoryCard(
                    title: sub.name,
                    onTap: () {
                      Get.to(() => ProductsScreen(subcategory: sub));
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
