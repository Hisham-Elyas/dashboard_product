import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../controller/categories/categories_controller.dart';
import 'table_source.dart';

class CategoriesTable extends StatelessWidget {
  const CategoriesTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());
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
          DataColumn2(label: Text('Category')),
          DataColumn2(label: Text('Active')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: CategoriesRows(),
      );
    });
  }
}
