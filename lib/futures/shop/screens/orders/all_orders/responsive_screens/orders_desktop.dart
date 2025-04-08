import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controller/orders/orders_controller.dart';
import '../table/data_table.dart';
import '../widget/order_status_filter.dart';

class OrdersDesktopScreen extends StatelessWidget {
  const OrdersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HBreadcrumbsWithHeading(
                  heading: "Orders",
                  breadcrumbsItems: [" Orders"],
                ),
                const SizedBox(height: HSizes.spaceBtwItems),
                HRoundedContainer(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: HSizes.spaceBtwItems),

                        ///  Table Header
                        HTableHeader(
                          searchController: controller.searchTextController,
                          searchOnChanged: (query) =>
                              controller.searchQuery(query),
                        ),
                        const SizedBox(height: HSizes.spaceBtwItems),

                        ///  Orders Table
                        Obx(
                          () {
                            if (controller.isLoading.value) {
                              return const HLoaderAnimation();
                            }
                            return const Column(
                              children: [
                                OrderStatusFilter(),
                                SizedBox(height: HSizes.spaceBtwItems),
                                OrdersTable(),
                              ],
                            );
                          },
                        )
                      ]),
                ),
              ],
            )),
      ),
    );
  }
}
