import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/circular_container.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';

class OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const OverviewCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
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
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
