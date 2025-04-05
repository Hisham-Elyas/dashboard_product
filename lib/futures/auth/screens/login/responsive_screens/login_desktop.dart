import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/login_templates.dart';
import '../widgets/login_form_widget.dart';
import '../widgets/login_header.dart';

class LoginDesktopScreen extends StatelessWidget {
  const LoginDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HLoginTemplates(
      child: Column(
        children: [
          /// header
          LoginHeader(),

          /// form
          LoginForm(),
        ],
      ),
    );
  }
}
