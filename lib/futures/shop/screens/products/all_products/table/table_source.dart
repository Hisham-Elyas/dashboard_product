import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../../routes/routes.dart';
import '../../../../../../../utils/constants/enums.dart';
import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../common/widgets/images/h_rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controller/products/products_controller.dart';

class ProductsRows extends DataTableSource {
  final controller = ProductsController.instance;
  @override
  DataRow? getRow(int index) {
    final product = controller.filteredItems[index];
    return DataRow2(cells: [
      DataCell(Row(
        children: [
          HRoundedImage(
            width: 80,
            height: 80,
            padding: HSizes.sm,
            image: product.imageUrl,
            imageType: ImageType.network,
            borderRadius: HSizes.borderRadiusMd,
            backgroundColor: HColors.primaryBackground,
          ),
          const SizedBox(width: HSizes.spaceBtwItems),
          Expanded(
            child: Text(product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyLarge!
                    .apply(color: HColors.primary)),
          )
        ],
      )),
      DataCell(Text(product.price.toStringAsFixed(2))),
      DataCell(product.isActive
          ? const Icon(Iconsax.eye, color: HColors.primary)
          : const Icon(Iconsax.eye_slash)),
      DataCell(HTableActionButtons(
        onEditPressed: () {
          Get.toNamed(HRoutes.editProducts, arguments: product);
        },
        onDeletePressed: () {
          controller.confirmAndDeleteItem(product);
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
