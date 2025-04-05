import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../widgets/reset_password_widget.dart';

class ResetPasswordMobileScreen extends StatelessWidget {
  const ResetPasswordMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProductsController());
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(HSizes.defaultSpace),
          child: ResetPasswordWidget(),
        ),
      ),
    );
  }
}
