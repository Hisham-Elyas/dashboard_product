import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/repositories/auth/auth_repo.dart';
import '../../../../../routes/routes.dart';
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
      onTap: () {
        if (itemName == 'Logout') {
          Get.put(AuthRepo()).signOut();
          Get.offAllNamed(HRoutes.login);
        } else {
          menuController.menuOnTap(route);
        }
      },
      onHover: (hovering) => hovering
          ? menuController.changeHoverItemTo(route)
          : menuController.changeHoverItemTo(""),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: HSizes.xs),
          child: Container(
            decoration: BoxDecoration(
                color: menuController.isHovering(route) ||
                        menuController.isActive(route)
                    ? HColors.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(HSizes.cardRadiusMd)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: HSizes.lg,
                      bottom: HSizes.md,
                      right: HSizes.md,
                      top: HSizes.md),
                  child: menuController.isActive(route)
                      ? Icon(
                          icon,
                          color: HColors.white,
                          size: 22,
                        )
                      : Icon(
                          icon,
                          color: menuController.isHovering(route)
                              ? HColors.white
                              : HColors.darkGrey,
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
                          .apply(color: HColors.white),
                    ),
                  )
                else
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: HColors.darkGrey),
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
