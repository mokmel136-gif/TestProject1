class CategoryItem {
  final int id;
  final String name;
  final String icon;

  CategoryItem({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? 'category',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }
}