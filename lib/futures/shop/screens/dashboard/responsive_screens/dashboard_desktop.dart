import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Dashboard",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: HSizes.spaceBtwItems,
              )
            ])),
      ),
    );
  }
}
