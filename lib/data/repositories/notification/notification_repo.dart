import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../utils/constants/enums.dart';

class NotificationRepo extends GetxController {
  static NotificationRepo get instance => Get.find();
  // ...
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> sendOrderStatusNotification({
    required String orderId,
    required String userId,
    required OrderStatus newStatus,
  }) async {
    // final orderDoc = await _db.collection('Orders').doc(orderId).get();
    // final orderData = orderDoc.data();

    // if (orderData == null) return;

    String title;
    String body;

    switch (newStatus) {
      case OrderStatus.pending:
        title = 'تم استلام طلبك';
        body = 'طلبك رقم #${orderId.substring(0, 8)} قيد المراجعة';
        break;
      case OrderStatus.processing:
        title = 'جارٍ تجهيز طلبك';
        body = 'بدأنا في تجهيز طلبك رقم #${orderId.substring(0, 8)}';
        break;
      case OrderStatus.shipped:
        title = 'تم شحن طلبك';
        body = 'طلبك رقم #${orderId.substring(0, 8)} في الطريق إليك';
        break;
      case OrderStatus.delivered:
        title = 'تم تسليم طلبك';
        body = 'تم تسليم طلبك رقم #${orderId.substring(0, 8)} بنجاح';
        break;
      case OrderStatus.cancelled:
        title = 'تم إلغاء طلبك';
        body = 'تم إلغاء طلبك رقم #${orderId.substring(0, 8)}';
        break;
      case OrderStatus.readyForPickup:
        title = 'طلبك جاهز للاستلام';
        body = 'يمكنك استلام طلبك رقم #${orderId.substring(0, 8)} من الفرع';
        break;
    }

    await _db.collection('Notifications').add({
      'userId': userId,
      'title': title,
      'body': body,
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
      'type': 'order',
      'data': {
        'orderId': orderId,
        'status': newStatus.name,
      },
    });
  }
}
