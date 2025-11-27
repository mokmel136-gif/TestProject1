// lib/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app1/controller/GetSto.dart';
import 'package:my_app1/pages/Screens_Login/Login.dart';

import '../controller/shop_controller.dart';
import '../widgets/cart_product_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("السلة"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => shopController.clearCart(),
            tooltip: 'تفريغ السلة',
          ),
        ],
      ),
      body: Obx(() {
        if (shopController.cartItems.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'السلة فارغة',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: shopController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = shopController.cartItems[index];
                  return CartProductCard(item: item);
                },
              ),
            ),
            // إجمالي السلة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: const Border(top: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'الإجمالي:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${shopController.cartTotal.toStringAsFixed(2)} USD',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            // زر الدفع
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  final auth = AuthUser();
                  if (auth.isLogin.value) {
                    // ✅ هنا تنفذ عملية الشراء
                    Get.snackbar('تم الطلب', 'سيتم تجهيز طلبك قريباً');
                  } else {
                    // ❌ غير مسجل دخول → يوديه على صفحة تسجيل الدخول
                    Get.to(() => Login());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('إتمام الشراء', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
