import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../model/orders_model.dart';
import '../widget/customer_Info_order.dart';
import '../widget/order_info.dart';
import '../widget/order_items.dart';
import 'order_transactio.dart';

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
                // body
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// left side order info
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            /// order info
                            OrderInfo(order: order),
                            const SizedBox(height: HSizes.spaceBtwSections),

                            /// Order Items
                            OrderItems(order: order),
                            const SizedBox(height: HSizes.spaceBtwSections),

                            /// Order Transactio

                            OrderTransactio(order: order)
                          ],
                        ))
                  ],
                ),

                Expanded(
                    child: Column(
                  children: [
                    /// Customer Info
                    CustomerInfoOrder(order: order),
                    const SizedBox(height: HSizes.spaceBtwSections),
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
