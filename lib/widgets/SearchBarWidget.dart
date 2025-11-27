import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/app_search_controller.dart';
import '../pages/SearchResultsScreen.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSearchController searchController =
        Get.find<AppSearchController>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          // مربع البحث
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Obx(() {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    searchController.searchQuery.value = value;
                    searchController.filterResults(value);
                  },
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      Get.to(() => const SearchResultsScreen());
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "ابحث عن خدمة أو منتج...",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                    ),
                    suffixIcon: searchController.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              searchController.searchQuery.value = '';
                              searchController.searchResults.clear();
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),
                  ),
                ),
              );
            }),
          ),

          // قائمة منسدلة بالنتائج (Auto-complete) مع ارتفاع محدود
          Obx(() {
            if (searchController.searchResults.isEmpty ||
                searchController.searchQuery.isEmpty) {
              return const SizedBox.shrink();
            }

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              constraints: const BoxConstraints(
                maxHeight: 250, // أقصى ارتفاع للقائمة
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: searchController.searchResults.length,
                itemBuilder: (context, index) {
                  final item = searchController.searchResults[index];
                  return ListTile(
                    leading: const Icon(Icons.arrow_forward_ios, size: 18),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      searchController.navigateToPage(item);
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
