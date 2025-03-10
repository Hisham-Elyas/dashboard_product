import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/device/device_utility.dart';

class SidebarController extends GetxController {
  final activeItem = HRoutes.dashboard.obs;
  final hoverItem = ''.obs;
  void changeActiveItemTo(String route) => activeItem.value = route;
  void changeHoverItemTo(String route) {
    if (!isActive(route)) hoverItem.value = route;
  }

  bool isActive(String route) => activeItem.value == route;
  bool isHovering(String route) => hoverItem.value == route;

  void menuOnTap(String route) {
    if (!isActive(route)) {
      changeActiveItemTo(route);
      if (TDeviceUtils.isMobileScreen(Get.context!)) Get.back();
      Get.toNamed(route);
    }
  }
}
