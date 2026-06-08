import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class MetricChip extends StatelessWidget {
  const MetricChip({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(22),
          vertical: screenWidth(34),
        ),
        decoration: BoxDecoration(
          color: Appcolor.Black_05,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Appcolor.dark_20.withAlpha(140)),
        ),
        child: Row(
          children: [
            Icon(icon, size: screenWidth(18), color: iconColor),
            SizedBox(width: screenWidth(34)),
            CustomText(
              text: label,
              styleType: TextStyleType.CUSTOM,
              textColor: Appcolor.white,
              fontSize: screenWidth(28),
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
