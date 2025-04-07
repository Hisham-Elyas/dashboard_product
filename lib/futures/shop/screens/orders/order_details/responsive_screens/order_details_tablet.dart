import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../model/orders_model.dart';
import '../widget/customer_Info_order.dart';
import '../widget/order_info.dart';
import '../widget/order_items.dart';
import '../widget/order_transactio.dart';

class OrderDetailsTabletScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailsTabletScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: "Order Details",
                breadcrumbsItems: [HRoutes.orders, "Order Details"],
              ),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Tablet layout - 2 columns
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left column (order details)
                  Expanded(
                    child: Column(
                      children: [
                        OrderInfo(order: order),
                        const SizedBox(height: HSizes.spaceBtwSections),
                        OrderItems(order: order),
                      ],
                    ),
                  ),
                  const SizedBox(width: HSizes.spaceBtwSections),

                  // Right column (customer info + transaction)
                  Expanded(
                    child: Column(
                      children: [
                        CustomerInfoOrder(order: order),
                        const SizedBox(height: HSizes.spaceBtwSections),
                        OrderTransactio(order: order),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
