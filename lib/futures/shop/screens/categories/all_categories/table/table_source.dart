import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../../routes/routes.dart';
import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../controller/categories/categories_controller.dart';

class CategoriesRows extends DataTableSource {
  final controller = CategoriesController.instance;
  @override
  DataRow? getRow(int index) {
    final category = controller.filteredItems[index];

    return DataRow2(cells: [
      DataCell(Text(category.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(Get.context!)
              .textTheme
              .bodyLarge!
              .apply(color: HColors.primary))),
      DataCell(category.isActive
          ? const Icon(Iconsax.eye, color: HColors.primary)
          : const Icon(Iconsax.eye_slash)),
      DataCell(HTableActionButtons(
        onEditPressed: () {
          Get.toNamed(HRoutes.editCategories, arguments: category);
        },
        onDeletePressed: () {
          controller.confirmAndDeleteItem(category);
        },
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => 0;
}
