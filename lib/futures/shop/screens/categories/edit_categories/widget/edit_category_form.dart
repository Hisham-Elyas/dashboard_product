import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          child: Column(
        children: [
          // heading
          const SizedBox(height: TSizes.sm),
          Text("Update Category",
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSections),

          // name text form field
          TextFormField(
            validator: (value) => TValidator.validateEmptyText("Name", value),
            decoration: const InputDecoration(
                labelText: "Category Name", prefixIcon: Icon(Iconsax.category)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Text("Make your Category Active or InActive",
              style: Theme.of(context).textTheme.bodyMedium),
          CheckboxMenuButton(
              value: true, onChanged: (value) {}, child: const Text("Active")),

          const SizedBox(height: TSizes.spaceBtwInputFields * 2),
          SizedBox(
            width: double.infinity,
            child:
                ElevatedButton(onPressed: () {}, child: const Text("Update")),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields * 2),
        ],
      )),
    );
  }
}
