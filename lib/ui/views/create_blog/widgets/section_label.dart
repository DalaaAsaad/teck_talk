import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text.toUpperCase(),
      styleType: TextStyleType.CUSTOM,
      textColor: Appcolor.gray_60,
      fontSize: screenWidth(20),
      fontWeight: FontWeight.w400,
    );
  }
}
