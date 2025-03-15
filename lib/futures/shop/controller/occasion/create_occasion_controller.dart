import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/media/media_repo.dart';
import '../../../../data/repositories/occasions/occasions_repo.dart';
import '../../../../utils/helpers/media_helper.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/image_model.dart';
import '../../model/occasions_model.dart';
import 'occasion_controller.dart';

class CreateOccasionController extends GetxController {
  static CreateOccasionController get instance => Get.find();
  final MediaRepo _mediaRepoController = Get.put(MediaRepo());

  final loading = false.obs;
  final isActive = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late DropzoneViewController dropzoneViewController;
  Rx<ImageModel> image = ImageModel.empty().obs;

  selectLocalImages() async {
    image.value = await MediaHelper.selectLocalImages(
        dropzoneViewController: dropzoneViewController);
  }

  Future<void> createoOccasion() async {
    try {
      if (image.value.file == null) {
        HLoaders.warningSnackBar(
            title: "Oh Snap!", message: 'Please select image');
        return;
      }
      HFullScreenLoader.popUpCircular();
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HFullScreenLoader.stopLoading();
        return;
      }
      if (!formKey.currentState!.validate()) {
        HFullScreenLoader.stopLoading();
        return;
      }

      final uploadImage = await _mediaRepoController.uploadImageFileInStorage(
          file: image.value.file!,
          path: "Occasion",
          imageName: image.value.fileName);
      final newOccasion = OccasionsModel(
        id: "",
        name: name.text.trim(),
        isActive: isActive.value,
        imagePath: uploadImage.filePath!,
        imageUrl: uploadImage.url,
      );
      newOccasion.id =
          await OccasionsRepo.instance.createOccasions(newOccasion);
      OccasionController.instance.addItemToLists(newOccasion);
      restFields();
      HFullScreenLoader.stopLoading();
      HLoaders.successSnackBar(
          title: "Congratulations", message: "New Record has been added.");
    } catch (e) {
      HFullScreenLoader.stopLoading();

      HLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  void restFields() {
    loading(false);
    isActive(false);
    image.value = ImageModel.empty();
    name.clear();
  }
}
