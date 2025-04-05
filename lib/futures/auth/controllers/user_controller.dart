import 'package:get/get.dart';

import '../../../data/repositories/auth/user_repo.dart';
import '../model/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepo = Get.put(UserRepo());

  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final user = await userRepo.fetchUserDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    } catch (e) {
      loading.value = false;
      // HLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return UserModel.empty();
    }
  }

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }
}
