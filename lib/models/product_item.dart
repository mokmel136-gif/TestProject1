class ProductItem {
  final int? id;
  final String name;
  final String image;
  final double price;
  final String? description;
  final int? categoryId;
  final int? stockQuantity;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  ProductItem({
    this.id,
    required this.name,
    required this.image,
    required this.price,
    this.description,
    this.categoryId,
    this.stockQuantity,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      name: json['name'],
      image: json['image'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0, //  هنا التعديل
      description: json['description'],
      categoryId: json['category_id'],
      stockQuantity: json['stock_quantity'],
      isActive: json['  is_active'] == true || json['is_active'] == 1,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
