import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/edit_occasions_desktop.dart';

class EditOccasionsScreen extends StatelessWidget {
  const EditOccasionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HSiteTemplate(
      desktop: EditOccasionsDesktopScreen(),
    );
  }
}
