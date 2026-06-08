import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title, required this.size});

  final String title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: title,
      styleType: TextStyleType.CUSTOM,
      textColor: Appcolor.gray_60,
      fontSize: screenWidth(size),
      fontWeight: FontWeight.w400,
    );
  }
}
