import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// كارد متداخل جوّا ElevatedCard - خلفيته Appcolor.bg (أغمق من panel)
/// حتى يعطي إحساس التداخل (nested) بدل ما يبين مسطح فوق نفس اللون.
class TableOfContentsCard extends StatelessWidget {
  final List<String> tableOfContents;

  const TableOfContentsCard({super.key, required this.tableOfContents});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.04),
        vertical: Responsive.hp(0.018),
      ),
      decoration: BoxDecoration(
        color: Appcolor.bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Appcolor.panelEdge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(tableOfContents.length, (index) {
          final section = tableOfContents[index];
          final isLast = index == tableOfContents.length - 1;

          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : Responsive.hp(0.018)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: Responsive.wp(0.06),
                  height: Responsive.wp(0.06),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Appcolor.accentDim,
                    shape: BoxShape.circle,
                  ),
                  child: CustomText(
                    text: '${index + 1}',
                    styleType: TextStyleType.CUSTOM,
                    textColor: Appcolor.accent,
                    fontSize: Responsive.sp(0.03),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: Responsive.wp(0.03)),
                Expanded(
                  child: CustomText(
                    text: section,
                    styleType: TextStyleType.CUSTOM,
                    textColor: Appcolor.white,
                    fontSize: Responsive.sp(0.037),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Appcolor.muted,
                  size: Responsive.sp(0.04),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}