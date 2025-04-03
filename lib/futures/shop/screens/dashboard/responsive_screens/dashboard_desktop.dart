import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_dashboard_store/common/widgets/containers/circular_container.dart';
import 'package:h_dashboard_store/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controller/dashboard/dashboard_controller.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HPageHeading(heading: "Dashboard"),
                const SizedBox(height: HSizes.spaceBtwItems),
                HRoundedContainer(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order Status",
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: HSizes.spaceBtwItems),
                        // Graph
                        SizedBox(
                          height: 400,
                          child: PieChart(PieChartData(
                            sections: controller.orderStatusCount.entries
                                .map((entry) {
                              final status = entry.key;
                              final count = entry.value;
                              return PieChartSectionData(
                                title: count.toString(),
                                value: count.toDouble(),
                                color: HHelperFunctions.getOrderStatusColor(
                                    status),
                                radius: 100,
                                titleStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              );
                            }).toList(),
                          )),
                        ),

                        const SizedBox(height: HSizes.spaceBtwItems),
                        SizedBox(
                          width: double.infinity,
                          child: DataTable(
                              columns: [
                                DataColumn(
                                    label: Text("Status",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall)),
                                DataColumn(
                                    label: Text("Orders",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall)),
                                DataColumn(
                                    label: Text("Total",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall)),
                              ],
                              rows: controller.orderStatusCount.entries
                                  .map((entry) {
                                final status = entry.key;
                                final count = entry.value;
                                final totalAmount =
                                    controller.totalAmount[status] ?? 0;
                                return DataRow(cells: [
                                  DataCell(Row(
                                    children: [
                                      HCircularContainer(
                                        width: 20,
                                        height: 20,
                                        backgroundColor: HHelperFunctions
                                            .getOrderStatusColor(status),
                                      ),
                                      Expanded(child: Text(" ${status.name}")),
                                    ],
                                  )),
                                  DataCell(Text(count.toString())),
                                  DataCell(Text(
                                      "${totalAmount.toStringAsFixed(2)} ﷼")),
                                ]);
                              }).toList()),
                        )
                      ]),
                ),
              ],
            )),
      ),
    );
  }
}
