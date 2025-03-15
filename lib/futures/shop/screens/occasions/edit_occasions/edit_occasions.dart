import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/edit_occasions_desktop.dart';

class EditOccasionsScreen extends StatelessWidget {
  const EditOccasionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final occasions = Get.arguments;
    return HSiteTemplate(
      desktop: EditOccasionsDesktopScreen(occasions: occasions),
    );
  }
}
