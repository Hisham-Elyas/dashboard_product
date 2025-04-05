import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../controller/orders/orders_controller.dart';

class OrdersRows extends DataTableSource {
  final controller = OrdersController.instance;
  @override
  DataRow? getRow(int index) {
    final order = controller.filteredItems[index];
    return DataRow2(cells: [
      DataCell(Text(order.id)),
      DataCell(Text(HHelperFunctions.getFormattedDate(order.createdAt!))),
      DataCell(HRoundedContainer(
        radius: HSizes.cardRadiusSm,
        padding: const EdgeInsets.symmetric(
            vertical: HSizes.sm, horizontal: HSizes.md),
        backgroundColor: HHelperFunctions.getOrderStatusColor(order.orderStatus)
            .withOpacity(0.1),
        child: Text(
          order.orderStatus.name.capitalize.toString(),
          style: TextStyle(
              color: HHelperFunctions.getOrderStatusColor(order.orderStatus)),
        ),
      )),
      DataCell(Text("${order.item.length} item")),
      DataCell(Text("${order.totalAmount} ﷼")),
      DataCell(HTableActionButtons(
        view: true,
        edit: false,
        onViewPressed: () {},
        onDeletePressed: () {
          // controller.confirmAndDeleteItem(order);
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
