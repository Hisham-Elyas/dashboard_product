import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/product.dart';

class ProductController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = true.obs; // Loading state

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() {
    firestore.collection('products').snapshots().listen((snapshot) {
      products.value = snapshot.docs
          .map((doc) => Product.fromJson(doc.data(), doc.id))
          .toList();
      isLoading.value = false; // Data loaded, stop showing loading
    });
    products.sort(
      (a, b) {
        return a.price.compareTo(b.price);
      },
    );
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
