import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_dashboard_store/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controller/dashboard/dashboard_controller.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    return HRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Orders",
                  style: Theme.of(context).textTheme.headlineSmall),
              TextButton(
                onPressed: () => controller.refreshData(),
                child: const Text("Refresh"),
              ),
            ],
          ),
          const SizedBox(height: HSizes.spaceBtwItems),
          Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.orders.take(5).length,
                itemBuilder: (context, index) {
                  final order = controller.orders[index];
                  return ListTile(
                    leading: Text("#${order.id}"),
                    title: Text(
                        HHelperFunctions.formatCurrency(order.totalAmount)),
                    subtitle: Text(order.orderStatus.name.capitalize!),
                    trailing: Chip(
                      label: Text(order.paymentMethod),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
