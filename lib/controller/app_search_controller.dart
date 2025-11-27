// lib/controller/app_search_controller.dart
import 'package:get/get.dart';

// نموذج للبيانات التي ستبحث عنها
class SearchResultItem {
  final String title;
  final String pageRoute; // اسم الصفحة التي سيتم الانتقال إليها
  final dynamic arguments; // البيانات التي سيتم تمريرها للصفحة

  SearchResultItem({
    required this.title,
    required this.pageRoute,
    this.arguments,
  });
}

class AppSearchController extends GetxController {
  // قائمة بجميع العناصر المتاحة للبحث
  final allSearchableItems = <SearchResultItem>[
    // خدمات رئيسية
    SearchResultItem(
        title: 'الديكور', pageRoute: '/providerScreen', arguments: 'الديكور'),
    SearchResultItem(
        title: 'التنظيف', pageRoute: '/providerScreen', arguments: 'التنظيف'),
    SearchResultItem(
        title: 'كهرباء', pageRoute: '/providerScreen', arguments: 'كهرباء'),
    SearchResultItem(
        title: 'سباكة', pageRoute: '/providerScreen', arguments: 'سباكة'),

    // خدمات فرعية (صيانة الأجهزة)
    SearchResultItem(
        title: 'صيانة الأجهزة',
        pageRoute: '/SubserviceScreen',
        arguments: 'صيانة الأجهزة'),
    SearchResultItem(
        title: 'صيانة التلفزيون',
        pageRoute: '/providerScreen',
        arguments: 'صيانة التلفزيون'),
    SearchResultItem(
        title: 'صيانة الثلاجة',
        pageRoute: '/providerScreen',
        arguments: 'صيانة الثلاجة'),
    SearchResultItem(
        title: 'صيانة الغسالة',
        pageRoute: '/providerScreen',
        arguments: 'الغسالة'),
    SearchResultItem(
        title: 'صيانة الأفران',
        pageRoute: '/providerScreen',
        arguments: 'الأفران'),

    // خدمات أخرى ومحتوياتها
    SearchResultItem(
        title: 'خدمات أخرى',
        pageRoute: '/subServiceScreen',
        arguments: 'خدمات أخرى'),
    SearchResultItem(
        title: 'تنسيق الحدائق',
        pageRoute: '/providerScreen',
        arguments: 'تنسيق الحدائق'),
    SearchResultItem(
        title: 'صيانة الدش',
        pageRoute: '/providerScreen',
        arguments: 'صيانة الدش'),
    SearchResultItem(
        title: 'نقل عفش', pageRoute: '/providerScreen', arguments: 'نقل عفش'),
    SearchResultItem(
        title: 'انظمه الامان',
        pageRoute: '/providerScreen',
        arguments: 'انظمه الامان'),
    SearchResultItem(
        title: 'دهان', pageRoute: '/providerScreen', arguments: 'دهان'),
    SearchResultItem(
        title: 'وايت ماء', pageRoute: '/providerScreen', arguments: 'وايت ماء'),

    // قطع الغيار ومحتوياتها
    SearchResultItem(
        title: 'قطع الغيار', pageRoute: '/ShopScreen', arguments: 'قطع الغيار'),
    SearchResultItem(
        title: 'السباكة',
        pageRoute: '/subCategoryScreen',
        arguments: 'السباكة'),
    SearchResultItem(
        title: 'الأجهزة',
        pageRoute: '/subCategoryScreen',
        arguments: 'الأجهزة'),
    SearchResultItem(
        title: 'الدهانات',
        pageRoute: '/subCategoryScreen',
        arguments: 'الدهانات'),
    SearchResultItem(
        title: 'الكهرباء',
        pageRoute: '/subCategoryScreen',
        arguments: 'الكهرباء'),

    // محتويات السباكة
    SearchResultItem(
        title: 'أنابيب', pageRoute: '/productsScreen', arguments: 'أنابيب'),
    SearchResultItem(
        title: 'حنفيات', pageRoute: '/productsScreen', arguments: 'حنفيات'),
    SearchResultItem(
        title: 'مضخات', pageRoute: '/productsScreen', arguments: 'مضخات'),

    // محتويات الأجهزة
    SearchResultItem(
        title: 'ثلاجات', pageRoute: '/productsScreen', arguments: 'ثلاجات'),
    SearchResultItem(
        title: 'غسالات', pageRoute: '/productsScreen', arguments: 'غسالات'),
    SearchResultItem(
        title: 'مكيفات', pageRoute: '/productsScreen', arguments: 'مكيفات'),
    SearchResultItem(
        title: 'أفران', pageRoute: '/productsScreen', arguments: 'أفران'),

    // محتويات الدهانات
    SearchResultItem(
        title: 'دهانات جدران',
        pageRoute: '/productsScreen',
        arguments: 'دهانات جدران'),
    SearchResultItem(
        title: 'مواد طلاء',
        pageRoute: '/productsScreen',
        arguments: 'مواد طلاء'),
    SearchResultItem(
        title: 'معجون', pageRoute: '/productsScreen', arguments: 'معجون'),

    // محتويات الكهرباء
    SearchResultItem(
        title: 'أسلاك', pageRoute: '/productsScreen', arguments: 'أسلاك'),
    SearchResultItem(
        title: 'مفاتيح', pageRoute: '/productsScreen', arguments: 'مفاتيح'),
    SearchResultItem(
        title: 'لمبات', pageRoute: '/productsScreen', arguments: 'لمبات'),

    // ✅ مزودي الخدمات (تم الإضافة)
    SearchResultItem(
        title: 'محمد علي', pageRoute: '/providerScreen', arguments: 'محمد علي'),
    SearchResultItem(
        title: 'محمد احمد',
        pageRoute: '/providerScreen',
        arguments: 'محمد احمد'),
  ].obs;

  var searchResults = <SearchResultItem>[].obs;
  var searchQuery = ''.obs;

  void filterResults(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    final lowerCaseQuery = query.toLowerCase();
    searchResults.value = allSearchableItems
        .where((item) => item.title.toLowerCase().contains(lowerCaseQuery))
        .toList();
  }

  void navigateToPage(SearchResultItem item) {
    Get.toNamed(item.pageRoute, arguments: item.arguments);
  }
}
