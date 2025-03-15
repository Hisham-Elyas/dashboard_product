import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../model/banners_model.dart';
import '../widget/edit_banner_form.dart';

class EditBannersDesktopScreen extends StatelessWidget {
  final BannersModel banners;
  const EditBannersDesktopScreen({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: "Update Banners",
                  breadcrumbsItems: [HRoutes.banners, "Update Banners"],
                ),
                const SizedBox(height: HSizes.spaceBtwItems),
                EditBannerForm(banners: banners),
              ],
            )),
      ),
    );
  }
}
