import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/forgot_password_desktop.dart';
import 'responsive_screens/forgot_password_mobile.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HSiteTemplate(
      uselayout: false,
      desktop: ForgotPasswordDesktopScreen(),
      tablet: ForgotPasswordDesktopScreen(),
      mobile: ForgotPasswordMobileScreen(),
    );
  }
}
