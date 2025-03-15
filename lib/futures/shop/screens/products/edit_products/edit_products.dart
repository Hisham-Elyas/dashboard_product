import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/edit_products_desktop.dart';
import 'responsive_screens/edit_products_tablet.dart';

class EditProductsScreen extends StatelessWidget {
  const EditProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments;
    return HSiteTemplate(
      desktop: EditProductsDesktopScreen(product: product),
      tablet: EditProductsTabletScreen(product: product),
      mobile: EditProductsTabletScreen(product: product),
    );
  }
}
