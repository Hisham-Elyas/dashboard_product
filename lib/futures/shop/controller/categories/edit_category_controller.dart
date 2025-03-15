import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/categories/categories_repo.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/category_model.dart';
import 'categories_controller.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final loading = false.obs;
  final isActive = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  inIt(CategoryModel category) {
    name.text = category.name;
    isActive.value = category.isActive;
  }

  Future<void> updateCategory(CategoryModel category) async {
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

      category.name = name.text.trim();
      category.isActive = isActive.value;

      await CategoriesRepo.instance.updateCategory(category);
      CategoriesController.instance.updateItemFromLists(category);

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
    name.clear();
  }
}
