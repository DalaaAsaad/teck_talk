import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class ContentPreview extends StatelessWidget {
  final List<String> tableOfContents;
  final Map<String, String> contentMap;

  const ContentPreview({
    super.key,
    required this.tableOfContents,
    required this.contentMap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < 3 && i < tableOfContents.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: screenWidth(28)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: tableOfContents[i],
                  styleType: TextStyleType.CUSTOM,
                  textColor: Appcolor.white,
                  fontSize: screenWidth(20),
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: screenWidth(18)),
                CustomText(
                  text:
                      contentMap[tableOfContents[i]] ??
                      'Content preview for ${tableOfContents[i]}',
                  styleType: TextStyleType.CUSTOM,
                  fontSize: screenWidth(25),
                  textColor: Appcolor.gray_60,
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: screenWidth(40)),
                  height: screenWidth(300),
                  color: Appcolor.gray_60.withAlpha(100),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
