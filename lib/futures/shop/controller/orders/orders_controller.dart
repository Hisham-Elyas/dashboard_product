import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../data/repositories/orders/orders_repo.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/orders_model.dart';

class OrdersController extends HBaseTableController<OrderModel> {
  static OrdersController get instance => Get.find();
  final RxBool statusLoader = false.obs;
  Rx<OrderStatus> orderStatus = OrderStatus.pending.obs;
  final _ordersRepo = Get.put(OrdersRepo());
  // For multi-select filtering
  final RxList<OrderStatus> selectedStatuses = <OrderStatus>[].obs;
  final List<MultiSelectItem<OrderStatus>> statusItems = [
    MultiSelectItem(OrderStatus.pending, 'Pending'),
    MultiSelectItem(OrderStatus.processing, 'Processing'),
    MultiSelectItem(OrderStatus.shipped, 'Shipped'),
    MultiSelectItem(OrderStatus.delivered, 'Delivered'),
    MultiSelectItem(OrderStatus.readyForPickup, 'Ready for Pickup'),
    MultiSelectItem(OrderStatus.cancelled, 'Cancelled'),
  ];
  //
  final Rx<DeliveryMethod?> selectedDeliveryMethod = Rx<DeliveryMethod?>(null);

  final List<MultiSelectItem<DeliveryMethod>> deliveryMethodsItems = [
    MultiSelectItem(DeliveryMethod.homeDelivery, 'Home Delivery'),
    MultiSelectItem(DeliveryMethod.branchPickup, 'Branch Pickup'),
  ];

// Update method
  void updateDeliveryMethodFilter(DeliveryMethod? method) {
    selectedDeliveryMethod.value = method;
    applyFilters();
  }

  // Apply all active filters (status and search)
  void applyFilters() {
    List<OrderModel> tempList = allItems;

    // Filter by selected OrderStatus
    if (selectedStatuses.isNotEmpty) {
      tempList = tempList
          .where((order) => selectedStatuses.contains(order.orderStatus))
          .toList();
    }

    // Filter by selected DeliveryMethod
    if (selectedDeliveryMethod.value != null) {
      tempList = tempList
          .where(
              (order) => order.deliveryMethod == selectedDeliveryMethod.value)
          .toList();
    }

    // Apply search query
    final query = searchTextController.text.trim();
    if (query.isNotEmpty) {
      tempList =
          tempList.where((item) => containsSearchQuer(item, query)).toList();
    }

    // Final filtered result
    filteredItems.assignAll(tempList);
  }

  // Update status filters
  void updateStatusFilters(List<OrderStatus> selected) {
    selectedStatuses.assignAll(selected);
    applyFilters();
  }

  // Update Product Status
  Future<void> updateOrderStatus(
      OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.orderStatus = newStatus;
      await _ordersRepo.updateOrderSpecificValue(order);
      // updateItemFromLists(order);
      orderStatus.value = newStatus;
      HLoaders.successSnackBar(
          title: 'Updated', message: 'Order Status Updated');
    } catch (e) {
      HLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }

  void listenToOrdersStream() {
    isLoading.value = true;
    _ordersRepo.getAllOrdersStream().listen((orders) {
      //  orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      allItems.assignAll(orders);
      filteredItems.assignAll(orders);
      selectedRows.assignAll(List.generate(orders.length, (index) => false));
      isLoading.value = false;
    });
  }

  @override
  void onInit() {
    listenToOrdersStream();
    super.onInit();
  }

  @override
  bool containsSearchQuer(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OrderModel item) {
    throw _ordersRepo.deleteOrders(item.id);
  }

  @override
  Future<List<OrderModel>> fetchItems() {
    return _ordersRepo.getAllOrders();
  }
}
