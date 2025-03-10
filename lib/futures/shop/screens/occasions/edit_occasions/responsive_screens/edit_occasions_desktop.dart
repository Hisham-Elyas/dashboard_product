import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widget/edit_occasions_form.dart';

class EditOccasionsDesktopScreen extends StatelessWidget {
  const EditOccasionsDesktopScreen({super.key});

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
                  heading: "Update occasions",
                  breadcrumbsItems: [HRoutes.banners, "Update occasions"],
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                // form
                EditOccasionsForm(),
              ],
            )),
      ),
    );
  }
}
