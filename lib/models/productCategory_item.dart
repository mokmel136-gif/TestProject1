import 'package:flutter/material.dart';

class ProductCategoryItem {
  final int? id;
  final String name;
  final IconData icon;
  final List<String> subcategories;

  ProductCategoryItem({
    this.id,
    required this.name,
    required this.icon,
    required this.subcategories,
  });

  // من JSON إلى Object
  factory ProductCategoryItem.fromJson(Map<String, dynamic> json) {
    return ProductCategoryItem(
      id: json['id'],
      name: json['name'],
      icon: _mapIconFromString(json['icon']),
      subcategories: List<String>.from(json['subcategories'] ?? []),
    );
  }

  // من Object إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': _iconToString(icon),
      'subcategories': subcategories,
    };
  }

  static IconData _mapIconFromString(String iconName) {
    switch (iconName) {
      case 'devices':
        return Icons.devices;
      case 'plumbing':
        return Icons.plumbing;
      case 'electrical_services':
        return Icons.electrical_services;
      case 'format_paint':
        return Icons.format_paint;
      default:
        return Icons.category;
    }
  }

  static String _iconToString(IconData icon) {
    if (icon == Icons.devices) return 'devices';
    if (icon == Icons.plumbing) return 'plumbing';
    if (icon == Icons.electrical_services) return 'electrical_services';
    if (icon == Icons.format_paint) return 'format_paint';
    return 'category';
  }
}
