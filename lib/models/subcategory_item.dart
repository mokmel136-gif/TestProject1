class SubCategoryItem {
  final int id;
  final String name;
  final int categoryId; //  أضف هذا
  final String? icon;

  SubCategoryItem({
    required this.id,
    required this.name,
    required this.categoryId, // 
    this.icon,
  });

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) {
    return SubCategoryItem(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'], //  اربطها هنا
      icon: json['icon'],
    );
  }
}
