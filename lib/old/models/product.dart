// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.image == image &&
        other.detail == detail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        image.hashCode ^
        detail.hashCode;
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, image: $image, detail: $detail)';
  }
}
