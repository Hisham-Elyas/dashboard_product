import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../common/widgets/images/h_rounded_image.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controller/banners/banners_controller.dart';

class BannersRows extends DataTableSource {
  final controller = BannersController.instance;
  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];
    return DataRow2(cells: [
      DataCell(HRoundedImage(
        width: 180,
        height: 100,
        padding: HSizes.sm,
        image: banner.imageUrl,
        imageType: ImageType.network,
        borderRadius: HSizes.borderRadiusMd,
        backgroundColor: HColors.primaryBackground,
      )),
      DataCell(Text(banner.name)),
      DataCell(banner.isActive
          ? const Icon(Iconsax.eye, color: HColors.primary)
          : const Icon(Iconsax.eye_slash)),
      DataCell(HTableActionButtons(
        onEditPressed: () {
          Get.toNamed(HRoutes.editBanner, arguments: banner);
        },
        onDeletePressed: () {
          controller.confirmAndDeleteItem(banner);
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
