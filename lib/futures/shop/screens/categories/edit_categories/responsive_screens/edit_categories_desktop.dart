import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widget/edit_category_form.dart';

class EditCategoriesDesktopScreen extends StatelessWidget {
  const EditCategoriesDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // breadcrumbs
                HBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: "Update Category",
                  breadcrumbsItems: [HRoutes.banners, "Update Banners"],
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                // form
                EditCategoryForm(),
              ],
            )),
      ),
    );
  }
}
