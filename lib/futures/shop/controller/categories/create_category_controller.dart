import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/categories/categories_repo.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/category_model.dart';
import 'categories_controller.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final loading = false.obs;
  final isActive = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> createCategory() async {
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
      final newCategory = CategoryModel(
        id: "",
        name: name.text.trim(),
        isActive: isActive.value,
      );
      newCategory.id =
          await CategoriesRepo.instance.createCategory(newCategory);
      CategoriesController.instance.addItemToLists(newCategory);
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
    name.clear();
  }
}
