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
import '../../../../controller/occasion/create_occasion_controller.dart';

class CreateOccasionsForm extends StatelessWidget {
  const CreateOccasionsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateOccasionController());
    return HRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Form(
          key: createController.formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // heading
            const SizedBox(height: HSizes.sm),
            Text("Create New Occasion",
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
                  onCreated: (controller) =>
                      createController.dropzoneViewController = controller,
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    createController.selectLocalImages();
                  },
                  child: HRoundedImage(
                    width: 400,
                    height: 200,
                    image:
                        createController.image.value.localImageToDisplay == null
                            ? HImages.defaultImage
                            : null,
                    memoryImage:
                        createController.image.value.localImageToDisplay,
                    backgroundColor: HColors.primaryBackground,
                    imageType:
                        createController.image.value.localImageToDisplay == null
                            ? ImageType.asset
                            : ImageType.memory,
                  ),
                ),
              ),
              const SizedBox(height: HSizes.spaceBtwItems),
              TextButton(
                  onPressed: () {
                    createController.selectLocalImages();
                  },
                  child: const Text(
                    "Select Image",
                    style: TextStyle(color: HColors.dark),
                  )),
              const SizedBox(height: HSizes.spaceBtwInputFields),
              // name text form field
              TextFormField(
                controller: createController.name,
                validator: (value) =>
                    HValidator.validateEmptyText("Name", value),
                decoration: const InputDecoration(
                    labelText: "Occasion Name",
                    prefixIcon: Icon(Iconsax.category)),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields),
              Text("Make your banner Active or Inactive",
                  style: Theme.of(context).textTheme.bodyMedium),
              Obx(
                () => CheckboxMenuButton(
                    value: createController.isActive.value,
                    onChanged: (value) =>
                        createController.isActive.value = value ?? false,
                    child: const Text("Active")),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      createController.createoOccasion();
                    },
                    child: const Text("Create")),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields * 2),
            ])
          ])),
    );
  }
}
