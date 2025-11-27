import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:my_app1/models/category_item.dart';
import 'package:my_app1/models/product_item.dart';
import 'package:my_app1/models/subcategory_item.dart';
import '../models/services_Item.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.234.8:8000/api';
  final GetStorage _storage = GetStorage();

  //  جلب التوكن
  Future<String?> getToken() async {
    return _storage.read("auth_token");
  }

  //  حفظ التوكن
  Future<void> saveToken(String token) async {
    await _storage.write("auth_token", token);
  }

  //  حذف التوكن
  Future<void> removeToken() async {
    await _storage.remove("auth_token");
  }

  //  الهيدر مع أو بدون توكن
  Future<Map<String, String>> getHeaders({bool includeAuth = false}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (includeAuth) {
      final token = await getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  //  التسجيل
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    ////تعمل  بشكل غير متزامن
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: await getHeaders(),
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);
    // 201 (تم الإنشاء)
    if (response.statusCode == 201 && data['success']) {
      await saveToken(data['data']['token']);
    }

    return data;
  }

  //  تسجيل الدخول
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: await getHeaders(),
      // (Objects) إلى نص JSON.
      body: jsonEncode({'email': email, 'password': password}),
    );
    // العكس
    final data = jsonDecode(response.body);
    // 200 (نجاح)
    if (response.statusCode == 200 && data['success']) {
      await saveToken(data['data']['token']);
    }

    return data;
  }

  //  تسجيل الخروج
  Future<Map<String, dynamic>> logout() async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: await getHeaders(includeAuth: true),
    );

    if (response.statusCode == 200) {
      await removeToken();
    }

    return jsonDecode(response.body);
  }

  //  جلب بيانات المستخدم
  Future<Map<String, dynamic>> getUser() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user'),

      headers: await getHeaders(includeAuth: true),
    );
    // print("Raw response: ${response.body}");

    return jsonDecode(response.body);
  }

//  جلب قائمة الخدمات من api

  Future<List<ServiceItem>> getServices() async {
    final response = await http.get(Uri.parse('$baseUrl/services'));
    // print("Raw response: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success']) {
        return (data['data'] as List)
            .map((s) => ServiceItem.fromJson(s))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception("فشل في جلب الخدمات");
    }
  }

  ///////////////////////////////////////////

  // جلب التصنيفات
  Future<List<CategoryItem>> getCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories'),
      headers: await getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is List) {
        return data.map((e) => CategoryItem.fromJson(e)).toList();
      }

      if (data is Map && data['data'] != null) {
        return (data['data'] as List)
            .map((e) => CategoryItem.fromJson(e))
            .toList();
      }
    }

    return [];
  }

  Future<List<SubCategoryItem>> getSubCategories(int categoryId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories/$categoryId/subcategories'),
      headers: await getHeaders(),
    );

    // print("SubCategories Response: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success']) {
        return (data['data'] as List)
            .map((item) => SubCategoryItem.fromJson(item))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception("فشل في جلب الفئات الفرعية");
    }
  }

  //  جلب المنتجات حسب الفئة الفرعية
  Future<List<ProductItem>> getProductsByCategory(int categoryId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/category/$categoryId'),
      headers: await getHeaders(),
    );

    // print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success']) {
        return (data['data'] as List)
            .map((item) => ProductItem.fromJson(item))
            .toList();
      }
    }
    throw Exception("فشل في الاتصال بالسيرفر: ${response.statusCode}");
  }

  // //////////////////////////////////////////////////////
  //  جلب السلة للمستخدم
  // Future<List<CartItem>> getCart(String token) async {
  //   final response = await http.get(
  //     Uri.parse("$baseUrl/cart"),
  //     headers: {"Authorization": "Bearer $token"},
  //   );

  //   if (response.statusCode == 200) {
  //     final List data = json.decode(response.body);
  //     return data.map((e) => CartItem.fromJson(e)).toList();
  //   } else {
  //     throw Exception("فشل في جلب السلة");
  //   }
  // }

  //   //  إضافة منتج إلى السلة
  //  Future<void> addToCartRemote(int productId, int quantity, double price) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/carts'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ', // لو عندك توكن
  //     },
  //     body: jsonEncode({
  //       'product_id': productId,
  //       'quantity': quantity,
  //       'price': price,
  //     }),
  //   );

  //   if (response.statusCode != 200 && response.statusCode != 201) {
  //     throw Exception('فشل في إضافة المنتج للسلة');
  //   }
  // }
}
