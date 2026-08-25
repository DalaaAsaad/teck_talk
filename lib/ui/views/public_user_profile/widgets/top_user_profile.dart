import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/user_profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/public_user_profile/widgets/block_button.dart';

class TopUserProfile extends GetView<UserProfileController> {
  const TopUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = controller.profileData.value;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomText(
            text: profile?.data.username ?? "",
            styleType: TextStyleType.CUSTOM,
            fontSize: Responsive.sp(0.05),
            fontWeight: FontWeight.w500,
            textColor: Appcolor.muted,
          ),
        ),
        const BlockButton(),
      ],
    );
  }
}