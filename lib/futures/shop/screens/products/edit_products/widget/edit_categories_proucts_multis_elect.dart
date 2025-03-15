import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controller/categories/categories_controller.dart';
import '../../../../controller/occasion/occasion_controller.dart';
import '../../../../controller/products/edit_product_controller.dart';

class EditCategoriesProuctsMultisElect extends StatelessWidget {
  const EditCategoriesProuctsMultisElect({super.key});

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
        final editProductController = Get.put(EditProductController());
        if (!categoriesController.isLoading.value) {
          editProductController.selectedCategories.value = categoriesController
              .allItems
              .where((category) => editProductController
                  .oldProduct.categoriesIds
                  .contains(category.id))
              .toList();
        }
        if (!occasioncontroller.isLoading.value) {
          editProductController.selectedOccasion.value = occasioncontroller
              .allItems
              .where((category) => editProductController
                  .oldProduct.categoriesIds
                  .contains(category.id))
              .toList();
        }
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
                        initialValue:
                            EditProductController.instance.selectedCategories,
                        items: categoriesController.allItems
                            .map((item) => MultiSelectItem(item, item.name))
                            .toList(),
                        onConfirm: (val) {
                          EditProductController.instance.selectedCategories
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
                        initialValue:
                            EditProductController.instance.selectedOccasion,
                        buttonText: const Text("Select Occasion"),
                        title: const Text("Occasion"),
                        listType: MultiSelectListType.CHIP,
                        items: occasioncontroller.allItems
                            .map((item) => MultiSelectItem(item, item.name))
                            .toList(),
                        onConfirm: (val) {
                          EditProductController.instance.selectedOccasion
                              .assignAll(val);
                          EditProductController.instance.selectedOccasion
                              .refresh();
                        },
                      ),
                      const SizedBox(height: HSizes.spaceBtwItems * 2),
                    ],
                  ),
          ],
        );
      }),
    );
  }
}
