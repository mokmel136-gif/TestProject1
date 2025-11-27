class SubServiceItem {
  final int id;
  final String title;
  final String icon;

  SubServiceItem({
    required this.id,
    required this.title,
    required this.icon,
  });

  factory SubServiceItem.fromJson(Map<String, dynamic> json) {
    return SubServiceItem(
      id: json['id'],
      title: json['name'],
      icon: json['icon'],
    );
  }
}

class ServiceItem {
  final int id;
  final String title;
  final String icon;
  final List<SubServiceItem> subCategories;

  ServiceItem({
    required this.id,
    required this.title,
    required this.icon,
    this.subCategories = const [],
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      id: json['id'],
      title: json['name'],
      icon: json['icon'],
      subCategories: (json['sub_categories'] as List<dynamic>? ?? [])
          .map((sub) => SubServiceItem.fromJson(sub))
          .toList(),
    );
  }
}
