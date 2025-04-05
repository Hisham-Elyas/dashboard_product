import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/reset_password_controller.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    return Column(
      children: [
        /// header
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.offAllNamed(HRoutes.login);
                },
                icon: const Icon(CupertinoIcons.clear)),
          ],
        ),
        // image
        const Image(image: AssetImage(HImages.deliveredEmailIllustration)),
        const SizedBox(height: HSizes.spaceBtwSections),
        // title & subtitle
        Text(HTexts.changeYourPasswordTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: HSizes.spaceBtwSections),
        Text(controller.email.text,
            style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: HSizes.spaceBtwSections),
        Text(HTexts.changeYourPasswordSubTitle,
            style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: HSizes.spaceBtwSections),

        // button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Get.offAllNamed(HRoutes.login);
            },
            child: const Text(HTexts.done),
          ),
        ),
        const SizedBox(height: HSizes.spaceBtwSections),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              controller.resetPassword();
            },
            child: const Text(HTexts.resendEmail),
          ),
        ),
      ],
    );
  }
}
