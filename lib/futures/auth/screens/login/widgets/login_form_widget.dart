import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: HSizes.spaceBtwItems),
          child: Column(
            children: [
              // email
              TextFormField(
                validator: HValidator.validateEmail,
                controller: controller.email,
                decoration: const InputDecoration(
                    labelText: HTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right)),
              ),
              const SizedBox(height: HSizes.spaceBtwItems),
              // password
              Obx(() {
                return TextFormField(
                  validator: (value) =>
                      HValidator.validateEmptyText('Password', value),
                  // validator: HValidator.validatePassword,
                  controller: controller.password,
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                    labelText: HTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      icon: controller.hidePassword.value
                          ? const Icon(Iconsax.eye_slash)
                          : const Icon(Iconsax.eye),
                      onPressed: () {
                        controller.hidePassword.value =
                            !controller.hidePassword.value;
                      },
                    ),
                  ),
                );
              }),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              // forget password & remember me
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // remember me
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.remeberMe.value,
                        onChanged: (value) {
                          controller.remeberMe.value = value!;
                        },
                      ),
                    ),
                    const Text(HTexts.rememberMe)
                  ],
                ),
                // forget password
                TextButton(
                    onPressed: () {
                      Get.toNamed(HRoutes.forgotPassword);
                    },
                    child: const Text(HTexts.forgetPassword)),
              ]),
              const SizedBox(height: HSizes.spaceBtwSections),
              // singn in button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.login();
                    // controller.signUpAdmin();
                  },
                  child: const Text(HTexts.signIn),
                ),
              ),
            ],
          )),
    );
  }
}
