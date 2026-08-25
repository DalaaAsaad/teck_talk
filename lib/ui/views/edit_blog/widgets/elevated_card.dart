import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// كارد موحّد بعنوان صغير وشريط أكسنت جنبو، بظل خفيف يعطي إحساس العمق
/// (Layered/Elevated). مستخدم بشاشتي Create Blog و Edit Blog حتى يكون
/// الشكل العام موحد بين الشاشتين.
class ElevatedCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const ElevatedCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.wp(0.04)),
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Appcolor.panelEdge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 3,
                    height: Responsive.hp(0.018),
                    decoration: BoxDecoration(
                      color: Appcolor.accent,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  SizedBox(width: Responsive.wp(0.02)),
                  CustomText(
                    text: title.toUpperCase(),
                    styleType: TextStyleType.CUSTOM,
                    textColor: Appcolor.muted,
                    fontSize: Responsive.sp(0.032),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              if (trailing != null) trailing!,
            ],
          ),
          SizedBox(height: Responsive.hp(0.018)),
          child,
        ],
      ),
    );
  }
}