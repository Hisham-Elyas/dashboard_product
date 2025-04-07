import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_dashboard_store/utils/device/device_utility.dart';

import '../../../../../common/widgets/containers/circular_container.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controller/dashboard/dashboard_controller.dart';

class StatusOrderTable extends StatelessWidget {
  const StatusOrderTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    return HRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order Details",
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: HSizes.spaceBtwItems),
          Obx(() => SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: [
                    DataColumn(
                        label: Text("Status",
                            style: Theme.of(context).textTheme.titleMedium)),
                    DataColumn(
                        label: Text("Count",
                            style: Theme.of(context).textTheme.titleMedium)),
                    DataColumn(
                        label: Text("Amount",
                            style: Theme.of(context).textTheme.titleMedium)),
                    if (!HDeviceUtils.isMobileScreen(context))
                      DataColumn(
                          label: Text("%",
                              style: Theme.of(context).textTheme.titleMedium)),
                  ],
                  rows: controller.orderStatusCount.entries.map((entry) {
                    final status = entry.key;
                    final count = entry.value;
                    final amount = controller.totalAmount[status] ?? 0;
                    final percentage = (count / controller.orders.length * 100)
                        .toStringAsFixed(1);
                    return DataRow(cells: [
                      DataCell(Row(
                        children: [
                          HCircularContainer(
                            width: 12,
                            height: 12,
                            backgroundColor:
                                HHelperFunctions.getOrderStatusColor(status),
                          ),
                          const SizedBox(width: HSizes.sm),
                          Text(status.name.capitalize!),
                        ],
                      )),
                      DataCell(Text(count.toString())),
                      DataCell(Text("${amount.toStringAsFixed(2)} ﷼")),
                      if (!HDeviceUtils.isMobileScreen(context))
                        DataCell(Text("$percentage%")),
                    ]);
                  }).toList(),
                ),
              )),
        ],
      ),
    );
  }
}
