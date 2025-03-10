import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../routes/routes.dart';
import '../../../utils/constants/sizes.dart';

class HBreadcrumbsWithHeading extends StatelessWidget {
  final String heading;
  final List<String> breadcrumbsItems;
  final bool returnToPreviousScreen;
  const HBreadcrumbsWithHeading(
      {super.key,
      required this.heading,
      required this.breadcrumbsItems,
      this.returnToPreviousScreen = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Get.offAllNamed(HRoutes.dashboard),
              child: Padding(
                padding: EdgeInsets.all(TSizes.xs),
                child: Text("Dashboard",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(fontSizeDelta: -1)),
              ),
            ),
            for (int i = 0; i < breadcrumbsItems.length; i++)
              Row(children: [
                Text('/'),
                InkWell(
                  onTap: i == breadcrumbsItems.length - 1
                      ? null
                      : () => Get.offNamed(breadcrumbsItems[i]),
                  child: Padding(
                    padding: EdgeInsets.all(TSizes.xs),
                    child: Text(
                        i == breadcrumbsItems.length - 1
                            ? breadcrumbsItems[i].capitalize.toString()
                            : capitalize(breadcrumbsItems[i].substring(1)),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(fontSizeDelta: -1)),
                  ),
                ),
              ])
          ],
        ),
        SizedBox(height: TSizes.spaceBtwSections),
        Row(
          children: [
            if (returnToPreviousScreen)
              IconButton(
                  onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
            if (returnToPreviousScreen)
              const SizedBox(width: TSizes.spaceBtwItems),
            HPageHeading(heading: heading),
          ],
        )
      ],
    );
  }
}

class HPageHeading extends StatelessWidget {
  final String heading;
  final Widget? rightSideWidget;
  const HPageHeading({super.key, required this.heading, this.rightSideWidget});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(heading, style: Theme.of(context).textTheme.headlineLarge),
        rightSideWidget ?? const SizedBox(),
      ],
    );
  }
}

String capitalize(String s) =>
    s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
