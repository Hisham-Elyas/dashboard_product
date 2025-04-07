import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../model/orders_model.dart';
import '../widget/customer_Info_order.dart';
import '../widget/order_info.dart';
import '../widget/order_items.dart';
import '../widget/order_transactio.dart';

class OrderDetailsMobileScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailsMobileScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HSizes.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: "Order Details",
                breadcrumbsItems: [HRoutes.orders, "Order Details"],
              ),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Customer Info (moved to top for mobile)
              CustomerInfoOrder(order: order),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Order Info
              OrderInfo(order: order),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Order Items
              OrderItems(order: order),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Order Transaction
              OrderTransactio(order: order),
            ],
          ),
        ),
      ),
    );
  }
}
