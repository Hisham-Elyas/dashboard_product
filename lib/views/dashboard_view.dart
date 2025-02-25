import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import '../models/product.dart';

class DashboardView extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text editing controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  DashboardView({super.key});

  // Show a dialog for adding or editing a product
  void _showProductDialog({Product? product}) {
    if (product != null) {
      nameController.text = product.name;
      priceController.text = product.price.toString();
      imageController.text = product.image;
      detailController.text = product.detail;
    } else {
      nameController.clear();
      priceController.clear();
      imageController.clear();
      detailController.clear();
    }
    Get.dialog(
      AlertDialog(
        title: Text(product == null ? "Add Product" : "Edit Product"),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name field
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter product name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                // Price field
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter product price";
                    }
                    if (double.tryParse(value) == null) {
                      return "Please enter a valid number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                // Image URL field
                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: "Image URL"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter image URL";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                // Detail field
                TextFormField(
                  controller: detailController,
                  decoration: const InputDecoration(labelText: "Detail"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter product detail";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newProduct = Product(
                  id: product?.id,
                  name: nameController.text,
                  price: double.parse(priceController.text),
                  image: imageController.text,
                  detail: detailController.text,
                );
                if (product == null) {
                  controller.addProduct(newProduct);
                } else {
                  controller.updateProduct(newProduct);
                }
                Get.back();
              }
            },
            child: Text(product == null ? "Add" : "Update"),
          ),
        ],
      ),
    );
  }

  // Build a card widget for each product item
  Widget _buildProductItem(Product product) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            // Display product image if available
            product.image.isNotEmpty
                ? Image.network(
                    product.image,
                    width: 80.w,
                    height: 80.w,
                    fit: BoxFit.cover,
                  )
                : Container(width: 80.w, height: 80.w, color: Colors.grey),
            SizedBox(width: 16.w),
            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.h),
                  Text("Price: \$${product.price.toStringAsFixed(2)}"),
                  SizedBox(height: 8.h),
                  Text(product.detail),
                ],
              ),
            ),
            // Edit and Delete actions
            IconButton(
              icon: Icon(Icons.edit, size: 24.sp),
              onPressed: () {
                _showProductDialog(product: product);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, size: 24.sp, color: Colors.red),
              onPressed: () {
                controller.deleteProduct(product.id!);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Dashboard", style: TextStyle(fontSize: 20.sp)),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.fetchProducts();
          },
          child: ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return _buildProductItem(product);
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showProductDialog();
        },
        child: Icon(Icons.add, size: 24.sp),
      ),
    );
  }
}
