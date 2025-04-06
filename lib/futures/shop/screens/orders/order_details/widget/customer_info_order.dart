import 'package:flutter/material.dart';
import 'package:h_dashboard_store/common/widgets/containers/rounded_container.dart';
import 'package:h_dashboard_store/common/widgets/images/h_rounded_image.dart';
import 'package:h_dashboard_store/utils/constants/colors.dart';
import 'package:h_dashboard_store/utils/constants/image_strings.dart';
import 'package:h_dashboard_store/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../model/orders_model.dart';

class CustomerInfoOrder extends StatelessWidget {
  final OrderModel order;
  const CustomerInfoOrder({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      /// personal information
      HRoundedContainer(
        padding: const EdgeInsets.all(HSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Customer Information",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: HSizes.spaceBtwSections),
            Row(children: [
              const HRoundedImage(
                  imageType: ImageType.asset,
                  padding: 0,
                  backgroundColor: HColors.primaryBackground,
                  image: HImages.user),
              const SizedBox(width: HSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'HISHAM SD',
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "H@H.com",
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
      // Cantact information
      const SizedBox(height: HSizes.spaceBtwSections),
      SizedBox(
        width: double.infinity,
        child: HRoundedContainer(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Contact Person",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: HSizes.spaceBtwSections),
              Text("HISHAM SD",
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              Text("H@H.com",
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              Row(
                children: [
                  const Icon(Iconsax.call, color: Colors.green),
                  const SizedBox(width: HSizes.spaceBtwItems),
                  Text(
                    "+966 123456789",
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ])),
      ),
      const SizedBox(height: HSizes.spaceBtwSections),

      /// Address
      SizedBox(
        width: double.infinity,
        child: HRoundedContainer(
          padding: const EdgeInsets.all(HSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: HSizes.spaceBtwSections),
              Text(order.shippingAddress!.country,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              Text(order.shippingAddress!.city,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              Text(order.shippingAddress!.street,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              Text(order.shippingAddress!.district,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              Text(order.shippingAddress!.houseDesc,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              Text(order.shippingAddress!.postalCode,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
            ],
          ),
        ),
      ),
    ]);
  }
}
