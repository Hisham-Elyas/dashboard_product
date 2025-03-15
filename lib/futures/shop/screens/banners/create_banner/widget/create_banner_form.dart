import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/h_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controller/banners/create_banners_controller.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createBannerController = Get.put(CreateBannerController());
    return HRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Form(
          key: createBannerController.formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // heading
            const SizedBox(height: HSizes.sm),
            Text("Create New Banner",
                style: Theme.of(context).textTheme.headlineLarge),
            // const SizedBox(height: HSizes.spaceBtwItems),

            /// image Uploader & Features Checkboxe
            Column(children: [
              /// image Uploader
              SizedBox(
                width: HSizes.spaceBtwItems,
                height: HSizes.spaceBtwItems,
                child: DropzoneView(
                  mime: const ['image/png', 'image/jpeg', 'image/jpg'],
                  cursor: CursorType.Default,
                  operation: DragOperation.copy,
                  onCreated: (controller) => createBannerController
                      .dropzoneViewController = controller,
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    createBannerController.selectLocalImages();
                  },
                  child: HRoundedImage(
                    width: 400,
                    height: 200,
                    image: createBannerController
                                .image.value.localImageToDisplay ==
                            null
                        ? HImages.defaultImage
                        : null,
                    memoryImage:
                        createBannerController.image.value.localImageToDisplay,
                    backgroundColor: HColors.primaryBackground,
                    imageType: createBannerController
                                .image.value.localImageToDisplay ==
                            null
                        ? ImageType.asset
                        : ImageType.memory,
                  ),
                ),
              ),
              const SizedBox(height: HSizes.spaceBtwItems),
              TextButton(
                  onPressed: () {
                    createBannerController.selectLocalImages();
                  },
                  child: const Text(
                    "Select Image",
                    style: TextStyle(color: HColors.dark),
                  )),
              const SizedBox(height: HSizes.spaceBtwInputFields),
              // name text form field
              TextFormField(
                controller: createBannerController.name,
                validator: (value) =>
                    HValidator.validateEmptyText("Name", value),
                decoration: const InputDecoration(
                    labelText: "Category Name",
                    prefixIcon: Icon(Iconsax.category)),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields),
              Text("Make your banner Active or Inactive",
                  style: Theme.of(context).textTheme.bodyMedium),
              Obx(
                () => CheckboxMenuButton(
                    value: createBannerController.isActive.value,
                    onChanged: (value) =>
                        createBannerController.isActive.value = value ?? false,
                    child: const Text("Active")),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      createBannerController.createBanner();
                    },
                    child: const Text("Create")),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields * 2),
            ])
          ])),
    );
  }
}
