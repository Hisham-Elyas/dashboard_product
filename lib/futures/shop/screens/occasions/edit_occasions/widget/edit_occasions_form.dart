import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class EditOccasionsForm extends StatelessWidget {
  const EditOccasionsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          child: Column(
        children: [
          // heading
          SizedBox(height: TSizes.sm),
          Text("Update Occasions",
              style: Theme.of(context).textTheme.headlineMedium),
          SizedBox(height: TSizes.spaceBtwSections),
          TImageUploader(
            imageType: ImageType.asset,
            image: TImages.defaultImage,
            onIconButtonPressed: () {},
          ),

          SizedBox(height: TSizes.spaceBtwInputFields * 2),

          // name text form field
          TextFormField(
            validator: (value) => TValidator.validateEmptyText("Name", value),
            decoration: const InputDecoration(
                labelText: "Occasions Name",
                prefixIcon: Icon(Iconsax.category)),
          ),

          SizedBox(height: TSizes.spaceBtwInputFields),
          Text("Make your Occasions Active or InActive",
              style: Theme.of(context).textTheme.bodyMedium),
          CheckboxMenuButton(
              value: true, onChanged: (value) {}, child: const Text("Active")),
          SizedBox(height: TSizes.spaceBtwInputFields * 2),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () {}, child: Text("Update")),
          ),
          SizedBox(height: TSizes.spaceBtwInputFields * 2),
        ],
      )),
    );
  }
}
