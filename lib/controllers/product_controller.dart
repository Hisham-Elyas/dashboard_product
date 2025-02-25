import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/product.dart';

class ProductController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxList<Product> products = <Product>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() {
    isLoading(true);
    try {
      firestore.collection('products').snapshots().listen((snapshot) {
        products.value = snapshot.docs
            .map((doc) => Product.fromJson(doc.data(), doc.id))
            .toList();
      });
    } finally {
      isLoading(false);
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await firestore.collection('products').add(product.toJson());
      Get.snackbar("Success", "Product added successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to add product!");
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await firestore
          .collection('products')
          .doc(product.id)
          .update(product.toJson());
      Get.snackbar("Success", "Product updated successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to update product!");
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await firestore.collection('products').doc(id).delete();
      Get.snackbar("Success", "Product deleted successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete product!");
    }
  }
}
