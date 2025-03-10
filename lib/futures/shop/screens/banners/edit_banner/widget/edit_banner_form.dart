import 'package:flutter/material.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // heading
        SizedBox(height: TSizes.sm),
        Text("Update Banner", style: Theme.of(context).textTheme.headlineLarge),
        SizedBox(height: TSizes.spaceBtwItems),

        /// image Uploader & Features Checkboxe
        Column(children: [
          GestureDetector(
            onTap: () {},
            child: TRoundedImage(
              width: 400,
              height: 200,
              image: TImages.defaultImage,
              backgroundColor: TColors.primaryBackground,
              imageType: ImageType.asset,
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          TextButton(
              onPressed: () {},
              child: Text(
                "Select Image",
                style: TextStyle(color: TColors.dark),
              )),
          SizedBox(height: TSizes.spaceBtwInputFields),
          Text("Make your banner Active or Inactive",
              style: Theme.of(context).textTheme.bodyMedium),
          CheckboxMenuButton(
              value: true, onChanged: (value) {}, child: const Text("Active")),
          SizedBox(height: TSizes.spaceBtwInputFields * 2),
          SizedBox(
            width: double.infinity,
            child:
                ElevatedButton(onPressed: () {}, child: const Text("Update")),
          ),
          SizedBox(height: TSizes.spaceBtwInputFields * 2),
        ])
      ])),
    );
  }
}
