import 'package:flutter/material.dart';

import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Responsive.wp(0.011),
          height: Responsive.wp(0.032),
          decoration: BoxDecoration(
            color: Appcolor.accent,
            borderRadius: BorderRadius.circular(Responsive.wp(0.01)),
          ),
        ),
        SizedBox(width: Responsive.wp(0.02)),
        CustomText(
          text: text.toUpperCase(),
          styleType: TextStyleType.CUSTOM,
          textColor: Appcolor.muted,
          fontSize: Responsive.sp(0.042),
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
