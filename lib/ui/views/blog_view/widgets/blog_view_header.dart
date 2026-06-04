import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class BlogViewHeader extends StatelessWidget {
  final String heroImage;
  final String title;
  final String subTitle;

  const BlogViewHeader({
    super.key,
    required this.heroImage,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenWidth(1.4),
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(heroImage, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha(30),
                  Colors.black.withAlpha(90),
                  Appcolor.black_08.withAlpha(235),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: screenWidth(16),
              end: screenWidth(16),
              top: screenWidth(2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(text: title, styleType: TextStyleType.TITLE),
                CustomText(text: subTitle, styleType: TextStyleType.SUBTITLE),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
