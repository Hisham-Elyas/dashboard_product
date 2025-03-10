import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../sidebar_controller.dart';

class MenuItem extends StatelessWidget {
  final String route;
  final String itemName;
  final IconData icon;
  const MenuItem({
    super.key,
    required this.route,
    required this.itemName,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final SidebarController menuController = Get.put(SidebarController());
    return InkWell(
      onTap: () => menuController.menuOnTap(route),
      onHover: (hovering) => hovering
          ? menuController.changeHoverItemTo(route)
          : menuController.changeHoverItemTo(""),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Container(
            decoration: BoxDecoration(
                color: menuController.isHovering(route) ||
                        menuController.isActive(route)
                    ? TColors.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(TSizes.cardRadiusMd)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: TSizes.lg,
                      bottom: TSizes.md,
                      right: TSizes.md,
                      top: TSizes.md),
                  child: menuController.isActive(route)
                      ? Icon(
                          icon,
                          color: TColors.white,
                          size: 22,
                        )
                      : Icon(
                          icon,
                          color: menuController.isHovering(route)
                              ? TColors.white
                              : TColors.darkGrey,
                          size: 22,
                        ),
                ),
                if (menuController.isHovering(route) ||
                    menuController.isActive(route))
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColors.white),
                    ),
                  )
                else
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColors.darkGrey),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
