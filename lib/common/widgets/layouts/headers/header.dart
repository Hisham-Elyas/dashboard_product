import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../images/h_rounded_image.dart';

class HHeader extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const HHeader({super.key, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: HSizes.md, vertical: HSizes.sm),
      decoration: const BoxDecoration(
          color: HColors.white,
          border: Border(bottom: BorderSide(color: HColors.grey, width: 1))),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: !HDeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () {
                  scaffoldKey?.currentState?.openDrawer();
                },
                icon: const Icon(Iconsax.menu))
            : null,
        title: HDeviceUtils.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal),
                      hintText: "Search anything..."),
                ),
              )
            : null,
        actions: [
          if (!HDeviceUtils.isDesktopScreen(context))
            IconButton(
                onPressed: () {}, icon: const Icon(Iconsax.search_normal)),
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.notification)),
          const SizedBox(width: HSizes.spaceBtwItems),
          Row(
            children: [
              const HRoundedImage(
                width: 40,
                padding: 2,
                height: 40,
                imageType: ImageType.asset,
                image: HImages.user,
              ),
              const SizedBox(width: HSizes.sm),
              if (!HDeviceUtils.isMobileScreen(context))
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Coding with H",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "Hisham@gmail.com",
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                )
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(HDeviceUtils.getAppBarHeight() + 15);
}
