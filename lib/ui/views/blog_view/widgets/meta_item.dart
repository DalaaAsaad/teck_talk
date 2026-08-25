import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class MetaItem extends StatelessWidget {
  const MetaItem({
    super.key,
    required this.title,
    required this.value,
    this.icon,
  });

  final String title;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: Responsive.sp(0.036), color: Appcolor.accent),
              SizedBox(width: Responsive.wp(0.014)),
            ],
            CustomText(
              text: title,
              styleType: TextStyleType.CUSTOM,
              textColor: Appcolor.muted,
              fontSize: Responsive.sp(0.03),
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        SizedBox(height: Responsive.hp(0.008)),
        CustomText(
          text: value.isEmpty ? '—' : value,
          styleType: TextStyleType.CUSTOM,
          textColor: Appcolor.white,
          fontSize: Responsive.sp(0.037),
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}