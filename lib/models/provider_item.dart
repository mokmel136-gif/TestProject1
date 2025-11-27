class ProviderItem {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String description;
  final String imageUrl;
  final double rating;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  ProviderItem({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProviderItem.fromJson(Map<String, dynamic> json) {
    return ProviderItem(
      id: json["id"],
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
      description: json["description"] ?? "",
      imageUrl: json["image_url"],
      rating: double.parse(json["rating"].toString()),
      isActive: json["is_active"] ?? true,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "description": description,
      "image_url": imageUrl,
      "rating": rating,
      "is_active": isActive,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}

