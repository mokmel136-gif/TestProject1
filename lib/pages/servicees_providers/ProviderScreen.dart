import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app1/pages/servicees_providers/provider_details_screen.dart';

import '../../controller/provider_controller.dart';
import '../../widgets/ProviderCard.dart';
import '../../widgets/SearchBarWidget.dart';

class ProviderScreen extends StatelessWidget {
  final String category;
  ProviderScreen({super.key, required this.category});

  final ProviderController providerController = Get.put(ProviderController());

  @override
  Widget build(BuildContext context) {
    // تحميل المزودين بعد اكتمال البناء
    WidgetsBinding.instance.addPostFrameCallback((_) {
      providerController.loadProviders(category);
    });

    return Scaffold(
      appBar: AppBar(title: Text("مزودي خدمة $category"), centerTitle: true),
      body: Column(
        children: [
          const SearchBarWidget(),
          Expanded(
            child: Obx(
              () {
                if (providerController.providers.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: providerController.providers.length,
                  itemBuilder: (context, index) {
                    final provider = providerController.providers[index];
                    return ProviderCard(
                      provider: provider,
                      onTap: () {
                        Get.to(
                          () => const ProviderDetailsScreen(),
                          arguments: provider,
                        );
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
