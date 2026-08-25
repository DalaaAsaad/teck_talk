import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';


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
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              bottom: i == (tableOfContents.length > 3 ? 2 : tableOfContents.length - 1)
                  ? 0
                  : Responsive.hp(0.02),
            ),
            padding: EdgeInsets.all(Responsive.wp(0.04)),
            decoration: BoxDecoration(
              color: Appcolor.bg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Appcolor.panelEdge),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: Responsive.wp(0.07),
                      height: Responsive.wp(0.07),
                      decoration: BoxDecoration(
                        color: Appcolor.accentDim,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: CustomText(
                        text: '${i + 1}',
                        styleType: TextStyleType.CUSTOM,
                        textColor: Appcolor.accent,
                        fontSize: Responsive.sp(0.032),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: Responsive.wp(0.028)),
                    Expanded(
                      child: CustomText(
                        text: tableOfContents[i],
                        styleType: TextStyleType.CUSTOM,
                        textColor: Appcolor.white,
                        fontSize: Responsive.sp(0.04),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.hp(0.016)),
                CustomText(
                  text:
                      contentMap[tableOfContents[i]] ??
                      'Content preview for ${tableOfContents[i]}',
                  styleType: TextStyleType.CUSTOM,
                  fontSize: Responsive.sp(0.036),
                  textColor: Appcolor.muted,
                ),
              ],
            ),
          ),
      ],
    );
  }
}