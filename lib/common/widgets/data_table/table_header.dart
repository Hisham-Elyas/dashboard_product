import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/device/device_utility.dart';

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
          flex: TDeviceUtils.isDesktopScreen(context) ? 3 : 1,
          child: Row(children: [
            SizedBox(
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
