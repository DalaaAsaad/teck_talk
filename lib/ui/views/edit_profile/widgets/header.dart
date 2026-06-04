import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class Header extends StatelessWidget {
  const Header({required this.onSavePressed});

  final VoidCallback onSavePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back, color: Appcolor.yellow_70),
        ),
        CustomText(
          text: 'Back',
          styleType: TextStyleType.CUSTOM,
          textColor: Appcolor.white,
          fontSize: screenWidth(20),
          fontWeight: FontWeight.w600,
        ),
        Expanded(
          child: Align(
            alignment: AlignmentGeometry.center,
            child: CustomText(
              text: 'Edit Profile',
              styleType: TextStyleType.CUSTOM,
              textColor: Appcolor.white,
              fontSize: screenWidth(20),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: screenWidth(9),
          child: OutlinedButton(
            onPressed: onSavePressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Appcolor.yellow_70),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: CustomText(
              text: 'Save',
              styleType: TextStyleType.CUSTOM,
              textColor: Appcolor.white,
              fontSize: screenWidth(20),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
