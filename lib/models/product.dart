class Product {
  String? id;
  String name;
  double price;
  String image;
  String detail;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.detail,
  });

  factory Product.fromJson(Map<String, dynamic> json, String id) {
    return Product(
      id: id,
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'] ?? '',
      detail: json['detail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'detail': detail,
    };
  }
}
