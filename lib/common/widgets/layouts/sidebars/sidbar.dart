import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../images/t_circular_image.dart';
import 'menu/menu_item.dart';

class HSidbar extends StatelessWidget {
  const HSidbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
            color: TColors.white,
            border: Border(
              right: BorderSide(color: TColors.grey, width: 1),
            )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TCircularImage(
                width: 100,
                image: TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("MENU",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(letterSpacingDelta: 1.2)),

                    /// Menu Item
                    const MenuItem(
                      icon: Iconsax.status,
                      itemName: "Dashboard",
                      route: HRoutes.dashboard,
                    ),
                    const MenuItem(
                      icon: Iconsax.picture_frame,
                      itemName: "Banners",
                      route: HRoutes.banners,
                    ),
                    const MenuItem(
                      icon: Iconsax.category_2,
                      itemName: "Categories",
                      route: HRoutes.categories,
                    ),
                    const MenuItem(
                      icon: Iconsax.category4,
                      itemName: "Occasions",
                      route: HRoutes.occasions,
                    ),
                    const MenuItem(
                      icon: Iconsax.shop,
                      itemName: "Products",
                      route: HRoutes.products,
                    ),
                    const MenuItem(
                      icon: Iconsax.shop1,
                      itemName: "Orders",
                      route: HRoutes.orders,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
