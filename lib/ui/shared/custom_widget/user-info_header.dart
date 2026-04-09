import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class UsetInfoHeader extends StatelessWidget {
  final String nameProfile;
  final String imageProfile;
  final String date;
  const UsetInfoHeader({
    super.key,
    required this.nameProfile,
    required this.date,
    required this.imageProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: screenWidth(15),
          child: Image.asset(
            imageProfile,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: screenWidth(50)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: nameProfile,
              styleType: TextStyleType.CUSTOM,
              fontSize: screenWidth(20),
              fontWeight: FontWeight.w700,
            ),
            CustomText(
              text: date,
              styleType: TextStyleType.CUSTOM,
              fontSize: screenWidth(25),
              fontWeight: FontWeight.w200,
            ),
          ],
        ),
        SizedBox(width: screenWidth(9)),
      ],
    );
  }
}
