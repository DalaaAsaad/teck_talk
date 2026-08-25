import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class TitleChatbot extends StatelessWidget {
  const TitleChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        end: Responsive.wp(0.045),
        top: Responsive.hp(0.01),
      ),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Appcolor.white,
              size: Responsive.sp(0.06),
            ),
          ),
          CustomText(
            text: "Your tech AI assistant",
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.white,
            fontSize: Responsive.sp(0.06),
            fontWeight: FontWeight.w700,
          ),
          SizedBox(width: Responsive.wp(0.02)),
          Container(
            width: Responsive.wp(0.02),
            height: Responsive.hp(0.02),
            decoration: const BoxDecoration(
              color: Appcolor.success,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
