import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/circular_container.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OverviewCard extends StatelessWidget {
  final String title;
  final dynamic value;
  final IconData icon;
  final Color color;
  final bool isNumber;

  const OverviewCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return HRoundedContainer(
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
              HCircularContainer(
                width: 30,
                height: 30,
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, size: 18, color: color),
              ),
            ],
          ),
          const SizedBox(height: HSizes.sm),
          if (isNumber) ...[
            Text(
              HHelperFunctions.formatNumber(value),
              style: Theme.of(context).textTheme.headlineMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ] else ...[
            Text(
              HHelperFunctions.formatCurrency(value),
              style: Theme.of(context).textTheme.headlineMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
