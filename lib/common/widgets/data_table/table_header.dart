import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';
import '../containers/rounded_container.dart';

class HTableHeader extends StatelessWidget {
  final void Function()? onPressed;
  final TextEditingController? searchController;
  final void Function(String)? searchOnChanged;
  final String buttonText;
  const HTableHeader(
      {super.key,
      this.onPressed,
      required this.buttonText,
      this.searchController,
      this.searchOnChanged});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: HDeviceUtils.isDesktopScreen(context) ? 3 : 1,
          child: Row(children: [
            HDeviceUtils.isMobileScreen(context)
                ? HRoundedContainer(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: HColors.primary,
                    child: IconButton(
                      onPressed: onPressed,
                      icon: const Icon(Iconsax.add),
                    ),
                  )
                : SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      child: Text(buttonText),
                    ),
                  ),
          ])),
      Expanded(
          child: TextField(
        controller: searchController,
        onChanged: searchOnChanged,
        decoration: const InputDecoration(
            hintText: "Search here...",
            prefixIcon: Icon(Iconsax.search_normal)),
      ))
    ]);
  }
}
