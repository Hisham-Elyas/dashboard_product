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

class EditOccasionController extends GetxController {
  static EditOccasionController get instance => Get.find();

  final MediaRepo _mediaRepoController = Get.put(MediaRepo());

  final loading = false.obs;
  final isActive = false.obs;
  final isImageUpdated = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late DropzoneViewController dropzoneViewController;
  Rx<ImageModel> image = ImageModel.empty().obs;

  inIt(OccasionsModel occasions) {
    name.text = occasions.name;
    isActive.value = occasions.isActive;
  }

  selectLocalImages() async {
    image.value = await MediaHelper.selectLocalImages(
        dropzoneViewController: dropzoneViewController);
    if (image.value.localImageToDisplay != null) {
      isImageUpdated(true);
    }
  }

  Future<void> updateOccasions(OccasionsModel occasions) async {
    try {
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

      occasions.name = name.text.trim();
      occasions.isActive = isActive.value;
      if (isImageUpdated.value) {
        await _mediaRepoController.deleteFileFromStorage(
            filePath: occasions.imagePath);

        final uploadImage = await _mediaRepoController.uploadImageFileInStorage(
            file: image.value.file!,
            path: "occasions",
            imageName: image.value.fileName);
        occasions.imagePath = uploadImage.filePath!;
        occasions.imageUrl = uploadImage.url;
      }

      await OccasionsRepo.instance.updateOccasions(occasions);
      OccasionController.instance.updateItemFromLists(occasions);

      restFields();
      HFullScreenLoader.stopLoading();
      Get.back();
      HLoaders.successSnackBar(
          title: "Congratulations", message: "New Record has been update.");
    } catch (e) {
      HFullScreenLoader.stopLoading();

      HLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  void restFields() {
    loading(false);
    isActive(false);
    isImageUpdated(false);
    image.value = ImageModel.empty();
    name.clear();
  }
}
