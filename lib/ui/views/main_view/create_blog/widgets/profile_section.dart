import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class ProfileSection extends StatelessWidget {
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
          text: "nameProfile",
          styleType: TextStyleType.CUSTOM,
          fontSize: screenWidth(20),
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
