// dashboard_desktop_screen.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../common/widgets/containers/circular_container.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controller/dashboard/dashboard_controller.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    final dark = HHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: "Dashboard",
                breadcrumbsItems: [],
              ),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Overview Cards
              _buildOverviewSection(context, controller, dark),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Time Period Totals
              _buildTimePeriodTotals(context, controller),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Charts and Data Section
              _buildChartsSection(context, controller, dark),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Bar Chart Section
              _buildBarChartSection(context, controller),
              const SizedBox(height: HSizes.spaceBtwSections),

              // Recent Orders Section
              _buildRecentOrdersSection(context, controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewSection(
      BuildContext context, DashboardController controller, bool dark) {
    return Column(
      children: [
        Row(
          children: [
            _buildOverviewCard(
              context: context,
              title: "Total Orders",
              value: controller.orders.length.toString(),
              icon: Iconsax.shopping_cart,
              color: Colors.blue,
            ),
            const SizedBox(width: HSizes.spaceBtwItems),
            _buildOverviewCard(
              context: context,
              title: "Total Revenue",
              value: "${controller.totalRevenue.toStringAsFixed(2)} ﷼",
              icon: Iconsax.money,
              color: Colors.green,
            ),
            const SizedBox(width: HSizes.spaceBtwItems),
            _buildOverviewCard(
              context: context,
              title: "Avg. Order",
              value: "${controller.averageOrderValue.toStringAsFixed(2)} ﷼",
              icon: Iconsax.chart,
              color: Colors.orange,
            ),
          ],
        ),
        const SizedBox(height: HSizes.spaceBtwItems),
        Row(
          children: [
            _buildMiniStatCard(
              context: context,
              title: "Delivered",
              value: controller.deliveredCount.toString(),
              color:
                  HHelperFunctions.getOrderStatusColor(OrderStatus.delivered),
            ),
            const SizedBox(width: HSizes.spaceBtwItems),
            _buildMiniStatCard(
              context: context,
              title: "Processing",
              value: controller.processingCount.toString(),
              color:
                  HHelperFunctions.getOrderStatusColor(OrderStatus.processing),
            ),
            const SizedBox(width: HSizes.spaceBtwItems),
            _buildMiniStatCard(
              context: context,
              title: "Pending",
              value: controller.pendingCount.toString(),
              color: HHelperFunctions.getOrderStatusColor(OrderStatus.pending),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChartsSection(
      BuildContext context, DashboardController controller, bool dark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pie Chart
        Expanded(
          flex: 2,
          child: HRoundedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Distribution",
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: HSizes.spaceBtwItems),
                SizedBox(
                  height: 300,
                  child: Obx(() => PieChart(
                        PieChartData(
                          sections:
                              controller.orderStatusCount.entries.map((entry) {
                            final status = entry.key;
                            final count = entry.value;
                            final percentage =
                                (count / controller.orders.length * 100)
                                    .toStringAsFixed(1);
                            return PieChartSectionData(
                              title: "$percentage%",
                              value: count.toDouble(),
                              color:
                                  HHelperFunctions.getOrderStatusColor(status),
                              radius: 60,
                              titleStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: dark ? Colors.white : Colors.black,
                              ),
                            );
                          }).toList(),
                          sectionsSpace: 2,
                          centerSpaceRadius: 50,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: HSizes.spaceBtwItems),

        // Status Table
        Expanded(
          flex: 3,
          child: HRoundedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Details",
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: HSizes.spaceBtwItems),
                Obx(() => SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        columns: [
                          DataColumn(
                              label: Text("Status",
                                  style:
                                      Theme.of(context).textTheme.titleMedium)),
                          DataColumn(
                              label: Text("Count",
                                  style:
                                      Theme.of(context).textTheme.titleMedium)),
                          DataColumn(
                              label: Text("Amount",
                                  style:
                                      Theme.of(context).textTheme.titleMedium)),
                          DataColumn(
                              label: Text("%",
                                  style:
                                      Theme.of(context).textTheme.titleMedium)),
                        ],
                        rows: controller.orderStatusCount.entries.map((entry) {
                          final status = entry.key;
                          final count = entry.value;
                          final amount = controller.totalAmount[status] ?? 0;
                          final percentage =
                              (count / controller.orders.length * 100)
                                  .toStringAsFixed(1);
                          return DataRow(cells: [
                            DataCell(Row(
                              children: [
                                HCircularContainer(
                                  width: 12,
                                  height: 12,
                                  backgroundColor:
                                      HHelperFunctions.getOrderStatusColor(
                                          status),
                                ),
                                const SizedBox(width: HSizes.sm),
                                Text(status.name.capitalize!),
                              ],
                            )),
                            DataCell(Text(count.toString())),
                            DataCell(Text("${amount.toStringAsFixed(2)} ﷼")),
                            DataCell(Text("$percentage%")),
                          ]);
                        }).toList(),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentOrdersSection(
      BuildContext context, DashboardController controller) {
    return HRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Orders",
                  style: Theme.of(context).textTheme.headlineSmall),
              TextButton(
                onPressed: () => controller.refreshData(),
                child: const Text("Refresh"),
              ),
            ],
          ),
          const SizedBox(height: HSizes.spaceBtwItems),
          Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.orders.take(5).length,
                itemBuilder: (context, index) {
                  final order = controller.orders[index];
                  return ListTile(
                    leading: Text("#${order.id}"),
                    title: Text("${order.totalAmount.toStringAsFixed(2)} ﷼"),
                    subtitle: Text(order.orderStatus.name.capitalize!),
                    trailing: Chip(
                      label: Text(order.paymentMethod),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }

  Widget _buildTimePeriodTotals(
      BuildContext context, DashboardController controller) {
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
                child: _buildTimePeriodCard(
                  color: Colors.blue,
                  context: context,
                  title: "Today",
                  amount: controller.todayOrders
                      .fold(0.0, (sum, order) => sum + order.totalAmount),
                  icon: Iconsax.calendar_1,
                ),
              ),
              const SizedBox(width: HSizes.spaceBtwItems),
              Expanded(
                child: _buildTimePeriodCard(
                  color: Colors.green,
                  context: context,
                  title: "This Month",
                  amount: controller.thisMonthOrders
                      .fold(0.0, (sum, order) => sum + order.totalAmount),
                  icon: Iconsax.calendar_tick,
                ),
              ),
              const SizedBox(width: HSizes.spaceBtwItems),
              Expanded(
                child: _buildTimePeriodCard(
                  color: Colors.orange,
                  context: context,
                  title: "Last Month",
                  amount: controller.lastMonthOrders
                      .fold(0.0, (sum, order) => sum + order.totalAmount),
                  icon: Iconsax.calendar_1,
                ),
              ),
              const SizedBox(width: HSizes.spaceBtwItems),
              Expanded(
                child: _buildTimePeriodCard(
                  color: Colors.purple,
                  context: context,
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

  Widget _buildTimePeriodCard({
    required BuildContext context,
    required String title,
    required double amount,
    required IconData icon,
    required Color color,
  }) {
    return HRoundedContainer(
      showShadow: true,
      showBorder: true,
      padding: const EdgeInsets.all(HSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: color),
              ),
            ],
          ),
          const SizedBox(height: HSizes.sm),
          Text(
            "${amount.toStringAsFixed(2)} ﷼",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: HColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChartSection(
      BuildContext context, DashboardController controller) {
    return HRoundedContainer(
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Revenue Trends",
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: HSizes.spaceBtwItems),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: "Weekly"),
                    Tab(text: "Monthly"),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: TabBarView(
                    children: [
                      _buildWeeklyBarChart(controller),
                      _buildMonthlyBarChart(controller),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyBarChart(DashboardController controller) {
    return Obx(() => BarChart(
          BarChartData(
            barGroups: controller.weeklyRevenueData,
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final days = [
                      'Sun',
                      'Mon',
                      'Tue',
                      'Wed',
                      'Thu',
                      'Fri',
                      'Sat'
                    ];
                    final now = DateTime.now();
                    final dayIndex = (now.weekday - value.toInt() + 7) % 7;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(days[dayIndex]),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(value.toInt().toString());
                  },
                  reservedSize: 40,
                ),
              ),
              rightTitles: const AxisTitles(),
              topTitles: const AxisTitles(),
            ),
          ),
        ));
  }

  Widget _buildMonthlyBarChart(DashboardController controller) {
    return Obx(() => BarChart(
          BarChartData(
            barGroups: controller.monthlyRevenueData,
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final months = [
                      'Jan',
                      'Feb',
                      'Mar',
                      'Apr',
                      'May',
                      'Jun',
                      'Jul',
                      'Aug',
                      'Sep',
                      'Oct',
                      'Nov',
                      'Dec'
                    ];
                    final now = DateTime.now();
                    final monthIndex = (now.month - value.toInt() - 1) % 12;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(months[monthIndex]),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(value.toInt().toString());
                  },
                  reservedSize: 40,
                ),
              ),
              rightTitles: const AxisTitles(),
              topTitles: const AxisTitles(),
            ),
          ),
        ));
  }

  Widget _buildOverviewCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: HRoundedContainer(
        padding: const EdgeInsets.all(HSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                HCircularContainer(
                  width: 30,
                  height: 30,
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, size: 18, color: color),
                ),
              ],
            ),
            const SizedBox(height: HSizes.sm),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: HRoundedContainer(
        padding: const EdgeInsets.all(HSizes.defaultSpace),
        child: Row(
          children: [
            HCircularContainer(
              width: 20,
              height: 20,
              backgroundColor: color,
            ),
            const SizedBox(width: HSizes.lg),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelMedium),
                Text(value, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
