import 'package:get/get.dart';

import '../../../../data/repositories/auth/user_repo.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../auth/model/user_model.dart';
import '../../model/orders_model.dart';

class OrderDetailController extends GetxController {
  static OrderDetailController get instance => Get.find();

  RxBool loading = true.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  /// -- Load customer orders
  Future<void> getCustomerOfCurrentOrder() async {
    try {
      // Show loader while loading categories
      loading.value = true;
      // Fetch customer
      final user =
          await UserRepo.instance.fetchUserDetailsById(order.value.userId);

      customer.value = user;
    } catch (e) {
      HLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}
