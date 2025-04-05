import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/repositories/auth/auth_repo.dart';
import '../../../data/repositories/auth/user_repo.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../model/user_model.dart';
import 'user_controller.dart';

class LoginController extends GetxController {
  final hidePassword = true.obs;
  final remeberMe = false.obs;
  final isLoading = false.obs;
  final _localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = _localStorage.read("REMEBER_ME_EMAIL") ?? '';
    password.text = _localStorage.read("REMEBER_ME_PASSWORD") ?? '';
    super.onInit();
  }

  Future<void> login() async {
    try {
      HFullScreenLoader.openLoadingDialog(
          'Logging in...', HImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HFullScreenLoader.stopLoading();
        return;
      }
      if (!loginFormKey.currentState!.validate()) {
        HFullScreenLoader.stopLoading();
        return;
      }

      if (remeberMe.value) {
        _localStorage.write("REMEBER_ME_EMAIL", email.text.trim());
        _localStorage.write("REMEBER_ME_PASSWORD", password.text.trim());
      }
      await AuthRepo.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());

      final user = await UserController.instance.fetchUserDetails();

      HFullScreenLoader.stopLoading();
      if (user.role != AppRole.admin) {
        AuthRepo.instance.signOut();
        HLoaders.errorSnackBar(
            title: 'Not Authorized',
            message: 'You are not authorized or dont have acsess.');
      } else {
        AuthRepo.instance.screenRedirect();
      }
    } catch (e) {
      HFullScreenLoader.stopLoading();
      HLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> signUpAdmin() async {
    try {
      HFullScreenLoader.openLoadingDialog(
          'Registering Admin Account...', HImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HFullScreenLoader.stopLoading();
        return;
      }

      final userdata = await AuthRepo.instance.signUpWithEmailAndPassword(
          email: 'Admin@gmail.com', password: 'admin123');
      final UserRepo userRepo = Get.put(UserRepo());
      final newUser = UserModel(
        email: 'Admin@gmail.com',
        id: userdata.user!.uid,
        role: AppRole.admin,
        firstName: 'Admin',
        userName: 'Admin',
      );

      userRepo.createUser(user: newUser);
      HFullScreenLoader.stopLoading();
      AuthRepo.instance.screenRedirect();
    } catch (e) {
      HFullScreenLoader.stopLoading();
      HLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
