import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/h_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controller/banners/edit_banners_controller.dart';
import '../../../../model/banners_model.dart';

class EditBannerForm extends StatelessWidget {
  final BannersModel banners;
  const EditBannerForm({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    final editBannersController = Get.put(EditBannersController());
    editBannersController.inIt(banners);
    return HRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Form(
          key: editBannersController.formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // heading
            const SizedBox(height: HSizes.sm),
            Text("Update Banner",
                style: Theme.of(context).textTheme.headlineLarge),
            // const SizedBox(height: HSizes.spaceBtwItems),

            /// image Uploader & Features Checkboxe
            Column(children: [
              SizedBox(
                width: HSizes.spaceBtwItems,
                height: HSizes.spaceBtwItems,
                child: DropzoneView(
                  mime: const ['image/png', 'image/jpeg', 'image/jpg'],
                  cursor: CursorType.Default,
                  operation: DragOperation.copy,
                  onCreated: (controller) =>
                      editBannersController.dropzoneViewController = controller,
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    editBannersController.selectLocalImages();
                  },
                  child: HRoundedImage(
                    width: 400,
                    height: 200,
                    image: editBannersController.isImageUpdated.value
                        ? null
                        : banners.imageUrl,
                    memoryImage:
                        editBannersController.image.value.localImageToDisplay,
                    backgroundColor: HColors.primaryBackground,
                    imageType: editBannersController.isImageUpdated.value
                        ? ImageType.memory
                        : ImageType.network,
                  ),
                ),
              ),
              const SizedBox(height: HSizes.spaceBtwItems),
              TextButton(
                  onPressed: () {
                    editBannersController.selectLocalImages();
                  },
                  child: const Text(
                    "Select Image",
                    style: TextStyle(color: HColors.dark),
                  )),
              const SizedBox(height: HSizes.spaceBtwInputFields),
              // name text form field
              TextFormField(
                controller: editBannersController.name,
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
                    value: editBannersController.isActive.value,
                    onChanged: (value) =>
                        editBannersController.isActive.value = value ?? false,
                    child: const Text("Active")),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      editBannersController.updateBanners(banners);
                    },
                    child: const Text("Update")),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields * 2),
            ])
          ])),
    );
  }
}
