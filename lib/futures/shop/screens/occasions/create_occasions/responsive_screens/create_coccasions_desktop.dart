import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widget/create_occasions_form.dart';

class CreateOccasionsDesktopScreen extends StatelessWidget {
  const CreateOccasionsDesktopScreen({super.key});

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
                  heading: "Create Occasions",
                  breadcrumbsItems: [HRoutes.occasions, "Create Occasions"],
                ),
                SizedBox(height: HSizes.spaceBtwItems),

                /// form
                CreateOccasionsForm(),
              ],
            )),
      ),
    );
  }
}
