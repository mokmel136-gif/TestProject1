// class CartItem {
//   final int? id;
//   final int? userId;
//   final int productId;
//   final String name;
//   final String image;
//   final int quantity;
//   final double price;
//   final String? createdAt;
//   final String? updatedAt;

//   CartItem({
//     this.id,
//     this.userId,
//     required this.productId,
//     required this.name,
//     required this.image,
//     required this.quantity,
//     required this.price,
//     this.createdAt,
//     this.updatedAt,
//   });
// factory CartItem.fromJson(Map<String, dynamic> json) {
//   return CartItem(
//     id: json['id'] is int
//         ? json['id']
//         : int.tryParse(json['id']?.toString() ?? ''),
//     userId: json['user_id'] is int
//         ? json['user_id']
//         : int.tryParse(json['user_id']?.toString() ?? ''),
//     productId: json['product_id'] is int
//         ? json['product_id']
//         : int.tryParse(json['product_id']?.toString() ?? '0') ?? 0,
//     name: json['name']?.toString() ?? '',
//     image: json['image']?.toString() ?? '',
//     quantity: json['quantity'] is int
//         ? json['quantity']
//         : int.tryParse(json['quantity']?.toString() ?? '') ?? 1,
//     price: json['price'] is double
//         ? json['price']
//         : double.tryParse(json['price']?.toString() ?? '0') ?? 0,
//     createdAt: json['created_at']?.toString(),
//     updatedAt: json['updated_at']?.toString(),
//   );
// }


//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'product_id': productId,
//       'name': name,
//       'image': image,
//       'quantity': quantity,
//       'price': price,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//     };
//   }

//   double get totalPrice => price * quantity;

//   CartItem copyWith({
//     int? id,
//     int? userId,
//     int? productId,
//     String? name,
//     String? image,
//     int? quantity,
//     double? price,
//     String? createdAt,
//     String? updatedAt,
//   }) {
//     return CartItem(
//       id: id ?? this.id,
//       userId: userId ?? this.userId,
//       productId: productId ?? this.productId,
//       name: name ?? this.name,
//       image: image ?? this.image,
//       quantity: quantity ?? this.quantity,
//       price: price ?? this.price,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }
// }
