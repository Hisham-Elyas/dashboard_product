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

class CreateBannerController extends GetxController {
  static CreateBannerController get instance => Get.find();
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

  Future<void> createBanner() async {
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
          path: "banners",
          imageName: image.value.fileName);
      final newBanner = BannersModel(
        id: "",
        name: name.text.trim(),
        isActive: isActive.value,
        imagePath: uploadImage.filePath!,
        imageUrl: uploadImage.url,
      );
      newBanner.id = await BannersRepo.instance.createBanners(newBanner);
      BannersController.instance.addItemToLists(newBanner);
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
