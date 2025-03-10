import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/create_coccasions_desktop.dart';

class CreateOccasionsScreen extends StatelessWidget {
  const CreateOccasionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HSiteTemplate(
      desktop: CreateOccasionsDesktopScreen(),
    );
  }
}
