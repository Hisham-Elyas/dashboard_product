import 'package:get/get.dart';

import '../../../../utils/constants/enums.dart';
import '../../model/orders_model.dart';

class DashboardController extends GetxController {
  RxMap<OrderStatus, int> orderStatusCount =
      <OrderStatus, int>{}.obs; // <OrderStatus, int>
  RxMap<OrderStatus, double> totalAmount =
      <OrderStatus, double>{}.obs; // <OrderStatus, double>
  final RxList<OrderModel> orders = <OrderModel>[
    OrderModel(
      id: '1',
      userId: '1',
      totalAmount: 100,
      createdAt: DateTime.now(),
      deliveryMethod: 'Standard Delivery',
      shippingAddress: null,
      shippingCompany: '',
      shippingNotes: '',
      paymentMethod: 'Credit Card',
      orderStatus: OrderStatus.delivered,
      item: [],
    ),
    OrderModel(
      id: '2',
      userId: '2',
      totalAmount: 200,
      createdAt: DateTime.now(),
      deliveryMethod: 'Express Delivery',
      shippingAddress: null,
      shippingCompany: '',
      shippingNotes: '',
      paymentMethod: 'PayPal',
      orderStatus: OrderStatus.processing,
      item: [],
    ),
    OrderModel(
      id: '3',
      userId: '3',
      totalAmount: 300,
      createdAt: DateTime.now(),
      deliveryMethod: 'Standard Delivery',
      shippingAddress: null,
      shippingCompany: '',
      shippingNotes: '',
      paymentMethod: 'Credit Card',
      orderStatus: OrderStatus.pending,
      item: [],
    ),
    OrderModel(
      id: '1',
      userId: '1',
      totalAmount: 100,
      createdAt: DateTime.now(),
      deliveryMethod: 'Standard Delivery',
      shippingAddress: null,
      shippingCompany: '',
      shippingNotes: '',
      paymentMethod: 'Credit Card',
      orderStatus: OrderStatus.delivered,
      item: [],
    ),
    OrderModel(
      id: '2',
      userId: '2',
      totalAmount: 200,
      createdAt: DateTime.now(),
      deliveryMethod: 'Express Delivery',
      shippingAddress: null,
      shippingCompany: '',
      shippingNotes: '',
      paymentMethod: 'PayPal',
      orderStatus: OrderStatus.processing,
      item: [],
    ),
    OrderModel(
      id: '3',
      userId: '3',
      totalAmount: 300,
      createdAt: DateTime.now(),
      deliveryMethod: 'Standard Delivery',
      shippingAddress: null,
      shippingCompany: '',
      shippingNotes: '',
      paymentMethod: 'Credit Card',
      orderStatus: OrderStatus.pending,
      item: [],
    ),
    OrderModel(
      id: '1',
      userId: '1',
      totalAmount: 100,
      createdAt: DateTime.now(),
      deliveryMethod: 'Standard Delivery',
      shippingAddress: null,
      shippingCompany: '',
      shippingNotes: '',
      paymentMethod: 'Credit Card',
      orderStatus: OrderStatus.delivered,
      item: [],
    ),
    OrderModel(
      id: '2',
      userId: '2',
      totalAmount: 200,
      createdAt: DateTime.now(),
      deliveryMethod: 'Express Delivery',
      shippingAddress: null,
      shippingCompany: '',
      shippingNotes: '',
      paymentMethod: 'PayPal',
      orderStatus: OrderStatus.processing,
      item: [],
    ),
    OrderModel(
      id: '3',
      userId: '3',
      totalAmount: 300,
      createdAt: DateTime.now(),
      deliveryMethod: 'Standard Delivery',
      shippingAddress: null,
      shippingCompany: '',
      shippingNotes: '',
      paymentMethod: 'Credit Card',
      orderStatus: OrderStatus.pending,
      item: [],
    ),
  ].obs;
  _calculateOrderStatusCount() {
    orderStatusCount.clear();
    totalAmount.clear();
    totalAmount.value = {for (var status in OrderStatus.values) status: 0.0};
    for (var order in orders) {
      // count orders
      final status = order.orderStatus;
      orderStatusCount[status] = (orderStatusCount[status] ?? 0) + 1;
      totalAmount[status] = totalAmount[status]! + order.totalAmount;
    }
  }
}
