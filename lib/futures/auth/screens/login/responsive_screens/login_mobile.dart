import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../widgets/login_form_widget.dart';
import '../widgets/login_header.dart';

class LoginMobileScreen extends StatelessWidget {
  const LoginMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProductsController());
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(HSizes.defaultSpace),
          child: Column(
            children: [
              /// header
              LoginHeader(),

              /// form
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
