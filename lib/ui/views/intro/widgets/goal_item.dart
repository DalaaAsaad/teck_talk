import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class GoalItem extends StatelessWidget {
  final String text;
  const GoalItem({required this.text});

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: Responsive.wp(0.05),
            height: Responsive.wp(0.05),
            decoration: BoxDecoration(
              color: Appcolor.accent.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: Appcolor.accent,
              size: Responsive.sp(0.04),
            ),
          ),
          SizedBox(width: Responsive.wp(0.05)),
          Text(
            text,
            style: TextStyle(
              color: Appcolor.white,
              fontSize: Responsive.sp(0.04),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
