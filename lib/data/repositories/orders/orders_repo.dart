import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../futures/shop/model/orders_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class OrdersRepo extends GetxController {
  static OrdersRepo get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> getAllOrders() async {
    try {
      final snapshot = await _db
          .collection("Orders")
          .orderBy('createdAt', descending: true)
          .get();
      final result =
          snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();

      return result;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e);
      throw "Someting went weong. pleas try agin";
    }
  }

  Future<void> updateOrders(OrderModel orders) async {
    try {
      await _db.collection("Orders").doc(orders.id).update(orders.toMap());
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  // Store a new user order
  Future<void> addOrder(OrderModel order) async {
    try {
      await _db.collection('Orders').add(order.toMap());
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  Future<void> updateOrderSpecificValue(
      String orderId, Map<String, dynamic> data) async {
    try {
      await _db.collection("Orders").doc(orderId).update(data);
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw "Someting went weong. pleas try agin";
    }
  }

  Stream<List<OrderModel>> getAllOrdersStream() {
    try {
      return _db
          .collection("Orders")
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => OrderModel.fromSnapshot(doc))
              .toList());
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      print(e);
      throw "Something went wrong. Please try again.";
    }
  }
}
