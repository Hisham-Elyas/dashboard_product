import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/edit_categories_desktop.dart';

class EditCategoriesScreen extends StatelessWidget {
  const EditCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments;

    return HSiteTemplate(
      desktop: EditCategoriesDesktopScreen(category: category),
    );
  }
}
