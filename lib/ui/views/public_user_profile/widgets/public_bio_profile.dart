import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/user_profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class PublicBioProfile extends GetView<UserProfileController> {
  const PublicBioProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final bio = controller.profileData.value?.data.bio ?? "";
    if (bio.isEmpty) return const SizedBox.shrink();
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: CustomText(
        text: bio,
        styleType: TextStyleType.CUSTOM,
        fontSize: Responsive.sp(0.033),
        fontWeight: FontWeight.w400,
        textColor: Appcolor.muted,
      ),
    );
  }
}
