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
      margin: EdgeInsets.all(8.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display product image if available
            product.image.isNotEmpty
                ? SizedBox(
                    height: 200.h,
                    child: Image.network(
                      product.image,
                      width: double.infinity,
                      height: 200.h,
                      fit: BoxFit.contain,
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 200.h,
                    color: Colors.grey,
                  ),
            SizedBox(height: 15.h),
            Text(
              product.name,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Text("Price: \$${product.price.toStringAsFixed(2)}"),
            SizedBox(height: 5.h),
            Expanded(
              child: Text(
                product.detail,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, size: 20.sp),
                  onPressed: () {
                    _showProductDialog(product: product);
                  },
                ),
                SizedBox(width: 5.h),
                IconButton(
                  icon: Icon(Icons.delete, size: 20.sp, color: Colors.red),
                  onPressed: () {
                    controller.deleteProduct(product.id!);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Determine number of columns based on screen width
  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 1200) return 5;
    if (screenWidth >= 800) return 4;
    return 3;
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
        if (controller.products.isEmpty) {
          return Center(
            child: Text("No products available",
                style: TextStyle(fontSize: 18.sp)),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            controller.fetchProducts();
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 0.8,
              ),
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];
                return _buildProductItem(product);
              },
            ),
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
