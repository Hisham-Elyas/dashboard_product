import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/auth/auth_repo.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class ResetPasswordController extends GetxController {
  static ResetPasswordController get instance => Get.find();
  final isSuccess = false.obs;
  final resetFormKey = GlobalKey<FormState>();

  final email = TextEditingController();

  Future<void> resetPassword() async {
    try {
      HFullScreenLoader.popUpCircular();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HFullScreenLoader.stopLoading();
        return;
      }
      if (!resetFormKey.currentState!.validate()) {
        HFullScreenLoader.stopLoading();
        return;
      }

      await AuthRepo.instance.sendPasswordResetEmail(email.text.trim());
      HFullScreenLoader.stopLoading();
      HLoaders.successSnackBar(
          title: 'Success', message: 'Check your email for reset link');
      isSuccess.value = true;
    } catch (e) {
      HFullScreenLoader.stopLoading();
      HLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
