import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';

/// Widget for displaying action buttons for table rows
class HTableActionButtons extends StatelessWidget {
  const HTableActionButtons({
    super.key,
    this.view = false,
    this.edit = true,
    this.delete = true,
    this.onViewPressed,
    this.onEditPressed,
    this.onDeletePressed,
  });

  /// Flag to determine whether the view button is enabled
  final bool view;

  /// Flag to determine whether the edit button is enabled
  final bool edit;

  /// Flag to determine whether the delete button is enabled
  final bool delete;

  /// Callback function for when the view button is pressed
  final VoidCallback? onViewPressed;

  /// Callback function for when the edit button is pressed
  final VoidCallback? onEditPressed;

  /// Callback function for when the delete button is pressed
  final VoidCallback? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (view)
          IconButton(
            onPressed: onViewPressed,
            icon: const Icon(Iconsax.eye, color: HColors.darkerGrey),
          ),
        if (edit)
          IconButton(
            onPressed: onEditPressed,
            icon: const Icon(Iconsax.pen_add, color: HColors.primary),
          ),
        if (delete)
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Iconsax.trash, color: HColors.error),
          ),
      ],
    );
  }
}
