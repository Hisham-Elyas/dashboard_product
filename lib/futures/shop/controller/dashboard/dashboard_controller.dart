import 'dart:math';

// dashboard_controller.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../model/orders_model.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find<DashboardController>();

  // Reactive variables
  final RxMap<OrderStatus, int> orderStatusCount = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmount = <OrderStatus, double>{}.obs;
  final RxList<OrderModel> orders = <OrderModel>[].obs;

  // Initialize with sample data
  @override
  void onInit() {
    super.onInit();
    _initializeSampleData();
    _calculateOrderStatusCount();
  }

  void _initializeSampleData() {
    OrderModel generateRandomOrder(int id, int userId) {
      final random = Random();
      const deliveryMethods = DeliveryMethod.values;
      const orderStatuses = OrderStatus.values;
      final paymentMethods = ['Credit Card', 'PayPal', 'Cash'];

      return OrderModel(
        id: id.toString(),
        userId: userId.toString(),
        totalAmount: random.nextInt(1000) + 100.0,
        createdAt: DateTime.now().subtract(Duration(days: random.nextInt(30))),
        deliveryMethod: deliveryMethods[random.nextInt(deliveryMethods.length)],
        shippingAddress: null,
        shippingCompany: 'Company ${random.nextInt(5) + 1}',
        shippingNotes: 'Note ${random.nextInt(5) + 1}',
        paymentMethod: paymentMethods[random.nextInt(paymentMethods.length)],
        orderStatus: orderStatuses[random.nextInt(orderStatuses.length)],
        item: [],
      );
    }

    List<OrderModel> generateSampleOrders(int count) {
      return List.generate(
          count, (index) => generateRandomOrder(index + 1, index % 3 + 1));
    }

    orders.assignAll(generateSampleOrders(12345));
  }

  int get homeDeliveryOrderCount {
    return orders
        .where((order) => order.deliveryMethod == DeliveryMethod.homeDelivery)
        .length;
  }

  int get branchPickupOrderCount {
    return orders
        .where((order) => order.deliveryMethod == DeliveryMethod.branchPickup)
        .length;
  }

  void _calculateOrderStatusCount() {
    orderStatusCount.clear();
    totalAmount.clear();

    // Initialize all statuses with 0
    for (var status in OrderStatus.values) {
      orderStatusCount[status] = 0;
      totalAmount[status] = 0.0;
    }

    // Calculate counts and amounts
    for (var order in orders) {
      final status = order.orderStatus;
      orderStatusCount[status] = (orderStatusCount[status] ?? 0) + 1;
      totalAmount[status] = (totalAmount[status] ?? 0) + order.totalAmount;
    }
  }

  List<OrderModel> get thisYearOrders => orders
      .where((order) => order.createdAt!.year == DateTime.now().year)
      .toList();

// Add last month calculation
  List<OrderModel> get lastMonthOrders {
    final now = DateTime.now();
    final thisMonthStart = DateTime(now.year, now.month, 1);
    final lastMonthEnd = thisMonthStart.subtract(const Duration(days: 1));
    final lastMonthStart = DateTime(lastMonthEnd.year, lastMonthEnd.month, 1);

    return orders
        .where((order) =>
            order.createdAt!.isAfter(lastMonthStart) &&
            order.createdAt!.isBefore(thisMonthStart))
        .toList();
  }

  // Calculated properties
  double get totalRevenue =>
      orders.fold(0.0, (sum, order) => sum + order.totalAmount);
  double get averageOrderValue =>
      orders.isEmpty ? 0 : totalRevenue / orders.length;
  int get deliveredCount => orderStatusCount[OrderStatus.delivered] ?? 0;
  int get processingCount => orderStatusCount[OrderStatus.processing] ?? 0;
  int get pendingCount => orderStatusCount[OrderStatus.pending] ?? 0;

  // Time-based filters
  List<OrderModel> get todayOrders => orders
      .where((order) => order.createdAt!
          .isAfter(DateTime.now().subtract(const Duration(days: 1))))
      .toList();

  List<OrderModel> get thisWeekOrders => orders
      .where((order) => order.createdAt!
          .isAfter(DateTime.now().subtract(const Duration(days: 7))))
      .toList();

  List<OrderModel> get thisMonthOrders => orders
      .where((order) => order.createdAt!
          .isAfter(DateTime.now().subtract(const Duration(days: 30))))
      .toList();

  // Refresh data
  Future<void> refreshData() async {
    _calculateOrderStatusCount();
    update();
  }

  double get maxRevenueValue {
    if (monthlyRevenueData.isEmpty) return 0;
    return monthlyRevenueData
        .map((e) => e.barRods.first.toY)
        .reduce((a, b) => a > b ? a : b);
  }

  // Add weekly revenue data for bar chart
  List<BarChartGroupData> get weeklyRevenueData {
    final now = DateTime.now();
    final data = <BarChartGroupData>[];

    // Get last 7 days
    for (int i = 6; i >= 0; i--) {
      final day = now.subtract(Duration(days: i));
      final dayOrders = orders
          .where((order) =>
              order.createdAt!.year == day.year &&
              order.createdAt!.month == day.month &&
              order.createdAt!.day == day.day)
          .toList();

      final total =
          dayOrders.fold(0.0, (sum, order) => sum + order.totalAmount);

      data.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: total,
            color: HColors.primary,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        showingTooltipIndicators: [0],
      ));
    }

    return data;
  }

  // Add monthly revenue data for bar chart
  List<BarChartGroupData> get monthlyRevenueData {
    final now = DateTime.now();
    final data = <BarChartGroupData>[];

    // Get last 6 months
    for (int i = 5; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      final monthOrders = orders
          .where((order) =>
              order.createdAt!.year == month.year &&
              order.createdAt!.month == month.month)
          .toList();

      final total =
          monthOrders.fold(0.0, (sum, order) => sum + order.totalAmount);

      data.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: total,
            color: HColors.primary,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        showingTooltipIndicators: [0],
      ));
    }

    return data;
  }
}
