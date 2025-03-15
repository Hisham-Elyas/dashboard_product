import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/banners/banners_repo.dart';
import '../../../../data/repositories/media/media_repo.dart';
import '../../../../utils/helpers/media_helper.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/banners_model.dart';
import '../../model/image_model.dart';
import 'banners_controller.dart';

class EditBannersController extends GetxController {
  static EditBannersController get instance => Get.find();

  final MediaRepo _mediaRepoController = Get.put(MediaRepo());

  final loading = false.obs;
  final isActive = false.obs;
  final isImageUpdated = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late DropzoneViewController dropzoneViewController;
  Rx<ImageModel> image = ImageModel.empty().obs;

  inIt(BannersModel banners) {
    name.text = banners.name;
    isActive.value = banners.isActive;
  }

  selectLocalImages() async {
    image.value = await MediaHelper.selectLocalImages(
        dropzoneViewController: dropzoneViewController);
    if (image.value.localImageToDisplay != null) {
      isImageUpdated(true);
    }
  }

  Future<void> updateBanners(BannersModel banners) async {
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

      banners.name = name.text.trim();
      banners.isActive = isActive.value;
      if (isImageUpdated.value) {
        await _mediaRepoController.deleteFileFromStorage(
            filePath: banners.imagePath);

        final uploadImage = await _mediaRepoController.uploadImageFileInStorage(
            file: image.value.file!,
            path: "banners",
            imageName: image.value.fileName);
        banners.imagePath = uploadImage.filePath!;
        banners.imageUrl = uploadImage.url;
      }

      await BannersRepo.instance.updateBanners(banners);
      BannersController.instance.updateItemFromLists(banners);

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
