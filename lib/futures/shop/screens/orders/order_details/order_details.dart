import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/order_details_desktop.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    return HSiteTemplate(
      desktop: OrderDetailsDesktopScreen(order: order),
    );
  }
}
