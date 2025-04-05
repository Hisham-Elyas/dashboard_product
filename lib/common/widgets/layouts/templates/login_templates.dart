import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/spacing_styles.dart';

class HLoginTemplates extends StatelessWidget {
  final Widget child;
  const HLoginTemplates({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: HSpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
                color: HHelperFunctions.isDarkMode(context)
                    ? HColors.darkerGrey
                    : HColors.white,
                borderRadius: BorderRadius.circular(HSizes.cardRadiusLg)),
            child: child,
          ),
        ),
      ),
    );
  }
}
