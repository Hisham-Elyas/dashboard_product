import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/login_templates.dart';
import '../widgets/reset_password_widget.dart';

class ResetPasswordDesktopScreen extends StatelessWidget {
  const ResetPasswordDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProductsController());
    return const HLoginTemplates(
      child: ResetPasswordWidget(),
    );
  }
}
