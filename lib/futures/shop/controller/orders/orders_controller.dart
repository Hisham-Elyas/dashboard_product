import 'package:get/get.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import '../../../../data/repositories/orders/orders_repo.dart';
import '../../model/orders_model.dart';

class OrdersController extends HBaseTableController<OrderModel> {
  static OrdersController get instance => Get.find();
  final _ordersRepo = Get.put(OrdersRepo());

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
