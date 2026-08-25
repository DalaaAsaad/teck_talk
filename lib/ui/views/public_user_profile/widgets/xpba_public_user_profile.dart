import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/controllers/user_profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// نسخة مضغوطة من XP bar: شريط تقدم رفيع + رقم النقاط جنبه بسطر واحد，
/// بدل تسمية عائمة فوق الشريط + سطر min/max تحته (كانت 3 عناصر بصرية).
class XpbaPublicUserProfile extends GetView<UserProfileController> {
  const XpbaPublicUserProfile({super.key});

  static const int maxXP = 10000;

  @override
  Widget build(BuildContext context) {
    final currentXP = controller.profileData.value?.data.rankingPoints ?? 0;
    final progress = (currentXP / maxXP).clamp(0.0, 1.0);

    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                height: Responsive.hp(0.01),
                decoration: BoxDecoration(
                  color: Appcolor.panel,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Appcolor.panelEdge.withOpacity(0.6),
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: Responsive.hp(0.01),
                  decoration: BoxDecoration(
                    color: Appcolor.accent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: Responsive.wp(0.02)),
        CustomText(
          text: '$currentXP xp',
          styleType: TextStyleType.CUSTOM,
          textColor: Appcolor.accent,
          fontSize: Responsive.sp(0.028),
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
