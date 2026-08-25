import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class UsetInfoHeader extends StatelessWidget {
  final String nameProfile;
  final String imageProfile;
  final String date;
  final bool? isDraft;
  final VoidCallback moveToUserProfile;
  const UsetInfoHeader({
    super.key,
    required this.nameProfile,
    required this.date,
    required this.imageProfile,
    this.isDraft,
    required this.moveToUserProfile,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: moveToUserProfile,
      child: Row(
        children: [
          CircleAvatar(
            radius: Responsive.sp(0.05),
            backgroundImage: imageProfile.isNotEmpty
                ? NetworkImage(imageProfile)
                : const AssetImage("assets/images/png/user.png") as ImageProvider,
          ),
          SizedBox(width: Responsive.wp(0.03)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    text: nameProfile,
                    styleType: TextStyleType.CUSTOM,
                    fontSize: Responsive.sp(0.03),
                    fontWeight: FontWeight.w700,
                  ),
                  if (isDraft == true)
                    CustomText(
                      text: " (Draft)",
                      styleType: TextStyleType.SMALL,
                      fontSize: Responsive.sp(0.025),
                      textColor: Appcolor.gray_60,
                      fontWeight: FontWeight.w700,
                    ),
                ],
              ),
              CustomText(
                text: date,
                styleType: TextStyleType.CUSTOM,
                fontSize: Responsive.sp(0.03),
                fontWeight: FontWeight.w200,
              ),
            ],
          ),
          // SizedBox(width: screenWidth(9)),
        ],
      ),
    );
  }
}
