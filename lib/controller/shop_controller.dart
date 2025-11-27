import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app1/models/ModleCart.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:my_app1/models/cart_item.dart';
import 'package:my_app1/models/productCategory_item.dart';
import 'package:my_app1/models/product_item.dart';
import 'package:my_app1/services_%D9%90api/api_service.dart';

class ShopController extends GetxController {
  final ApiService _apiService = ApiService();

  var products = <ProductItem>[].obs;
  var categories = <ProductCategoryItem>[].obs;
  var cartItems = <CartItem>[].obs;
  var isLoading = false.obs;
  final box = GetStorage();
  static const cartKey = 'cartItems';

  double get cartTotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  int get cartItemsCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  @override
  void onInit() {
    super.onInit();
    
    loadCategories();
    loadCart();
  }

  String? token; // خزّن التوكن هنا بعد تسجيل الدخول

  //  جلب المنتجات
  Future<void> loadProductsByCategory(int categoryId) async {
    try {
      isLoading.value = true;
      final result = await _apiService.getProductsByCategory(categoryId);
      // print("Products loaded: ${result.length}");
      products.value = result;
    } catch (e) {
      products.clear();
      // print("Error while loading products: $e");
      Get.snackbar("خطأ", "فشل في جلب المنتجات: $e");
    } finally {
      isLoading.value = false;
    }
  }













































  void loadCategories() {
    categories.value = [
      ProductCategoryItem(
        name: "الأجهزة",
        icon: Icons.devices,
        subcategories: ["ثلاجات", "غسالات", "مكيفات", "أفران"],
      ),
      ProductCategoryItem(
        name: "السباكة",
        icon: Icons.plumbing,
        subcategories: ["أنابيب", "حنفيات", "مضخات"],
      ),
      ProductCategoryItem(
        name: "الكهرباء",
        icon: Icons.electrical_services,
        subcategories: ["أسلاك", "مفاتيح", "لمبات"],
      ),
      ProductCategoryItem(
        name: "الدهانات",
        icon: Icons.format_paint,
        subcategories: ["دهانات جدران", "مواد طلاء", "معجون"],
      ),
    ];
  }


