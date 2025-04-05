import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(
              image: AssetImage(HImages.darkAppLogo), width: 100, height: 100),
          const SizedBox(height: HSizes.spaceBtwSections),
          Text(HTexts.loginTitle,
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: HSizes.spaceBtwSections),
          Text(HTexts.loginSubTitle,
              style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
