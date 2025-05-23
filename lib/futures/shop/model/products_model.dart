// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductsModel {
  String id;
  String name;
  String imageUrl;
  String imagePath;
  bool isActive;
  List<String> categoriesIds;

  double price;
  String detail;
  ProductsModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.imagePath,
    this.isActive = false,
    this.categoriesIds = const [],
    required this.price,
    required this.detail,
  });

  ProductsModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? imagePath,
    bool? isActive,
    List<String>? categoriesIds,
    double? price,
    String? detail,
  }) {
    return ProductsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      imagePath: imagePath ?? this.imagePath,
      isActive: isActive ?? this.isActive,
      categoriesIds: categoriesIds ?? this.categoriesIds,
      price: price ?? this.price,
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'imagePath': imagePath,
      'isActive': isActive,
      'categoriesIds': categoriesIds,
      'price': price,
      'detail': detail,
    };
  }

  factory ProductsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductsModel(
          id: document.id,
          name: data['name'] as String,
          imageUrl: data['imageUrl'] as String,
          imagePath: data['imagePath'] as String,
          isActive: data['isActive'] as bool,
          price: data['price'] as double,
          detail: data['detail'] as String,
          categoriesIds: List.from((data['categoriesIds'] as List)));
    } else {
      return ProductsModel.empty();
    }
  }

  @override
  String toString() {
    return 'ProductsModel(id: $id, name: $name, imageUrl: $imageUrl, imagePath: $imagePath, isActive: $isActive, categoriesIds: $categoriesIds, price: $price, detail: $detail)';
  }

  @override
  bool operator ==(covariant ProductsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.imagePath == imagePath &&
        other.isActive == isActive &&
        listEquals(other.categoriesIds, categoriesIds) &&
        other.price == price &&
        other.detail == detail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        imagePath.hashCode ^
        isActive.hashCode ^
        categoriesIds.hashCode ^
        price.hashCode ^
        detail.hashCode;
  }

  static ProductsModel empty() => ProductsModel(
        id: '',
        name: '',
        isActive: false,
        imagePath: '',
        imageUrl: '',
        detail: '',
        price: 0,
      );
}
