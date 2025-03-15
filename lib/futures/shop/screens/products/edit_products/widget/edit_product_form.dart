import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/h_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controller/products/edit_product_controller.dart';
import '../../../../model/products_model.dart';

class EditProductForm extends StatelessWidget {
  final ProductsModel products;
  const EditProductForm({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditProductController());
    editController.inIt(products);
    return HRoundedContainer(
      // width: 500,
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Form(
          key: editController.formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // heading
            const SizedBox(height: HSizes.sm),
            Text("Update Product",
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
                      editController.dropzoneViewController = controller,
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    editController.selectLocalImages();
                  },
                  child: HRoundedImage(
                    width: 400,
                    height: 200,
                    image: editController.isImageUpdated.value
                        ? null
                        : products.imageUrl,
                    memoryImage: editController.image.value.localImageToDisplay,
                    backgroundColor: HColors.primaryBackground,
                    imageType: editController.isImageUpdated.value
                        ? ImageType.memory
                        : ImageType.network,
                  ),
                ),
              ),
              const SizedBox(height: HSizes.spaceBtwItems),
              TextButton(
                  onPressed: () {
                    editController.selectLocalImages();
                  },
                  child: const Text(
                    "Select Image",
                    style: TextStyle(color: HColors.dark),
                  )),
              const SizedBox(height: HSizes.spaceBtwInputFields),
              // name text form field
              TextFormField(
                controller: editController.name,
                validator: (value) =>
                    HValidator.validateEmptyText("Name", value),
                decoration: const InputDecoration(
                    labelText: "Product Name",
                    prefixIcon: Icon(Iconsax.category)),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields),
              // price text form field
              TextFormField(
                controller: editController.price,
                validator: (value) =>
                    HValidator.validateEmptyText("Price", value),
                decoration: const InputDecoration(
                    labelText: "Product Price",
                    prefixIcon: Icon(Iconsax.category)),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields),
              // detail text form field
              TextFormField(
                controller: editController.detail,
                maxLines: 3,
                validator: (value) =>
                    HValidator.validateEmptyText("Detail", value),
                decoration: const InputDecoration(
                    labelText: "Product Detail",
                    prefixIcon: Icon(Iconsax.category)),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields),
              Text("Make your banner Active or Inactive",
                  style: Theme.of(context).textTheme.bodyMedium),
              Obx(
                () => CheckboxMenuButton(
                    value: editController.isActive.value,
                    onChanged: (value) =>
                        editController.isActive.value = value ?? false,
                    child: const Text("Active")),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields * 2),
              if (HDeviceUtils.isDesktopScreen(context)) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        editController.updateProduct(products);
                      },
                      child: const Text("Update")),
                ),
                const SizedBox(height: HSizes.spaceBtwInputFields * 2),
              ]
            ])
          ])),
    );
  }
}
