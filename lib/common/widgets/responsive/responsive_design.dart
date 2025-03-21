import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class HResponsiveWidget extends StatelessWidget {
  final Widget desktop;
  final Widget tablet;
  final Widget mobile;
  const HResponsiveWidget(
      {super.key,
      required this.desktop,
      required this.tablet,
      required this.mobile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= HSizes.desktopScreenSize) {
          return desktop;
        } else if (constraints.maxWidth < HSizes.desktopScreenSize &&
            constraints.maxWidth >= HSizes.tabletScreenSize) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