  // دالة تحميل المنتجات حسب التصنيف الفرعي - يجب أن تكون داخل الكلاس
  void loadProducts(String subcategory) {
    // مسح المنتجات الحالية
    products.clear();

    // تحميل المنتجات بناءً على التصنيف الفرعي
    if (subcategory == "ثلاجات") {
      products.value = [
        ProductItem(
          name: "ثلاجة سامسونج 20 قدم",
          image:
              "https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?w=400",
          price: 2500.0,
        ),
        ProductItem(
          name: "ثلاجة LG 18 قدم",
          image:
              "https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=400",
          price: 2200.0,
        ),
        ProductItem(
          name: "ثلاجة هاير 16 قدم",
          image:
              "https://images.unsplash.com/photo-1584560176443-4c9e4d0d709c?w=400",
          price: 1800.0,
        ),
      ];
    } else if (subcategory == "غسالات") {
      products.value = [
        ProductItem(
          name: "غسالة سامسونج 10 كجم",
          image:
              "https://images.unsplash.com/photo-1626806787461-102c1bfaaea1?w=400",
          price: 1800.0,
        ),
        ProductItem(
          name: "غسالة LG 8 كجم",
          image:
              "https://images.unsplash.com/photo-1633380114351-3f2be2e4f28e?w=400",
          price: 1500.0,
        ),
      ];
    } else if (subcategory == "مكيفات") {
      products.value = [
        ProductItem(
          name: "مكيف سبليت 1.5 طن",
          image:
              "https://images.unsplash.com/photo-1613487429287-4c57e0c4de62?w=400",
          price: 1200.0,
        ),
        ProductItem(
          name: "مكيف شباك 1 طن",
          image:
              "https://images.unsplash.com/photo-1560472355-536de3962603?w=400",
          price: 800.0,
        ),
      ];
    } else if (subcategory == "أفران") {
      products.value = [
        ProductItem(
          name: "فرن غاز 5 عيون",
          image:
              "https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400",
          price: 900.0,
        ),
        ProductItem(
          name: "فرن كهربائي",
          image:
              "https://images.unsplash.com/photo-1570222094114-d054a817e56b?w=400",
          price: 600.0,
        ),
      ];
    } else if (subcategory == "أنابيب") {
      products.value = [
        ProductItem(
          name: "أنابيب PVC 4 بوصة",
          image:
              "https://images.unsplash.com/photo-1583301285970-5c4ba1b59e48?w=400",
          price: 50.0,
        ),
        ProductItem(
          name: "أنابيب نحاس 2 بوصة",
          image:
              "https://images.unsplash.com/photo-1594736797933-d0401ba94693?w=400",
          price: 120.0,
        ),
      ];
    } else if (subcategory == "حنفيات") {
      products.value = [
        ProductItem(
          name: "حنفية مطبخ حديثة",
          image:
              "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=400",
          price: 200.0,
        ),
        ProductItem(
          name: "حنفية حمام فاخرة",
          image:
              "https://images.unsplash.com/photo-1631214528234-3c6c366df6e8?w=400",
          price: 350.0,
        ),
      ];
    } else if (subcategory == "أسلاك") {
      products.value = [
        ProductItem(
          name: "سلك كهربائي 2.5 ملم",
          image:
              "https://images.unsplash.com/photo-1588794925171-5c4c45d44c33?w=400",
          price: 30.0,
        ),
        ProductItem(
          name: "سلك أرضي 4 ملم",
          image:
              "https://images.unsplash.com/photo-1603732551681-2e91159b9dc2?w=400",
          price: 45.0,
        ),
      ];
    } else if (subcategory == "لمبات") {
      products.value = [
        ProductItem(
          name: "لمبة LED 20 وات",
          image:
              "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
          price: 25.0,
        ),
        ProductItem(
          name: "لمبة فلورسنت 40 وات",
          image:
              "https://images.unsplash.com/photo-1560472355-536de3962603?w=400",
          price: 15.0,
        ),
      ];
    } else if (subcategory == "دهانات جدران") {
      products.value = [
        ProductItem(
          name: "دهان لامع أبيض",
          image:
              "https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400",
          price: 80.0,
        ),
        ProductItem(
          name: "دهان مطفأ أزرق",
          image:
              "https://images.unsplash.com/photo-1560448204-603b3fc33ddc?w=400",
          price: 85.0,
        ),
      ];
    } else {
      // منتجات افتراضية لأي تصنيف آخر
      products.value = [
        ProductItem(
          name: "منتج $subcategory",
          image:
              "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400",
          price: 100.0,
        ),
      ];
    }
  }

  void addToCart(ProductItem product) {
    final existingItemIndex = cartItems.indexWhere(
      (item) => item.name == product.name,
    );

    if (existingItemIndex >= 0) {
      cartItems[existingItemIndex] = CartItem(
        name: cartItems[existingItemIndex].name,
        image: cartItems[existingItemIndex].image,
        price: cartItems[existingItemIndex].price,
        quantity: cartItems[existingItemIndex].quantity + 1,
      );
    } else {
      cartItems.add(
        CartItem(
          name: product.name,
          image: product.image,
          price: product.price,
          quantity: 1,
        ),
      );
    }
    saveCart(); // ✅ حفظ السلة بعد أي تغيير
    Get.snackbar('تمت الإضافة', 'تم إضافة ${product.name} إلى السلة');
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
  }

  void increaseQuantity(CartItem item) {
    final index = cartItems.indexWhere(
      (cartItem) => cartItem.name == item.name,
    );
    if (index >= 0) {
      cartItems[index] = CartItem(
        name: item.name,
        image: item.image,
        price: item.price,
        quantity: item.quantity + 1,
      );
      saveCart();
    }
  }

