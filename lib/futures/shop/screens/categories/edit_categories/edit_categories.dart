import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/sidebars/sidebar_controller.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import '../../../../../common/widgets/loaders/circular_loader.dart';
import '../../../../../routes/routes.dart';
import 'responsive_screens/edit_categories_desktop.dart';

class EditCategoriesScreen extends StatelessWidget {
  const EditCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments;
    // If Category is null, redirect back
    if (category == null) {
      Future.microtask(() {
        Get.offNamedUntil(HRoutes.categories, (route) => false);
        Future.delayed(const Duration(milliseconds: 100), () {
          SidebarController.instance.changeActiveItemTo(HRoutes.categories);
        });
      });

      return const Scaffold(body: Center(child: HCircularLoader()));
    }

    return HSiteTemplate(
      desktop: EditCategoriesDesktopScreen(category: category),
    );
  }
}
