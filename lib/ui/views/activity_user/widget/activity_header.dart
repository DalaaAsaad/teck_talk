import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class ActivityHeader extends StatelessWidget {
  const ActivityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: Get.back,
          child: Container(
            width: screenWidth(12),
            height: screenWidth(12),
            margin: EdgeInsetsDirectional.symmetric(
              horizontal: screenWidth(28),
            ),
            decoration: BoxDecoration(
              color: Appcolor.dark_20.withAlpha(180),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Appcolor.gray_95,
              size: screenWidth(20),
            ),
          ),
        ),
        SizedBox(width: screenWidth(28)),
        CustomText(
          text: 'My Activity',
          styleType: TextStyleType.CUSTOM,
          textColor: Appcolor.white,
          fontSize: screenWidth(20),
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
