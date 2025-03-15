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

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  final MediaRepo _mediaRepoController = Get.put(MediaRepo());

  final loading = false.obs;
  final isActive = false.obs;
  final isImageUpdated = false.obs;
  final name = TextEditingController();
  final price = TextEditingController();
  final detail = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  RxList<OccasionsModel> selectedOccasion = <OccasionsModel>[].obs;
  late DropzoneViewController dropzoneViewController;
  Rx<ImageModel> image = ImageModel.empty().obs;
  ProductsModel oldProduct = ProductsModel.empty();

  inIt(ProductsModel product) {
    name.text = product.name;
    price.text = product.price.toString();
    detail.text = product.detail;
    isActive.value = product.isActive;
    oldProduct = product;
    // print("=====================");
    // print(product.categoriesIds.length);
    // print("=====================");
  }

  selectLocalImages() async {
    image.value = await MediaHelper.selectLocalImages(
        dropzoneViewController: dropzoneViewController);
    if (image.value.localImageToDisplay != null) {
      isImageUpdated(true);
    }
  }

  Future<void> updateProduct(ProductsModel product) async {
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

      product.name = name.text.trim();
      product.price = double.parse(price.text.trim());
      product.detail = detail.text.trim();
      product.isActive = isActive.value;
      product.categoriesIds = [
        ...selectedCategories.map((e) => e.id),
        ...selectedOccasion.map((e) => e.id)
      ];
      if (isImageUpdated.value) {
        await _mediaRepoController.deleteFileFromStorage(
            filePath: product.imagePath);

        final uploadImage = await _mediaRepoController.uploadImageFileInStorage(
            file: image.value.file!,
            path: "Products",
            imageName: image.value.fileName);
        product.imagePath = uploadImage.filePath!;
        product.imageUrl = uploadImage.url;
      }

      await ProductsRepo.instance.updateProducts(product);
      ProductsController.instance.updateItemFromLists(product);

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
    detail.clear();
    price.clear();
  }
}
