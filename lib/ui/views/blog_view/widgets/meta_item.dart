import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class MetaItem extends StatelessWidget {
  const MetaItem({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          styleType: TextStyleType.CUSTOM,
          textColor: Appcolor.gray_60,
          fontSize: screenWidth(30),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: screenWidth(100)),
        CustomText(
          text: value,
          styleType: TextStyleType.CUSTOM,
          textColor: Appcolor.white,
          fontSize: screenWidth(25),
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
