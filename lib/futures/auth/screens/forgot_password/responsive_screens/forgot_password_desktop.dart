import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/login_templates.dart';
import '../widgets/header_and_form.dart';

class ForgotPasswordDesktopScreen extends StatelessWidget {
  const ForgotPasswordDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProductsController());
    return const HLoginTemplates(
      child: HeaderAndForm(),
    );
  }
}
