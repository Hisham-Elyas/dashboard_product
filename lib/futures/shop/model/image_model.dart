// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:universal_html/html.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final String? sizeBytes;
  final String fileName;
  final String? filePath;

  /// not mapped
  final File? file;
  final Uint8List? localImageToDisplay;

  ImageModel({
    this.id = '',
    required this.url,
    required this.folder,
    this.sizeBytes,
    required this.fileName,
    this.filePath,
    this.file,
    this.localImageToDisplay,
  });
  static ImageModel empty() => ImageModel(url: '', folder: '', fileName: '');

  ImageModel copyWith({
    String? id,
    String? url,
    String? folder,
    String? sizeBytes,
    String? fileName,
    String? filePath,
    File? file,
    Uint8List? localImageToDisplay,
  }) {
    return ImageModel(
      id: id ?? this.id,
      url: url ?? this.url,
      folder: folder ?? this.folder,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      file: file ?? this.file,
      localImageToDisplay: localImageToDisplay ?? this.localImageToDisplay,
    );
  }

  factory ImageModel.fromFirebaseMetadata(FullMetadata metadata, String folder,
          String fileName, String downloadURL) =>
      ImageModel(
          url: downloadURL,
          folder: folder,
          fileName: fileName,
          filePath: metadata.fullPath);

  @override
  String toString() {
    return 'ImageModel(id: $id, url: $url, folder: $folder, sizeBytes: $sizeBytes, fileName: $fileName, filePath: $filePath, file: $file, localImageToDisplay: $localImageToDisplay)';
  }

  @override
  bool operator ==(covariant ImageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.url == url &&
        other.folder == folder &&
        other.sizeBytes == sizeBytes &&
        other.fileName == fileName &&
        other.filePath == filePath &&
        other.file == file &&
        other.localImageToDisplay == localImageToDisplay;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        url.hashCode ^
        folder.hashCode ^
        sizeBytes.hashCode ^
        fileName.hashCode ^
        filePath.hashCode ^
        file.hashCode ^
        localImageToDisplay.hashCode;
  }
}
