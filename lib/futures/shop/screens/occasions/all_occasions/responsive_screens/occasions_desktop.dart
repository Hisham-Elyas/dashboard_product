import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../table/data_table.dart';

class OccasionsDesktopScreen extends StatelessWidget {
  const OccasionsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HBreadcrumbsWithHeading(
                  heading: "Occasions",
                  breadcrumbsItems: ["Occasions"],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                TRoundedContainer(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: TSizes.spaceBtwItems),

                        ///  Table Header
                        HTableHeader(
                            onPressed: () {
                              Get.toNamed(HRoutes.createOccasions);
                            },
                            buttonText: "Create New Occasions"),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        /// Category Table
                        const OccasionsTable()
                      ]),
                ),
              ],
            )),
      ),
    );
  }
}
