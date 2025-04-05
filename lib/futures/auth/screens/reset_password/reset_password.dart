import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/reset_password_desktop.dart';
import 'responsive_screens/reset_password_mobile.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HSiteTemplate(
      uselayout: false,
      desktop: ResetPasswordDesktopScreen(),
      tablet: ResetPasswordDesktopScreen(),
      mobile: ResetPasswordMobileScreen(),
    );
  }
}
