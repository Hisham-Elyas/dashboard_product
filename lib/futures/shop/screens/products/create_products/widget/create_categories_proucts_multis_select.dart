import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../controller/categories/categories_controller.dart';
import '../../../../controller/occasion/occasion_controller.dart';
import '../../../../controller/products/create_product_controller.dart';

class CreateCategoriesProuctsMultisSelect extends StatelessWidget {
  const CreateCategoriesProuctsMultisSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesController = Get.put(CategoriesController());
    final occasioncontroller = Get.put(OccasionController());
    if (categoriesController.allItems.isEmpty) {
      categoriesController.fetchItems();
    }
    if (occasioncontroller.allItems.isEmpty) {
      occasioncontroller.fetchItems();
    }
    return HRoundedContainer(
      child: Obx(() {
        return Column(
          children: [
            categoriesController.isLoading.value
                ? const HShimmerEffect(width: double.infinity, height: 50)
                : Column(
                    children: [
                      Text("Categories",
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: HSizes.spaceBtwItems),
                      MultiSelectDialogField(
                        buttonText: const Text("Select Categories"),
                        title: const Text("Categories"),
                        listType: MultiSelectListType.CHIP,
                        items: categoriesController.allItems
                            .map((item) => MultiSelectItem(item, item.name))
                            .toList(),
                        onConfirm: (val) {
                          CreateProductController.instance.selectedCategories
                              .assignAll(val);
                        },
                      ),
                    ],
                  ),
            const SizedBox(height: HSizes.spaceBtwItems * 2),
            occasioncontroller.isLoading.value
                ? const HShimmerEffect(width: double.infinity, height: 50)
                : Column(
                    children: [
                      Text("Occasion",
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: HSizes.spaceBtwItems),
                      MultiSelectDialogField(
                        buttonText: const Text("Select Occasion"),
                        title: const Text("Occasion"),
                        listType: MultiSelectListType.CHIP,
                        items: occasioncontroller.allItems
                            .map((item) => MultiSelectItem(item, item.name))
                            .toList(),
                        onConfirm: (val) {
                          CreateProductController.instance.selectedOccasion
                              .assignAll(val);
                        },
                      ),
                    ],
                  ),
            const SizedBox(height: HSizes.spaceBtwInputFields * 2),
            if (!HDeviceUtils.isDesktopScreen(context)) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      CreateProductController.instance.createProduct();
                    },
                    child: const Text("Create")),
              ),
              const SizedBox(height: HSizes.spaceBtwInputFields * 2),
            ]
          ],
        );
      }),
    );
  }
}
