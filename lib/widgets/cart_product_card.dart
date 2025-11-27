// lib/widgets/cart_product_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/shop_controller.dart';
import '../models/ModleCart.dart';


class CartProductCard extends StatelessWidget {
  final CartItem item;
  final ShopController shopController = Get.find();

  CartProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // صورة المنتج
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(item.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // معلومات المنتج
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.price.toStringAsFixed(2)} USD',
                    style: const TextStyle(color: Colors.green),
                  ),
                  Text(
                    'المجموع: ${item.totalPrice.toStringAsFixed(2)} USD',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // التحكم بالكمية
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => shopController.decreaseQuantity(item),
                ),
                Text('${item.quantity}', style: const TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => shopController.increaseQuantity(item),
                ),
              ],
            ),
            // زر الحذف
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => shopController.removeFromCart(item),
            ),
          ],
        ),
      ),
    );
  }
}
