import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../model/category_model.dart';
import '../widget/edit_category_form.dart';

class EditCategoriesDesktopScreen extends StatelessWidget {
  final CategoryModel category;
  const EditCategoriesDesktopScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // breadcrumbs
                const HBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: "Update Category",
                  breadcrumbsItems: [HRoutes.banners, "Update Category"],
                ),
                const SizedBox(height: HSizes.spaceBtwItems),
                // form
                EditCategoryForm(category: category),
              ],
            )),
      ),
    );
  }
}
