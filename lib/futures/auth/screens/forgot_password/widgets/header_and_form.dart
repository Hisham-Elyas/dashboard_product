import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/reset_password_controller.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// header
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Iconsax.arrow_left)),
        const SizedBox(height: HSizes.spaceBtwSections),
        Text(HTexts.forgetPasswordTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: HSizes.spaceBtwSections),
        Text(HTexts.forgetPasswordSubTitle,
            style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: HSizes.spaceBtwSections * 2),

        /// form

        Form(
            key: controller.resetFormKey,
            child: TextFormField(
              validator: (value) => HValidator.validateEmail(value),
              controller: controller.email,
              decoration: const InputDecoration(
                labelText: HTexts.email,
                prefixIcon: Icon(Iconsax.direct_right),
              ),
            )),
        const SizedBox(height: HSizes.spaceBtwItems),
        // submit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await controller.resetPassword();
              if (controller.isSuccess.value) {
                Get.toNamed(HRoutes.resetPassword);
              }
            },
            child: const Text(HTexts.submit),
          ),
        ),
        const SizedBox(height: HSizes.spaceBtwSections * 2),
      ],
    );
  }
}
