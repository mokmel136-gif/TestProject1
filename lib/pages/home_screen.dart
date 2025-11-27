import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_app1/pages/servicees_providers/ProviderScreen.dart';
import 'package:my_app1/utils/icons_map.dart';
import 'package:my_app1/widgets/SearchBarWidget.dart';

import '../models/services_Item.dart';
import '../services_ِapi/api_service.dart';

import '../widgets/services_gridView.dart';
import 'SubServiceScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("مهنة")),

      body: Column(
        children: [
          SearchBarWidget(),
          Expanded(
            child: FutureBuilder<List<ServiceItem>>(
              future: apiService.getServices(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("لا توجد خدمات"));
                }

                final services = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Builder(
                    builder: (context) {
                      // Debugging
                      // print("Services from API: ${services.length}");

                      // for (var s in services) {
                      //   // print(
                      //   //   "Service: ${s.title}, sub: ${s.subCategories.length}",
                      //   // );
                      // }

                      return ServicesGridView(
                        items: services
                            .map(
                              (s) => {
                                'title': s.title,
                                'icon': IconsMap[s.icon] ?? Icons.help,
                              },
                            )
                            .toList(),
                        onTap: (index) {
                          final service = services[index];
                          if (service.subCategories.isNotEmpty) {
                            Get.to(() => SubserviceScreen(service: service));
                          } else {
                            Get.to(
                              () => ProviderScreen(category: service.title),
                            );
                          }
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
