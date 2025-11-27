import 'package:get/get.dart';
import '../models/subcategory_item.dart';
import '../services_ِapi/api_service.dart';

class SubCategoryController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var subcategories = <SubCategoryItem>[].obs;

  Future<void> loadSubCategories(int categoryId) async {
    try {
      isLoading.value = true;
      subcategories.value = await _apiService.getSubCategories(categoryId);
    } catch (e) {
      subcategories.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
