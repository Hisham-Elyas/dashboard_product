import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controller/dashboard/dashboard_controller.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return HRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order Distribution",
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: HSizes.spaceBtwItems),
          SizedBox(
            height: 345,
            child: Obx(() => PieChart(
                  PieChartData(
                    sections: controller.orderStatusCount.entries.map((entry) {
                      final status = entry.key;
                      final count = entry.value;
                      final percentage =
                          (count / controller.orders.length * 100)
                              .toStringAsFixed(1);
                      return PieChartSectionData(
                        title: "$percentage%",
                        value: count.toDouble(),
                        color: HHelperFunctions.getOrderStatusColor(status),
                        radius: 60,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
                    sectionsSpace: 2,
                    centerSpaceRadius: 50,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