  void decreaseQuantity(CartItem item) {
    final index = cartItems.indexWhere(
      (cartItem) => cartItem.name == item.name,
    );
    if (index >= 0) {
      if (item.quantity > 1) {
        cartItems[index] = CartItem(
          name: item.name,
          image: item.image,
          price: item.price,
          quantity: item.quantity - 1,
        );
      } else {
        cartItems.removeAt(index);
      }
      saveCart();
    }
  }

  void clearCart() {
    cartItems.clear();
    saveCart();
  }

  // حفظ السلة في GetStorage
  void saveCart() {
    final List<Map<String, dynamic>> cartData = cartItems
        .map((item) => item.toJson())
        .toList();
    box.write(cartKey, cartData);
  }

  // تحميل السلة من GetStorage
  void loadCart() {
    final data = box.read(cartKey);
    if (data != null) {
      final List<CartItem> loaded = List<Map<String, dynamic>>.from(
        data,
      ).map((e) => CartItem.fromJson(e)).toList();
      cartItems.assignAll(loaded);
    }
  }

  // void addToCart(ProductItem product) async {
  //   try {

  //     await _apiService.addToCartRemote(product.id ?? 0, 1, product.price);

  //     final existingItemIndex = cartItems.indexWhere(
  //       (item) => item.productId == product.id,
  //     );

  //     if (existingItemIndex >= 0) {
  //       cartItems[existingItemIndex] = cartItems[existingItemIndex].copyWith(
  //         quantity: cartItems[existingItemIndex].quantity + 1,
  //       );
  //     } else {
  //       cartItems.add(
  //         CartItem(
  //           productId: product.id ?? 0,
  //           name: product.name,
  //           image: product.image,
  //           price: product.price,
  //           quantity: 1,
  //         ),
  //       );
  //     }

  //     saveCart(); // تخزين محلي
  //     Get.snackbar('تمت الإضافة', 'تم إضافة ${product.name} إلى السلة');
  //   } catch (e) {
  //     Get.snackbar('خطأ', 'فشل في إضافة المنتج: $e');
  //   }
  // }

  //   void removeFromCart(CartItem item) {
  //     cartItems.remove(item);
  //   }

  //   void increaseQuantity(CartItem item) {
  //     final index = cartItems.indexWhere(
  //       (cartItem) => cartItem.name == item.name,
  //     );
  //     if (index >= 0) {
  //       cartItems[index] = CartItem(
  //         id: item.id,
  //         userId: item.userId,
  //         productId: item.productId, //
  //         name: item.name,
  //         image: item.image,
  //         price: item.price,
  //         quantity: item.quantity + 1,
  //         createdAt: item.createdAt,
  //         updatedAt: item.updatedAt,
  //       );
  //       saveCart();
  //     }
  //   }

  //   void decreaseQuantity(CartItem item) {
  //     final index = cartItems.indexWhere(
  //       (cartItem) => cartItem.name == item.name,
  //     );
  //     if (item.quantity > 1) {
  //       cartItems[index] = CartItem(
  //         id: item.id,
  //         userId: item.userId,
  //         productId: item.productId, //
  //         name: item.name,
  //         image: item.image,
  //         price: item.price,
  //         quantity: item.quantity - 1,
  //         createdAt: item.createdAt,
  //         updatedAt: item.updatedAt,
  //       );
  //     } else {
  //       cartItems.removeAt(index);
  //     }
  //     saveCart();
  //   }

  //   void clearCart() {
  //     cartItems.clear();
  //     saveCart();
  //   }

  //   // حفظ السلة في GetStorage
  //   void saveCart() {
  //     final List<Map<String, dynamic>> cartData = cartItems
  //         .map((item) => item.toJson())
  //         .toList();
  //     box.write(cartKey, cartData);
  //   }

  //   // تحميل السلة من GetStorage
  //   void loadCart() {
  //     final data = box.read(cartKey);
  //     if (data != null) {
  //       final List<CartItem> loaded = List<Map<String, dynamic>>.from(
  //         data,
  //       ).map((e) => CartItem.fromJson(e)).toList();
  //       cartItems.assignAll(loaded);
  //     }
  //   }
}
