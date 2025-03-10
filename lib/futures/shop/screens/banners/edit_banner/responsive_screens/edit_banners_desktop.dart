import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widget/edit_banner_form.dart';

class EditBannersDesktopScreen extends StatelessWidget {
  const EditBannersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: "Update Banners",
                  breadcrumbsItems: [HRoutes.banners, "Update Banners"],
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                EditBannerForm(),
              ],
            )),
      ),
    );
  }
}
