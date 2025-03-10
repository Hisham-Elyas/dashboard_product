import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/create_categories_desktop.dart';

class CreateCategoriesScreen extends StatelessWidget {
  const CreateCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HSiteTemplate(
      desktop: CreatecategoriesDesktopScreen(),
    );
  }
}
