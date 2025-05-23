import 'package:flutter/material.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/dashboard_desktop.dart';
import 'responsive_screens/dashboard_mobile.dart';
import 'responsive_screens/dashboard_tablet.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HSiteTemplate(
      desktop: DashboardDesktopScreen(),
      mobile: DashboardMobileScreen(),
      tablet: DashboardTabletScreen(),
    );
  }
}
