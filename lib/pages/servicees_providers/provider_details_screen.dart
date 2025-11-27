// pages/provider_details_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/provider_item.dart';

class ProviderDetailsScreen extends StatelessWidget {
  const ProviderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProviderItem provider = Get.arguments; //  استلام البيانات

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(provider.name)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(provider.imageUrl),
                  radius: 50,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                provider.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(provider.rating.toString()),
                ],
              ),
              const SizedBox(height: 20),
              Text("📍 العنوان: ${provider.address}"),
              Text("📞 الهاتف: ${provider.phone}"),
              Text("✉️ البريد: ${provider.email}"),
              const SizedBox(height: 20),
              Text(provider.description, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
