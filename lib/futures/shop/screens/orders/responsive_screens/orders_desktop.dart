import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';

class OrdersDesktopScreen extends StatelessWidget {
  const OrdersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "orders",
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
