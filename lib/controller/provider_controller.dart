// controller/provider_controller.dart
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/provider_item.dart';

class ProviderController extends GetxController {
  var providers = <ProviderItem>[].obs;

  void loadProviders(String category) {
    providers.value = [
      ProviderItem(
          id: 1,
          name: "محمد احمد",
          imageUrl: "https://example.com/image1.jpg",
          rating: 4.5,
          description: 'test1',
          phone: '776613956',
          email: 'test2@gmail.com',
          address: 'صنعاء',
          isActive: true,
          createdAt: '2025-01-01T00:00:00Z',
          updatedAt: '2025-01-01T00:00:00Z'),
      ProviderItem(
          id: 2,
          name: "محمد علي",
          imageUrl: "https://example.com/image2.jpg",
          rating: 3.5,
          description: 'test2',
          phone: '37374777',
          email: 'test2@gmail.com',
          address: 'تعز',
          isActive: true,
          createdAt: '2025-01-01T00:00:00Z',
          updatedAt: '2025-01-01T00:00:00Z'),
    ];
  }
}
