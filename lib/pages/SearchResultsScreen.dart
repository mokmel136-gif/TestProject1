import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/app_search_controller.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSearchController searchController =
        Get.find<AppSearchController>();

    return Scaffold(
      appBar: AppBar(title: const Text("نتائج البحث")),
      body: Obx(() {
        if (searchController.searchResults.isEmpty) {
          return const Center(child: Text("لا توجد نتائج مطابقة"));
        }

        return SingleChildScrollView(
          child: ListView.separated(
            itemCount: searchController.searchResults.length,
            separatorBuilder: (_, __) => Divider(color: Colors.grey[300]),
            itemBuilder: (context, index) {
              final item = searchController.searchResults[index];
              return ListTile(
                leading: const Icon(Icons.search, color: Colors.blueAccent),
                title: Text(item.title),
                onTap: () => searchController.navigateToPage(item),
              );
            },
          ),
        );
      }),
    );
  }
}
