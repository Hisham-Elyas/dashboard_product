import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_dashboard_store/routes/routes.dart';

import '../../../../../common/widgets/layouts/sidebars/sidebar_controller.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import '../../../../../common/widgets/loaders/circular_loader.dart';
import 'responsive_screens/edit_banners_desktop.dart';

class EditBannersScreen extends StatelessWidget {
  const EditBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
    // If banner is null, redirect back
    if (banner == null) {
      Future.microtask(() {
        Get.offNamedUntil(HRoutes.banners, (route) => false);
        Future.delayed(const Duration(milliseconds: 100), () {
          SidebarController.instance.changeActiveItemTo(HRoutes.banners);
        });
      });
      return const Scaffold(body: Center(child: HCircularLoader()));
    }
    return HSiteTemplate(
      desktop: EditBannersDesktopScreen(banners: banner),
    );
  }
}
