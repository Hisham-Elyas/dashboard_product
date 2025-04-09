import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/sidebars/sidebar_controller.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import '../../../../../common/widgets/loaders/circular_loader.dart';
import '../../../../../routes/routes.dart';
import 'responsive_screens/order_details_desktop.dart';
import 'responsive_screens/order_details_mobile.dart';
import 'responsive_screens/order_details_tablet.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    // If order is null, redirect back
    if (order == null) {
      Future.microtask(() {
        Get.offNamedUntil(HRoutes.orders, (route) => false);
        Future.delayed(const Duration(milliseconds: 100), () {
          SidebarController.instance.changeActiveItemTo(HRoutes.orders);
        });
      });

      return const Scaffold(body: Center(child: HCircularLoader()));
    }
    return HSiteTemplate(
      desktop: OrderDetailsDesktopScreen(order: order),
      tablet: OrderDetailsTabletScreen(order: order),
      mobile: OrderDetailsMobileScreen(order: order),
    );
  }
}
