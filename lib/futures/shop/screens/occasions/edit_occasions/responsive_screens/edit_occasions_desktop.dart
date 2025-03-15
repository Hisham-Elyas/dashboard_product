import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../model/occasions_model.dart';
import '../widget/edit_occasions_form.dart';

class EditOccasionsDesktopScreen extends StatelessWidget {
  final OccasionsModel occasions;
  const EditOccasionsDesktopScreen({super.key, required this.occasions});

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
                  heading: "Update occasions",
                  breadcrumbsItems: [HRoutes.occasions, "Update occasions"],
                ),
                const SizedBox(height: HSizes.spaceBtwItems),
                // form
                EditOccasionsForm(occasions: occasions),
              ],
            )),
      ),
    );
  }
}
