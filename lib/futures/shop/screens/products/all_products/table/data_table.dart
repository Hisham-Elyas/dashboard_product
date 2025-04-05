import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../controller/products/products_controller.dart';
import 'table_source.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      return HPaginatedDataTable(
        minWidth: 700,
        emptyShowAction: true,
        emptyOnActionPressed: () async {
          await controller.fetchData();
        },
        // tableHeight: 900,
        // dataRowHeight: 110,
        columns: const [
          DataColumn2(label: Text('Products')),
          DataColumn2(label: Text('Price')),
          DataColumn2(label: Text('Available')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: ProductsRows(),
      );
    });
  }
}
