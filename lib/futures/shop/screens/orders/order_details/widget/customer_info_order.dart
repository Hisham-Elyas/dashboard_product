import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_dashboard_store/common/widgets/containers/rounded_container.dart';
import 'package:h_dashboard_store/common/widgets/images/h_rounded_image.dart';
import 'package:h_dashboard_store/utils/constants/colors.dart';
import 'package:h_dashboard_store/utils/constants/image_strings.dart';
import 'package:h_dashboard_store/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../controller/orders/order_details_controller.dart';
import '../../../../model/orders_model.dart';

class CustomerInfoOrder extends StatelessWidget {
  final OrderModel order;
  const CustomerInfoOrder({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();
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
              Obx(
                () => Skeletonizer(
                  enabled: controller.loading.value,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.customer.value.fullName,
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          controller.customer.value.email,
                          style: Theme.of(context).textTheme.labelMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
      // Cantact information
      const SizedBox(height: HSizes.spaceBtwSections),
      Obx(
        () => Skeletonizer(
          enabled: controller.loading.value,
          child: SizedBox(
            width: double.infinity,
            child: HRoundedContainer(
                padding: const EdgeInsets.all(HSizes.defaultSpace),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact Person",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: HSizes.spaceBtwSections),
                      Text(controller.customer.value.userName,
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1),
                      const SizedBox(height: HSizes.spaceBtwItems / 2),
                      Text(controller.customer.value.email,
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1),
                      const SizedBox(height: HSizes.spaceBtwItems / 2),
                      Row(
                        children: [
                          const Skeleton.shade(
                              child: Icon(Iconsax.call, color: Colors.green)),
                          const SizedBox(width: HSizes.spaceBtwItems),
                          Text(
                            controller.customer.value.phoneNumber,
                            style: Theme.of(context).textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ])),
          ),
        ),
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
              Text(order.shippingAddress?.country ?? '...',
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              Text(order.shippingAddress?.city ?? '...',
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              Text(order.shippingAddress?.street ?? '...',
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              Text(order.shippingAddress?.district ?? '...',
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              Text(order.shippingAddress?.houseDesc ?? '...',
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems / 2),
              Text(order.shippingAddress?.postalCode ?? '...',
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
              const SizedBox(height: HSizes.spaceBtwItems),
              Text(
                "Shipping Notes",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                order.shippingNotes ?? '...',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: HSizes.spaceBtwItems),
              Text(
                "Shipping Company",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                order.shippingCompany,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
