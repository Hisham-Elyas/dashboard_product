import 'package:get/get.dart';

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

  // Update Product Status
  Future<void> updateOrderStatus(
      OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.orderStatus = newStatus;
      await _ordersRepo.updateOrderSpecificValue(
          order.id, {'orderStatus': newStatus.name.toString()});
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
    throw UnimplementedError();
  }

  @override
  Future<List<OrderModel>> fetchItems() {
    return _ordersRepo.getAllOrders();
  }
}
