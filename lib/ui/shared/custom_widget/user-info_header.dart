import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class UsetInfoHeader extends StatelessWidget {
  final String nameProfile;
  final String imageProfile;
  final String date;
  final bool? isDraft;
  const UsetInfoHeader({
    super.key,
    required this.nameProfile,
    required this.date,
    required this.imageProfile,
    this.isDraft,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: screenWidth(18),
          backgroundImage: imageProfile.isNotEmpty
              ? NetworkImage(imageProfile)
              : const AssetImage("assets/images/png/user.png") as ImageProvider,
        ),
        SizedBox(width: screenWidth(50)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: nameProfile,
                  styleType: TextStyleType.CUSTOM,
                  fontSize: screenWidth(25),
                  fontWeight: FontWeight.w700,
                ),
                if (isDraft == true)
                  CustomText(
                    text: " (Draft)",
                    styleType: TextStyleType.SMALL,
                    fontSize: screenWidth(25),
                    textColor: Appcolor.gray_60,
                    fontWeight: FontWeight.w700,
                  ),
              ],
            ),
            CustomText(
              text: date,
              styleType: TextStyleType.CUSTOM,
              fontSize: screenWidth(30),
              fontWeight: FontWeight.w200,
            ),
          ],
        ),
        // SizedBox(width: screenWidth(9)),
      ],
    );
  }
}
