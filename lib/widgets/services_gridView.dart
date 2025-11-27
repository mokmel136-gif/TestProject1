import 'package:flutter/material.dart';
import 'package:my_app1/widgets/services_card.dart';

class ServicesGridView extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final void Function(int index) onTap;

  const ServicesGridView({super.key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return ServicesCard(
          title: item['title'] as String,
          icon: item['icon']
              as IconData, // هذا سيعمل الآن لأننا نمرر IconData وليس ServiceItem
          onTap: () => onTap(index),
        );
      },
    );
  }
}
