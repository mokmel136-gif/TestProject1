class CartItem {
  String name;
  String image;
  double price;
  int quantity;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    name: json['name'],
    image: json['image'],
    price: json['price'],
    quantity: json['quantity'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
    'price': price,
    'quantity': quantity,
  };

  double get totalPrice => price * quantity;
}
