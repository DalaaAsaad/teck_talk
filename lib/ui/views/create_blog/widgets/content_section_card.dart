import 'package:flutter/material.dart';

import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/core/utils/responsive.dart';

class ContentSectionCard extends StatelessWidget {
  const ContentSectionCard({
    super.key,
    required this.title,
    required this.controller,
  });

  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: Responsive.wp(0.035),
          ),
          child: CustomText(
            text: title,
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.white,
            fontSize: Responsive.sp(0.045),
            fontWeight: FontWeight.w600,
          ),
        ),

        Container(
          constraints: BoxConstraints(
            minHeight: Responsive.hp(0.10),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.wp(0.055),
            vertical: Responsive.wp(0.045),
          ),
          decoration: BoxDecoration(
            color: Appcolor.panel,
            borderRadius: BorderRadius.circular(
              Responsive.wp(0.03),
            ),
            border: Border.all(
              color: Appcolor.panelEdge,
              width: Responsive.wp(0.0025),
            ),
          ),

          child: TextField(
            controller: controller,

            maxLines: null,
            minLines: 4,
            cursorColor: Appcolor.accent,

            style: TextStyle(
              color: Appcolor.white,
              fontSize: Responsive.sp(0.04),
              fontWeight: FontWeight.w400,
            ),

            decoration: InputDecoration(
              hintText: 'Write content for this section...',

              hintStyle: TextStyle(
                color: Appcolor.muted,
                fontSize: Responsive.sp(0.04),
                fontWeight: FontWeight.w400,
              ),

              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}