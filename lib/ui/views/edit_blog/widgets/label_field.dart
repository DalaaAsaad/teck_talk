import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const LabeledField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          styleType: TextStyleType.CUSTOM,
          textColor: Appcolor.muted,
          fontSize: Responsive.sp(0.032),
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: Responsive.hp(0.008)),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(
            color: Appcolor.white,
            fontSize: Responsive.sp(0.037),
          ),
          cursorColor: Appcolor.accent,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Appcolor.muted.withOpacity(0.6),
              fontSize: Responsive.sp(0.037),
            ),
            filled: true,
            fillColor: Appcolor.bg,
            contentPadding: EdgeInsets.symmetric(
              horizontal: Responsive.wp(0.035),
              vertical: Responsive.hp(0.016),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Appcolor.panelEdge),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Appcolor.panelEdge),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Appcolor.accent, width: 1.4),
            ),
          ),
        ),
      ],
    );
  }
}