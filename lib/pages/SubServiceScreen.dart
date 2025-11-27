import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app1/models/services_Item.dart';
import 'package:my_app1/pages/servicees_providers/ProviderScreen.dart';
import 'package:my_app1/utils/icons_map.dart';
import '../widgets/services_gridView.dart';

class SubserviceScreen extends StatelessWidget {
 final ServiceItem service;

const SubserviceScreen({super.key, required this.service});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service.title)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ServicesGridView(
          items: service.subCategories
              .map(
                (sub) => {
                  "title": sub.title,
                  "icon": IconsMap[sub.icon] ?? Icons.help,
                },
              )
              .toList(),
          onTap: (index) {
            final sub = service.subCategories[index];
            Get.to(() => ProviderScreen(category: sub.title));
          },
        ),
      ),
    );
  }
}
