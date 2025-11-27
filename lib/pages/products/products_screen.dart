import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app1/models/subcategory_item.dart';

import '../../controller/shop_controller.dart';
import '../../widgets/product_card.dart';
import '../CartScreen.dart';

class ProductsScreen extends StatelessWidget {
  final SubCategoryItem subcategory; //  استبدل String بـ SubCategoryItem

  ProductsScreen({super.key, required this.subcategory});

  final ShopController shopController = Get.find();

  @override
  Widget build(BuildContext context) {
    // تحميل المنتجات لهذه الفئة الفرعية بعد فتح الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ////دالة تنفيذ شفرة بعد انتهاء بناء الواجهة (after the frame is built).

      shopController.loadProductsByCategory(subcategory.categoryId);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(subcategory.name), //  اسم الفئة الفرعية
        actions: [
          // أيقونة السلة مع عداد
          Obx(
            () => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Get.to(() => const CartScreen());
                  },
                ),
                if (shopController.cartItemsCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${shopController.cartItemsCount}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (shopController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (shopController.products.isEmpty) {
          print("SubCategory ID: ${subcategory.id}");

          return const Center(child: Text("لا توجد منتجات هنا"));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: shopController.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final product = shopController.products[index];
          return ProductCard(
              name: product.name,
              image: product.image,
              price: product.price,
              onTap: () {
                // إضافة المنتج إلى السلة
                shopController.addToCart(product);
                Get.snackbar(
                  "تم الإضافة",
                  "${product.name} أضيف إلى السلة ✅",
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.green[100],
                  colorText: Colors.black,
                );
              },
            );
          },
        );
      }),
    );
  }
}
