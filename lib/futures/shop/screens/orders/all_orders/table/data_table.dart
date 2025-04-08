import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../controller/orders/orders_controller.dart';
import 'table_source.dart';

class OrdersTable extends StatelessWidget {
  const OrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      return HPaginatedDataTable(
        emptyShowAction: false,
        emptyOnActionPressed: () async {
          await controller.fetchData();
        },

        minWidth: 700,
        // tableHeight: 900,
        // dataRowHeight: 110,
        columns: const [
          DataColumn2(label: Text('Orders Id')),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Order Status')),
          DataColumn2(label: Text('item')),
          DataColumn2(label: Text('Totall')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: OrdersRows(),
      );
    });
  }
}
