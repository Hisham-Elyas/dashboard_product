import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/circular_container.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';

class MiniStatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const MiniStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return HRoundedContainer(
      padding: const EdgeInsets.all(HSizes.defaultSpace),
      child: Row(
        children: [
          HCircularContainer(
            width: 20,
            height: 20,
            backgroundColor: color,
          ),
          const SizedBox(width: HSizes.lg),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.labelMedium),
              Text(value, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ],
      ),
    );
  }
}
