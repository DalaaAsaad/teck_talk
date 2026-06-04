import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          _getSectionIcon(title),
          color: Appcolor.yellow_70,
          size: screenWidth(12),
        ),
        SizedBox(width: screenWidth(40)),
        CustomText(
          text: title,
          styleType: TextStyleType.CUSTOM,
          fontSize: screenWidth(18),
        ),
        SizedBox(width: screenWidth(60)),
        CustomText(
          text: "(Optional)",
          styleType: TextStyleType.SMALL,
          textColor: Appcolor.white.withAlpha(180),
          fontSize: screenWidth(19),
        ),
      ],
    );
  }
}

IconData _getSectionIcon(String section) {
  switch (section) {
    case "Code":
      return Icons.code;
    case "Images":
      return Icons.photo_outlined;
    case "Topics":
      return Icons.grid_3x3;
    default:
      return Icons.help;
  }
}
