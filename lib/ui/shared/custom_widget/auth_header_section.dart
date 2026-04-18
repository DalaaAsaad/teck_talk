import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class AuthHeaderSection extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthHeaderSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Appcolor.yellow_70,
                blurRadius: 50,
                spreadRadius: -40,
                offset: const Offset(0, -50),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: screenWidth(6)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/logo.svg',
                    height: screenWidth(15),
                  ),
                  SizedBox(width: screenWidth(40)),
                  CustomText(text: "Tech Talk", styleType: TextStyleType.BODY),
                ],
              ),
              SizedBox(height: screenWidth(15)),
              CustomText(
                text: title,
                styleType: TextStyleType.CUSTOM,
                fontSize: screenWidth(15),
              ),

              CustomText(
                text: subtitle,
                styleType: TextStyleType.CUSTOM,
                fontSize: screenWidth(30),
                textColor: Appcolor.gray_95.withAlpha(150),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
