import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.wp(0.04)),
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Appcolor.panelEdge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                text: title,
                styleType: TextStyleType.CUSTOM,
                textColor: Appcolor.white,
                fontSize: Responsive.sp(0.038),
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          SizedBox(height: Responsive.hp(0.018)),
          child,
        ],
      ),
    );
  }
}