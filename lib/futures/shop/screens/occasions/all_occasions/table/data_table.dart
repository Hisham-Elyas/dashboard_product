import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import 'table_source.dart';

class OccasionsTable extends StatelessWidget {
  const OccasionsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      // tableHeight: 900,
      // dataRowHeight: 110,
      columns: const [
        DataColumn2(label: Text('Occasions')),
        DataColumn2(label: Text('Active')),
        DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: OccasionsRows(),
    );
  }
}
