import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widget/create_categories_proucts_multis_select.dart';
import '../widget/create_products_form.dart';

class CreateProductsTabletScreen extends StatelessWidget {
  const CreateProductsTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(HSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: "Create Products",
                  breadcrumbsItems: [HRoutes.products, "Create Products"],
                ),
                SizedBox(height: HSizes.spaceBtwItems),

                /// form
                CreateProductsForm(),
                SizedBox(height: HSizes.spaceBtwItems),
                CreateCategoriesProuctsMultisSelect(),
              ],
            )),
      ),
    );
  }
}
