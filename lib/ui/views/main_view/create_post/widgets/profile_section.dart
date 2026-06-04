import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/controllers/create_post_controller.dart';
import 'package:teck_talk/core/data/repository/shared_pref.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class ProfileSection extends GetView<CreatePostController> {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: screenWidth(15),
          child: Image.asset(
            "assets/images/png/profile.png",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: screenWidth(30)),
        CustomText(
          text: SharedPreferenceRepository().getUserFullName() ?? 'User',
          styleType: TextStyleType.CUSTOM,
          fontSize: screenWidth(20),
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
