import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class SocialLinkField extends StatelessWidget {
  final Widget icon;
  final Color iconColor;
  final String hint;
  final TextEditingController controller;

  const SocialLinkField({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.035),
        vertical: Responsive.hp(0.004),
      ),
      decoration: BoxDecoration(
        color: Appcolor.bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Appcolor.panelEdge),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.wp(0.09),
            height: Responsive.wp(0.09),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconTheme(
              data: IconThemeData(color: iconColor, size: Responsive.sp(0.045)),
              child: icon,
            ),
          ),
          SizedBox(width: Responsive.wp(0.03)),
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: Appcolor.accent,
              style: TextStyle(
                color: Appcolor.white,
                fontSize: Responsive.sp(0.036),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  color: Appcolor.muted,
                  fontSize: Responsive.sp(0.034),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
