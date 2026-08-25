import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: Responsive.hp(0.018),
          decoration: BoxDecoration(
            color: Appcolor.accent,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: Responsive.wp(0.02)),
        CustomText(
          text: title,
          styleType: TextStyleType.CUSTOM,
          fontSize: Responsive.sp(0.04),
          fontWeight: FontWeight.w700,
          textColor: Appcolor.white,
        ),
      ],
    );
  }
}