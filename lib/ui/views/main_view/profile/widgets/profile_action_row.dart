import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// Edit profile ممدد لوحدو بكامل العرض، وShare صارت أيقونة دائرية صغيرة
/// جنبه (بدل زر نصي ياخد نص الصف).
class ProfileActionRow extends GetView<ProfileController> {
  const ProfileActionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: Responsive.hp(0.048),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(
                  AppRoutes.editProfile,
                  arguments: {
                    'isOnboarding': false,
                    'profile': controller.profileData.value,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.accent,
                foregroundColor: Appcolor.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: CustomText(
                text: 'Edit profile',
                styleType: TextStyleType.CUSTOM,
                textColor: Appcolor.white,
                fontSize: Responsive.sp(0.033),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: Responsive.wp(0.025)),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => AppSnackBar.success('Profile link shared'),
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: Responsive.hp(0.048),
              height: Responsive.hp(0.048),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Appcolor.panel,
                shape: BoxShape.circle,
                border: Border.all(color: Appcolor.panelEdge.withOpacity(0.6)),
              ),
              child: Icon(
                Icons.share_rounded,
                color: Appcolor.white,
                size: Responsive.sp(0.045),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
