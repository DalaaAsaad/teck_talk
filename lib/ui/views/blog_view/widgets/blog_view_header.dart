import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

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

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              AutoSizeText(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Appcolor.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                minFontSize: 14,
                overflow: TextOverflow.ellipsis,
              ),
              AutoSizeText(
                subTitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Appcolor.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                minFontSize: 14,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
