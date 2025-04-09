import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/sidebars/sidebar_controller.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import '../../../../../routes/routes.dart';
import 'responsive_screens/edit_occasions_desktop.dart';

class EditOccasionsScreen extends StatelessWidget {
  const EditOccasionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final occasions = Get.arguments;
    // If occasions is null, redirect back
    if (occasions == null) {
      Future.microtask(() {
        Get.offNamedUntil(HRoutes.occasions, (route) => false);
        Future.delayed(const Duration(milliseconds: 100), () {
          SidebarController.instance.changeActiveItemTo(HRoutes.occasions);
        });
      });
    }
    return HSiteTemplate(
      desktop: EditOccasionsDesktopScreen(occasions: occasions),
    );
  }
}
