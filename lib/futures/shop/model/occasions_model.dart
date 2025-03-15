import 'package:cloud_firestore/cloud_firestore.dart';

class OccasionsModel {
  String id;
  String name;
  String imageUrl;
  String imagePath;
  bool isActive;
  OccasionsModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.imageUrl,
    this.isActive = false,
  });

  OccasionsModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? imagePath,
    bool? isActive,
  }) {
    return OccasionsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      imagePath: imagePath ?? this.imagePath,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'imagePath': imagePath,
      'isActive': isActive,
    };
  }

  factory OccasionsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return OccasionsModel(
        id: document.id,
        name: data['name'] as String,
        imageUrl: data['imageUrl'] as String,
        imagePath: data['imagePath'] as String,
        isActive: data['isActive'] as bool,
      );
    } else {
      return OccasionsModel.empty();
    }
  }

  @override
  String toString() {
    return 'OccasionsModel(id: $id, name: $name, imageUrl: $imageUrl, imagePath: $imagePath, isActive: $isActive)';
  }

  @override
  bool operator ==(covariant OccasionsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.imagePath == imagePath &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        imagePath.hashCode ^
        isActive.hashCode;
  }

  static OccasionsModel empty() => OccasionsModel(
      id: '', name: '', isActive: false, imagePath: '', imageUrl: '');
}
