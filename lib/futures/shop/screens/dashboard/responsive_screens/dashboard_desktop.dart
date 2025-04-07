// dashboard_desktop_screen.dart
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

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HBreadcrumbsWithHeading(
                heading: "Overview",
                breadcrumbsItems: [],
              ),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Overview Cards
              _buildOverviewSection(),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Time Period Totals
              _buildTimePeriodTotals(context),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Charts and Data Section
              _buildChartsSection(),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Recent Orders Section
              _buildRecentOrdersSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewSection() {
    final controller = DashboardController.instance;

    return Column(
      children: [
        Row(
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
            const SizedBox(width: HSizes.spaceBtwItems),
            Expanded(
              child: OverviewCard(
                title: "Avg. Order",
                value: "${controller.averageOrderValue.toStringAsFixed(2)} ﷼",
                icon: Iconsax.chart,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: HSizes.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: MiniStatCard(
                title: "Delivered",
                value: controller.deliveredCount.toString(),
                color:
                    HHelperFunctions.getOrderStatusColor(OrderStatus.delivered),
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
      ],
    );
  }

  Widget _buildTimePeriodTotals(BuildContext context) {
    final controller = DashboardController.instance;

    return HRoundedContainer(
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Revenue Overview",
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: HSizes.spaceBtwItems),
          Row(
            children: [
              Expanded(
                child: TimePeriodCard(
                  color: Colors.blue,
                  title: "Today",
                  amount: controller.todayOrders
                      .fold(0.0, (sum, order) => sum + order.totalAmount),
                  icon: Iconsax.calendar_1,
                ),
              ),
              const SizedBox(width: HSizes.spaceBtwItems),
              Expanded(
                child: TimePeriodCard(
                  color: Colors.green,
                  title: "This Month",
                  amount: controller.thisMonthOrders
                      .fold(0.0, (sum, order) => sum + order.totalAmount),
                  icon: Iconsax.calendar_tick,
                ),
              ),
              const SizedBox(width: HSizes.spaceBtwItems),
              Expanded(
                child: TimePeriodCard(
                  color: Colors.orange,
                  title: "Last Month",
                  amount: controller.lastMonthOrders
                      .fold(0.0, (sum, order) => sum + order.totalAmount),
                  icon: Iconsax.calendar_1,
                ),
              ),
              const SizedBox(width: HSizes.spaceBtwItems),
              Expanded(
                child: TimePeriodCard(
                  color: Colors.purple,
                  title: "This Year",
                  amount: controller.thisYearOrders
                      .fold(0.0, (sum, order) => sum + order.totalAmount),
                  icon: Iconsax.calendar_tick,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pie Chart
        Expanded(
          flex: 2,
          child: MyPieChart(),
        ),
        SizedBox(width: HSizes.spaceBtwItems),

        // Order Status Table
        Expanded(
          flex: 3,
          child: StatusOrderTable(),
        ),
      ],
    );
  }

  Widget _buildRecentOrdersSection() {
    return const RecentOrders();
  }
}
