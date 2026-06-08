import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class BioProfile extends GetView<ProfileController> {
  const BioProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text:  controller.profileData.value?.bio ?? "",
      styleType: TextStyleType.CUSTOM,
      fontSize: screenWidth(30),
      textColor: Appcolor.white.withAlpha(150),
    );
  }
}
