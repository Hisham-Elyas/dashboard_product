import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../model/products_model.dart';
import '../widget/edit_categories_proucts_multis_elect.dart';
import '../widget/edit_product_form.dart';

class EditProductsTabletScreen extends StatelessWidget {
  final ProductsModel product;
  const EditProductsTabletScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // breadcrumbs
              const HBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: "Update occasions",
                breadcrumbsItems: [HRoutes.products, "Update Products"],
              ),
              const SizedBox(height: HSizes.spaceBtwItems),
              const EditCategoriesProuctsMultisElect(),
              const SizedBox(height: HSizes.spaceBtwItems),
              EditProductForm(products: product),
            ])),
      ),
    );
  }
}
