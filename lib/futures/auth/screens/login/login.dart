import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/login_desktop.dart';
import 'responsive_screens/login_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HSiteTemplate(
      uselayout: false,
      desktop: LoginDesktopScreen(),
      tablet: LoginDesktopScreen(),
      mobile: LoginMobileScreen(),
    );
  }
}
