// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../utils/constants/enums.dart';

class OrderModel {
  String id;
  final String userId;
  final double totalAmount;
  DateTime? createdAt;
  final String deliveryMethod;
  final Address? shippingAddress;
  final String shippingCompany;
  final String? shippingNotes;
  final String paymentMethod;
  final OrderStatus orderStatus;
  final List<CartItemModel> item;

  OrderModel({
    required this.id,
    required this.userId,
    required this.totalAmount,
    this.createdAt,
    required this.deliveryMethod,
    required this.shippingAddress,
    required this.shippingCompany,
    this.shippingNotes,
    required this.paymentMethod,
    this.orderStatus = OrderStatus.pending,
    required this.item,
  });

  OrderModel copyWith({
    String? id,
    String? userId,
    double? totalAmount,
    DateTime? createdAt,
    String? deliveryMethod,
    Address? shippingAddress,
    String? shippingCompany,
    String? shippingNotes,
    String? paymentMethod,
    OrderStatus? orderStatus,
    List<CartItemModel>? item,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      shippingCompany: shippingCompany ?? this.shippingCompany,
      shippingNotes: shippingNotes ?? this.shippingNotes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      orderStatus: orderStatus ?? this.orderStatus,
      item: item ?? this.item,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'userId': userId,
      'totalAmount': totalAmount,
      'createdAt': FieldValue.serverTimestamp(), // Always update this field
      'deliveryMethod': deliveryMethod,
      'shippingAddress': shippingAddress?.toMap(),
      'shippingCompany': shippingCompany,
      'shippingNotes': shippingNotes,
      'paymentMethod': paymentMethod,
      'orderStatus': orderStatus.name.toString(),
      'item': item.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      totalAmount: map['totalAmount'] as double,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      deliveryMethod: map['deliveryMethod'] as String,
      shippingAddress: map['shippingAddress'] != null
          ? Address.fromMap(map['shippingAddress'] as Map<String, dynamic>)
          : null,
      shippingCompany: map['shippingCompany'] as String,
      shippingNotes:
          map['shippingNotes'] != null ? map['shippingNotes'] as String : null,
      paymentMethod: map['paymentMethod'] as String,
      // orderStatus: OrderStatus.fromMap(map['orderStatus'] as Map<String,dynamic>),
      orderStatus: OrderStatus.values
          .byName(map['orderStatus'] ?? OrderStatus.pending.name),
      item: List<CartItemModel>.from(
        (map['item'] as List).map<CartItemModel>(
          (x) => CartItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return OrderModel(
        id: document.id,
        userId: data['userId'] as String,
        totalAmount: data['totalAmount'] as double,
        createdAt: data['createdAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(data['createdAt'] as int)
            : null,
        deliveryMethod: data['deliveryMethod'] as String,
        shippingAddress: data['shippingAddress'] != null
            ? Address.fromMap(data['shippingAddress'] as Map<String, dynamic>)
            : null,
        shippingCompany: data['shippingCompany'] as String,
        shippingNotes: data['shippingNotes'] != null
            ? data['shippingNotes'] as String
            : null,
        paymentMethod: data['paymentMethod'] as String,
        orderStatus: OrderStatus.values
            .byName(data['orderStatus'] ?? OrderStatus.pending.name),
        item: List<CartItemModel>.from(
          (data['item'] as List).map<CartItemModel>(
            (x) => CartItemModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
    } else {
      return OrderModel.empty();
    }
  }

  static OrderModel empty() => OrderModel(
        id: '',
        userId: '',
        totalAmount: 0,
        deliveryMethod: '',
        shippingAddress: null,
        shippingCompany: '',
        paymentMethod: '',
        item: [],
      );

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, userId: $userId, totalAmount: $totalAmount, createdAt: $createdAt, deliveryMethod: $deliveryMethod, shippingAddress: $shippingAddress, shippingCompany: $shippingCompany, shippingNotes: $shippingNotes, paymentMethod: $paymentMethod, orderStatus: $orderStatus, item: $item)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.totalAmount == totalAmount &&
        other.createdAt == createdAt &&
        other.deliveryMethod == deliveryMethod &&
        other.shippingAddress == shippingAddress &&
        other.shippingCompany == shippingCompany &&
        other.shippingNotes == shippingNotes &&
        other.paymentMethod == paymentMethod &&
        other.orderStatus == orderStatus &&
        listEquals(other.item, item);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        totalAmount.hashCode ^
        createdAt.hashCode ^
        deliveryMethod.hashCode ^
        shippingAddress.hashCode ^
        shippingCompany.hashCode ^
        shippingNotes.hashCode ^
        paymentMethod.hashCode ^
        orderStatus.hashCode ^
        item.hashCode;
  }
}

class CartItemModel {
  String productId;
  String productName;
  String productImageUrl;
  double price;
  int quantity;
  CartItemModel({
    required this.productId,
    this.productName = '',
    this.productImageUrl = '',
    this.price = 0.0,
    required this.quantity,
  });
  String get totalAmount => (price * quantity).toStringAsFixed(2);

  CartItemModel copyWith({
    String? productId,
    String? productName,
    String? productImageUrl,
    double? price,
    int? quantity,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'productImageUrl': productImageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      productImageUrl: map['productImageUrl'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
    );
  }

  @override
  String toString() {
    return 'CartItemModel(productId: $productId, productName: $productName, productImageUrl: $productImageUrl, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant CartItemModel other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.productName == productName &&
        other.productImageUrl == productImageUrl &&
        other.price == price &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        productImageUrl.hashCode ^
        price.hashCode ^
        quantity.hashCode;
  }
}

class Address {
  String id;
  String city;
  String country;
  String street;
  String district;
  String houseDesc;
  String postalCode;

  Address({
    required this.id,
    required this.city,
    required this.country,
    required this.street,
    required this.district,
    required this.houseDesc,
    required this.postalCode,
  });

  Address copyWith({
    String? id,
    String? city,
    String? country,
    String? street,
    String? district,
    String? houseDesc,
    String? postalCode,
  }) {
    return Address(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      street: street ?? this.street,
      district: district ?? this.district,
      houseDesc: houseDesc ?? this.houseDesc,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'city': city,
      'country': country,
      'street': street,
      'district': district,
      'houseDesc': houseDesc,
      'postalCode': postalCode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
      street: map['street'] as String,
      district: map['district'] as String,
      houseDesc: map['houseDesc'] as String,
      postalCode: map['postalCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(id: $id, city: $city, country: $country, street: $street, district: $district, houseDesc: $houseDesc, postalCode: $postalCode)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.city == city &&
        other.country == country &&
        other.street == street &&
        other.district == district &&
        other.houseDesc == houseDesc &&
        other.postalCode == postalCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        city.hashCode ^
        country.hashCode ^
        street.hashCode ^
        district.hashCode ^
        houseDesc.hashCode ^
        postalCode.hashCode;
  }
}
