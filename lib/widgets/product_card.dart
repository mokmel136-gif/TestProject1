// lib/widgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/shop_controller.dart';
import '../models/product_item.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.find();

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(image, fit: BoxFit.contain),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // سعر المنتج مع أيقونة السلة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${price.toStringAsFixed(2)} USD",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // أيقونة السلة
                  IconButton(
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      size: 20,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      shopController.addToCart(ProductItem(
                        name: name,
                        image: image,
                        price: price,
                      ));
                      Get.snackbar(
                        "تم الإضافة",
                        "$name أضيف إلى السلة ✅",
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green[100],
                        colorText: Colors.black,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
