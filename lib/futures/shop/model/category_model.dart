import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  String id;
  String name;
  bool isActive;
  CategoryModel({
    required this.id,
    required this.name,
    this.isActive = false,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    bool? isActive,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isActive': isActive,
    };
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data['name'] as String,
        isActive: data['isActive'] as bool,
      );
    } else {
      return CategoryModel.empty();
    }
  }

  @override
  String toString() =>
      'CategoryModel(id: $id, name: $name, isActive: $isActive)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.isActive == isActive;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isActive.hashCode;

  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', isActive: false);
}
