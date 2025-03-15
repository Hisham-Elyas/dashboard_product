import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controller/categories/create_category_controller.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createCategoryController = Get.put(CreateCategoryController());
    return HRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Form(
          key: createCategoryController.formKey,
          child: Column(
            children: [
              // heading
              const SizedBox(height: HSizes.sm),
              Text("Create New Category",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: HSizes.spaceBtwSections),

              // name text form field
              TextFormField(
                controller: createCategoryController.name,
                validator: (value) =>
                    HValidator.validateEmptyText("Name", value),
                decoration: const InputDecoration(
                    labelText: "Category Name",
                    prefixIcon: Icon(Iconsax.category)),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields),
              Text("Make your Category Active or InActive",
                  style: Theme.of(context).textTheme.bodyMedium),
              Obx(
                () => CheckboxMenuButton(
                    value: createCategoryController.isActive.value,
                    onChanged: (value) => createCategoryController
                        .isActive.value = value ?? false,
                    child: const Text("Active")),
              ),

              const SizedBox(height: HSizes.spaceBtwInputFields * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      createCategoryController.createCategory();
                    },
                    child: const Text("Create")),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields * 2),
            ],
          )),
    );
  }
}
