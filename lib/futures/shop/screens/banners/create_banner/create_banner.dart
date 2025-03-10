import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/create_banners_desktop.dart';

class CreateBannersScreen extends StatelessWidget {
  const CreateBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HSiteTemplate(
      desktop: CreateBannersDesktopScreen(),
    );
  }
}
