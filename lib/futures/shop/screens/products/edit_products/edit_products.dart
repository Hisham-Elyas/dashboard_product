import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/sidebars/sidebar_controller.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import '../../../../../common/widgets/loaders/circular_loader.dart';
import '../../../../../routes/routes.dart';
import 'responsive_screens/edit_products_desktop.dart';
import 'responsive_screens/edit_products_tablet.dart';

class EditProductsScreen extends StatelessWidget {
  const EditProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments;
    // If product is null, redirect back
    if (product == null) {
      Future.microtask(() {
        Get.offNamedUntil(HRoutes.products, (route) => false);
        Future.delayed(const Duration(milliseconds: 100), () {
          SidebarController.instance.changeActiveItemTo(HRoutes.products);
        });
      });
      return const Scaffold(body: Center(child: HCircularLoader()));
    }
    return HSiteTemplate(
      desktop: EditProductsDesktopScreen(product: product),
      tablet: EditProductsTabletScreen(product: product),
      mobile: EditProductsTabletScreen(product: product),
    );
  }
}
