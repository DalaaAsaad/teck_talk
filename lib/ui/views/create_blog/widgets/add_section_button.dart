import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/core/utils/responsive.dart';

class AddSectionButton extends StatelessWidget {
  const AddSectionButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,

        style: OutlinedButton.styleFrom(
          backgroundColor: Appcolor.accentDim,

          side: BorderSide(
            color: Appcolor.accent.withAlpha(140),
            width: Responsive.wp(0.0025),
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Responsive.wp(0.025)),
          ),

          // padding: EdgeInsets.symmetric(
          //   horizontal: Responsive.wp(0.0010),
          //   vertical: Responsive.wp(0.03),
          // ),
        ),

        icon: Icon(
          Icons.add_rounded,
          color: Appcolor.accent,
          size: Responsive.sp(0.055),
        ),

        label: CustomText(
          text: 'Add new section',
          styleType: TextStyleType.CUSTOM,
          textColor: Appcolor.white,
          fontSize: Responsive.sp(0.037),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
