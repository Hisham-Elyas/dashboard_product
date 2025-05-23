import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/banners_desktop.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HSiteTemplate(
      desktop: BannersDesktopScreen(),
      mobile: BannersDesktopScreen(),
      tablet: BannersDesktopScreen(),
    );
  }
}
