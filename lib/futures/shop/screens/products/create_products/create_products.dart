import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/create_products_desktop.dart';
import 'responsive_screens/create_products_tablet.dart';

class CreateProductsScreen extends StatelessWidget {
  const CreateProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HSiteTemplate(
      desktop: CreateProductsDesktopScreen(),
      mobile: CreateProductsTabletScreen(),
      tablet: CreateProductsTabletScreen(),
    );
  }
}
