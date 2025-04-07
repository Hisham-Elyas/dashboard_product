import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../model/orders_model.dart';
import '../widget/customer_Info_order.dart';
import '../widget/order_info.dart';
import '../widget/order_items.dart';
import '../widget/order_transactio.dart';

class OrderDetailsDesktopScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailsDesktopScreen({super.key, required this.order});

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

              // Desktop layout - 3:1 ratio
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side (75% width)
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        OrderInfo(order: order),
                        const SizedBox(height: HSizes.spaceBtwSections),
                        OrderItems(order: order),
                        const SizedBox(height: HSizes.spaceBtwSections),
                        OrderTransactio(order: order),
                      ],
                    ),
                  ),
                  const SizedBox(width: HSizes.spaceBtwSections),

                  // Right side (25% width)
                  Expanded(
                    flex: 1,
                    child: CustomerInfoOrder(order: order),
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
