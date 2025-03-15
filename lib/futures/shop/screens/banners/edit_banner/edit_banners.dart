import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/edit_banners_desktop.dart';

class EditBannersScreen extends StatelessWidget {
  const EditBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
    return HSiteTemplate(
      desktop: EditBannersDesktopScreen(banners: banner),
    );
  }
}
