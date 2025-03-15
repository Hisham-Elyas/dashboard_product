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
import '../../../../controller/occasion/occasion_controller.dart';

class OccasionsRows extends DataTableSource {
  final controller = OccasionController.instance;
  @override
  DataRow? getRow(int index) {
    final occasion = controller.filteredItems[index];
    return DataRow2(cells: [
      DataCell(
        HRoundedImage(
          width: 80,
          height: 80,
          padding: HSizes.sm,
          image: occasion.imageUrl,
          imageType: ImageType.network,
          borderRadius: HSizes.borderRadiusMd,
          backgroundColor: HColors.primaryBackground,
        ),
      ),
      DataCell(Text(occasion.name)),
      DataCell(occasion.isActive
          ? const Icon(Iconsax.eye, color: HColors.primary)
          : const Icon(Iconsax.eye_slash)),
      DataCell(HTableActionButtons(
        onEditPressed: () {
          Get.toNamed(HRoutes.editOccasions, arguments: occasion);
        },
        onDeletePressed: () {
          controller.confirmAndDeleteItem(occasion);
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
