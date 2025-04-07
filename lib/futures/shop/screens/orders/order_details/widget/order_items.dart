import 'package:flutter/material.dart';
import 'package:h_dashboard_store/common/widgets/containers/rounded_container.dart';
import 'package:h_dashboard_store/common/widgets/images/h_rounded_image.dart';
import 'package:h_dashboard_store/utils/constants/colors.dart';
import 'package:h_dashboard_store/utils/constants/image_strings.dart';
import 'package:h_dashboard_store/utils/constants/sizes.dart';
import 'package:h_dashboard_store/utils/device/device_utility.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../model/orders_model.dart';

class OrderItems extends StatelessWidget {
  final OrderModel order;
  const OrderItems({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final subTotal = order.item.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity));
    return HRoundedContainer(
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Items",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: HSizes.spaceBtwSections),
          ListView.separated(
            separatorBuilder: (context, index) =>
                const SizedBox(height: HSizes.spaceBtwItems),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.item.length,
            itemBuilder: (context, index) {
              final item = order.item[index];
              return Row(children: [
                Expanded(
                    child: Row(children: [
                  HRoundedImage(
                    backgroundColor: HColors.primaryBackground,
                    imageType: item.productImageUrl != null
                        ? ImageType.network
                        : ImageType.asset,
                    image: item.productImageUrl ?? HImages.defaultImage,
                  ),
                  const SizedBox(width: HSizes.spaceBtwItems),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium),
                      // const SizedBox(height: HSizes.spaceBtwItems),
                      // Text(
                      //   "${item.quantity} x ${item.price} ﷼",
                      //   style: Theme.of(context).textTheme.titleMedium,
                      // ),
                    ],
                  )),
                ])),
                const SizedBox(width: HSizes.spaceBtwItems),
                SizedBox(
                  width: HSizes.xl * 2,
                  child: Text(
                    "${item.price.toStringAsFixed(1)} ﷼",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(
                  width: HDeviceUtils.isDesktopScreen(context)
                      ? HSizes.xl * 1.4
                      : HSizes.xl * 2,
                  child: Text(
                    item.quantity.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(
                  width: HDeviceUtils.isDesktopScreen(context)
                      ? HSizes.xl * 1.4
                      : HSizes.xl * 2,
                  child: Text(
                    "${item.totalAmount} ﷼",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ]);
            },
          ),
          const SizedBox(height: HSizes.spaceBtwSections),
          // item total
          HRoundedContainer(
            padding: const EdgeInsets.all(HSizes.defaultSpace),
            backgroundColor: HColors.primaryBackground,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subtotal",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "$subTotal ﷼",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: HSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "${order.shippingCompany} ﷼",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: HSizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: HSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "${order.totalAmount} ﷼",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
