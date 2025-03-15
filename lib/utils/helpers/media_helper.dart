import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:universal_html/html.dart' as html;

import '../../futures/shop/model/image_model.dart';

class MediaHelper {
  static Future<ImageModel> selectLocalImages(
      {required DropzoneViewController dropzoneViewController}) async {
    final files = await dropzoneViewController.pickFiles(
        multiple: false, mime: ['image/png', 'image/jpeg', 'image/jpg']);

    if (files.isNotEmpty) {
      for (var file in files) {
        final bytes = await dropzoneViewController.getFileData(file);
        final blob = html.Blob([bytes]); // Create a Blob from bytes
        final convertedFile = html.File([blob], file.name);
        return ImageModel(
            url: '',
            folder: '',
            file: convertedFile,
            fileName: file.name,
            localImageToDisplay: Uint8List.fromList(bytes));
      }

      return ImageModel.empty();
    }
    return ImageModel.empty();
  }
}
