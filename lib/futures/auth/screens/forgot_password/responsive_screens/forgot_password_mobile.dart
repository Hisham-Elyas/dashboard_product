import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../widgets/header_and_form.dart';

class ForgotPasswordMobileScreen extends StatelessWidget {
  const ForgotPasswordMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProductsController());
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(HSizes.defaultSpace),
          child: HeaderAndForm(),
        ),
      ),
    );
  }
}
