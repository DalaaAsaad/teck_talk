import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

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
          padding: EdgeInsets.only(bottom: screenWidth(14)),
          child: CustomText(
            text: title,
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.white,
            fontSize: screenWidth(26),
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          constraints: BoxConstraints(minHeight: screenWidth(4.2)),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth(22),
            vertical: screenWidth(18),
          ),
          decoration: BoxDecoration(
            color: Appcolor.black_08,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Appcolor.dark_20.withAlpha(100)),
          ),
          child: TextField(
            controller: controller,
            maxLines: null,
            minLines: 4,
            style: TextStyle(
              color: Appcolor.white,
              fontSize: screenWidth(24),
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: 'Write content for this section...',
              hintStyle: TextStyle(
                color: Appcolor.gray_60.withAlpha(180),
                fontSize: screenWidth(24),
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