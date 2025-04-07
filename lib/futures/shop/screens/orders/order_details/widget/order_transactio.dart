import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:h_dashboard_store/common/widgets/containers/rounded_container.dart';
import 'package:h_dashboard_store/common/widgets/images/h_rounded_image.dart';
import 'package:h_dashboard_store/utils/constants/enums.dart';
import 'package:h_dashboard_store/utils/constants/image_strings.dart';
import 'package:h_dashboard_store/utils/device/device_utility.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../model/orders_model.dart';

class OrderTransactio extends StatelessWidget {
  final OrderModel order;
  const OrderTransactio({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return HRoundedContainer(
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Transaction",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: HSizes.spaceBtwSections),
          Row(
            children: [
              Expanded(
                  flex: HDeviceUtils.isMobileScreen(context) ? 2 : 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HRoundedImage(
                          imageType: ImageType.asset, image: HImages.paypal),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text('Payment Method'),
                            Text(order.paymentMethod.capitalize.toString(),
                                style: Theme.of(context).textTheme.titleLarge),
                          ])),
                    ],
                  )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(HHelperFunctions.getFormattedDate(order.createdAt!),
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text("${order.totalAmount} ﷼",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
