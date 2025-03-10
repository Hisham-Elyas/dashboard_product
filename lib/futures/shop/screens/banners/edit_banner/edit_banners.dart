import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/edit_banners_desktop.dart';

class EditBannersScreen extends StatelessWidget {
  const EditBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HSiteTemplate(
      desktop: EditBannersDesktopScreen(),
      mobile: EditBannersDesktopScreen(),
      tablet: EditBannersDesktopScreen(),
    );
  }
}
