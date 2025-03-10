import 'package:flutter/material.dart';

import '../../responsive/responsive_design.dart';
import '../../responsive/screens/desktop_layout.dart';
import '../../responsive/screens/mobile_layout.dart';
import '../../responsive/screens/tablet_layout.dart';

// template for the overall site layout, responsive to different screen sizes
class HSiteTemplate extends StatelessWidget {
  /// widgets for desktop layout
  final Widget? desktop;
  // widgets for tablet layout
  final Widget? tablet;
  // widgets for mobile layout
  final Widget? mobile;
  // flag to determine whether to use  layout
  final bool uselayout;
  const HSiteTemplate(
      {super.key,
      this.desktop,
      this.tablet,
      this.mobile,
      this.uselayout = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HResponsiveWidget(
        desktop: uselayout
            ? DesktopLayout(body: desktop)
            : desktop ?? const SizedBox(),
        tablet: uselayout
            ? TabletLayout(body: tablet ?? desktop)
            : tablet ?? desktop ?? const SizedBox(),
        mobile: uselayout
            ? MobileLayout(body: mobile ?? desktop)
            : mobile ?? desktop ?? const SizedBox(),
      ),
    );
  }
}
