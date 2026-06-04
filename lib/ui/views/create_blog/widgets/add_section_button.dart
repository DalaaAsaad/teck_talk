import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class AddSectionButton extends StatelessWidget {
  const AddSectionButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Appcolor.yellow_70),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth(40),
          vertical: screenWidth(40),
        ),
      ),
      icon: const Icon(Icons.add, color: Appcolor.yellow_70),
      label: CustomText(
        text: 'Add new section',
        styleType: TextStyleType.CUSTOM,
        textColor: Appcolor.white,
        fontSize: screenWidth(28),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
