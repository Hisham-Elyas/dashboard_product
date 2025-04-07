import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_dashboard_store/common/widgets/containers/rounded_container.dart';
import 'package:h_dashboard_store/utils/constants/enums.dart';
import 'package:h_dashboard_store/utils/constants/sizes.dart';
import 'package:h_dashboard_store/utils/device/device_utility.dart';
import 'package:h_dashboard_store/utils/helpers/helper_functions.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../controller/orders/orders_controller.dart';
import '../../../../model/orders_model.dart';

class OrderInfo extends StatelessWidget {
  final OrderModel order;
  const OrderInfo({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());
    controller.orderStatus.value = order.orderStatus;
    return HRoundedContainer(
        padding: const EdgeInsets.all(HSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Infomation",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: HSizes.spaceBtwSections),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date'),
                    Text(HHelperFunctions.getFormattedDate(order.createdAt!),
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                )),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Item'),
                    Text("${order.item.length} item",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                )),
                Expanded(
                    flex: HDeviceUtils.isMobileScreen(context) ? 2 : 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Status'),
                        Obx(
                          () => Skeletonizer(
                            enabled: controller.statusLoader.value,
                            child: HRoundedContainer(
                              radius: HSizes.cardRadiusSm,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: HSizes.md),
                              backgroundColor:
                                  HHelperFunctions.getOrderStatusColor(
                                          controller.orderStatus.value)
                                      .withOpacity(0.1),
                              child: DropdownButton<OrderStatus>(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                value: controller.orderStatus.value,
                                onChanged: (OrderStatus? newVal) {
                                  if (newVal == null) return;
                                  controller.updateOrderStatus(order, newVal);
                                },
                                items: OrderStatus.values
                                    .map((OrderStatus status) {
                                  return DropdownMenuItem<OrderStatus>(
                                    value: status,
                                    child: Text(
                                      status.name.capitalize.toString(),
                                      style: TextStyle(
                                          color: HHelperFunctions
                                              .getOrderStatusColor(status)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Amount'),
                    Text("${order.totalAmount} ﷼",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                )),
              ],
            ),
          ],
        ));
  }
}
