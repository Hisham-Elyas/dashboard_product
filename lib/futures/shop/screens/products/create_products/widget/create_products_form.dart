import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class CreateProductsForm extends StatelessWidget {
  const CreateProductsForm({super.key});

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
          Text("Create New Products",
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSections),
          TImageUploader(
            imageType: ImageType.asset,
            image: TImages.defaultImage,
            onIconButtonPressed: () {},
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields * 2),

          // name text form field
          TextFormField(
            validator: (value) => TValidator.validateEmptyText("Name", value),
            decoration: const InputDecoration(
                labelText: "Products Name", prefixIcon: Icon(Iconsax.category)),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),
          Text("Make your Products Available or not",
              style: Theme.of(context).textTheme.bodyMedium),
          CheckboxMenuButton(
              value: true,
              onChanged: (value) {},
              child: const Text("Available")),
          const SizedBox(height: TSizes.spaceBtwInputFields * 2),

          SizedBox(
            width: double.infinity,
            child:
                ElevatedButton(onPressed: () {}, child: const Text("Create")),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields * 2),
        ],
      )),
    );
  }
}
