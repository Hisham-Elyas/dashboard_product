import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controller/products/products_controller.dart';
import '../table/data_table.dart';

class ProductsDesktopScreen extends StatelessWidget {
  const ProductsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HBreadcrumbsWithHeading(
                  heading: "Products",
                  breadcrumbsItems: ["Products"],
                ),
                const SizedBox(height: HSizes.spaceBtwItems),
                HRoundedContainer(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: HSizes.spaceBtwItems),

                        ///  Table Header
                        HTableHeader(
                            searchController: controller.searchTextController,
                            searchOnChanged: (query) =>
                                controller.searchQuery(query),
                            onPressed: () {
                              Get.toNamed(HRoutes.createProducts);
                            },
                            buttonText: "Create New Products"),
                        const SizedBox(height: HSizes.spaceBtwItems),

                        /// Category Table

                        Obx(() {
                          if (controller.isLoading.value) {
                            return const HLoaderAnimation();
                          }
                          return const ProductsTable();
                        })
                      ]),
                ),
              ],
            )),
      ),
    );
  }
}
