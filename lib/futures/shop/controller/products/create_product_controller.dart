import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/media/media_repo.dart';
import '../../../../data/repositories/products/products_repo.dart';
import '../../../../utils/helpers/media_helper.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/category_model.dart';
import '../../model/image_model.dart';
import '../../model/occasions_model.dart';
import '../../model/products_model.dart';
import 'products_controller.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();
  final MediaRepo _mediaRepoController = Get.put(MediaRepo());

  final loading = false.obs;
  final isActive = false.obs;
  final name = TextEditingController();
  final price = TextEditingController();
  final detail = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  RxList<OccasionsModel> selectedOccasion = <OccasionsModel>[].obs;
  late DropzoneViewController dropzoneViewController;
  Rx<ImageModel> image = ImageModel.empty().obs;

  selectLocalImages() async {
    image.value = await MediaHelper.selectLocalImages(
        dropzoneViewController: dropzoneViewController);
  }

  Future<void> createProduct() async {
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
          path: "Products",
          imageName: image.value.fileName);
      final newProducts = ProductsModel(
        id: "",
        name: name.text.trim(),
        categoriesIds: [
          ...selectedCategories.map((e) => e.id),
          ...selectedOccasion.map((e) => e.id)
        ],
        detail: detail.text.trim(),
        price: double.parse(price.text.trim()),
        isActive: isActive.value,
        imagePath: uploadImage.filePath!,
        imageUrl: uploadImage.url,
      );
      newProducts.id = await ProductsRepo.instance.createProducts(newProducts);
      ProductsController.instance.addItemToLists(newProducts);
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
    image.value = ImageModel.empty();
    // isActive(false);
    // name.clear();
    // price.clear();
    // detail.clear();
  }
}
