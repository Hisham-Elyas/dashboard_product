// dashboard_tablet_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controller/dashboard/dashboard_controller.dart';
import '../widget/mini_stat_card.dart';
import '../widget/overview_card.dart';
import '../widget/pie_chart.dart';
import '../widget/recent_orders.dart';
import '../widget/status_order_table.dart';
import '../widget/time_period_card.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(HSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HPageHeading(
                      heading: "Overview",
                    ),
                    const SizedBox(height: HSizes.spaceBtwSections),

                    // Overview Cards - 2 columns for tablet
                    _buildOverviewSection(),
                    const SizedBox(height: HSizes.spaceBtwSections),

                    // Time Period Totals - 2 columns
                    _buildTimePeriodTotals(context),
                    const SizedBox(height: HSizes.spaceBtwSections),

                    // Charts and Data Section - Vertical layout
                    _buildChartsSection(),
                    const SizedBox(height: HSizes.spaceBtwSections),

                    // Recent Orders Section
                    const RecentOrders(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverviewSection() {
    final controller = DashboardController.instance;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: OverviewCard(
                  title: "Total Orders",
                  value: controller.orders.length.toString(),
                  icon: Iconsax.shopping_cart,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: HSizes.spaceBtwItems),
              Expanded(
                child: OverviewCard(
                  title: "Total Revenue",
                  value: "${controller.totalRevenue.toStringAsFixed(2)} ﷼",
                  icon: Iconsax.money,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: HSizes.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: OverviewCard(
            title: "Avg. Order",
            value: "${controller.averageOrderValue.toStringAsFixed(2)} ﷼",
            icon: Iconsax.chart,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: HSizes.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: MiniStatCard(
                  title: "Delivered",
                  value: controller.deliveredCount.toString(),
                  color: HHelperFunctions.getOrderStatusColor(
                      OrderStatus.delivered),
                ),
              ),
              const SizedBox(width: HSizes.spaceBtwItems),
              Expanded(
                child: MiniStatCard(
                  title: "Processing",
                  value: controller.processingCount.toString(),
                  color: HHelperFunctions.getOrderStatusColor(
                      OrderStatus.processing),
                ),
              ),
              const SizedBox(width: HSizes.spaceBtwItems),
              Expanded(
                child: MiniStatCard(
                  title: "Pending",
                  value: controller.pendingCount.toString(),
                  color:
                      HHelperFunctions.getOrderStatusColor(OrderStatus.pending),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimePeriodTotals(BuildContext context) {
    final controller = DashboardController.instance;

    return SizedBox(
      width: double.infinity,
      child: HRoundedContainer(
        padding: const EdgeInsets.all(HSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Revenue Overview",
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: HSizes.spaceBtwItems),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: TimePeriodCard(
                          color: Colors.blue,
                          title: "Today",
                          amount: controller.todayOrders.fold(
                              0.0, (sum, order) => sum + order.totalAmount),
                          icon: Iconsax.calendar_1,
                        ),
                      ),
                      const SizedBox(width: HSizes.spaceBtwItems),
                      Expanded(
                        child: TimePeriodCard(
                          color: Colors.green,
                          title: "This Month",
                          amount: controller.thisMonthOrders.fold(
                              0.0, (sum, order) => sum + order.totalAmount),
                          icon: Iconsax.calendar_tick,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: HSizes.spaceBtwItems),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: TimePeriodCard(
                          color: Colors.orange,
                          title: "Last Month",
                          amount: controller.lastMonthOrders.fold(
                              0.0, (sum, order) => sum + order.totalAmount),
                          icon: Iconsax.calendar_1,
                        ),
                      ),
                      const SizedBox(width: HSizes.spaceBtwItems),
                      Expanded(
                        child: TimePeriodCard(
                          color: Colors.purple,
                          title: "This Year",
                          amount: controller.thisYearOrders.fold(
                              0.0, (sum, order) => sum + order.totalAmount),
                          icon: Iconsax.calendar_tick,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartsSection() {
    return const Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MyPieChart(),
        ),
        SizedBox(height: HSizes.spaceBtwSections),
        SizedBox(
          width: double.infinity,
          child: StatusOrderTable(),
        ),
      ],
    );
  }
}
