import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_dashboard_store/utils/constants/sizes.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../controller/orders/orders_controller.dart';

class OrderStatusFilter extends StatelessWidget {
  const OrderStatusFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrdersController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Filter by Delivery",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: HSizes.spaceBtwItems),
                Wrap(
                  spacing: 8,
                  children: DeliveryMethod.values.map((method) {
                    final isSelected =
                        controller.selectedDeliveryMethod.value == method;
                    return ChoiceChip(
                      label: Text(method.nameFormatted),
                      selected: isSelected,
                      onSelected: (_) => controller.updateDeliveryMethodFilter(
                          isSelected ? null : method),
                    );
                  }).toList(),
                ),
              ],
            )),
        const SizedBox(height: HSizes.spaceBtwItems),
        MultiSelectChipField<OrderStatus?>(
          title: Text(
            "Filter by Status",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          items: controller.statusItems,
          headerColor: Colors.transparent,
          decoration: BoxDecoration(
            border: Border.all(width: 0, color: Colors.transparent),
          ),
          initialValue: controller.selectedStatuses,
          onTap: (List<OrderStatus?>? values) {
            controller.updateStatusFilters(
              values?.whereType<OrderStatus>().toList() ?? [],
            );
          },
          selectedChipColor: Theme.of(context).primaryColor,
          selectedTextStyle: const TextStyle(color: Colors.white),
          scroll: false,
          chipShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
