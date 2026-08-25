import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class GlassInputField extends StatelessWidget {
  const GlassInputField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.hp(0.06),

      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.045),
      ),

      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(
          Responsive.wp(0.03),
        ),
        border: Border.all(
          color: Appcolor.panelEdge,
          width: Responsive.wp(0.0025),
        ),
      ),

      child: Center(
        child: TextField(
          controller: controller,
          cursorColor: Appcolor.accent,

          style: TextStyle(
            color: Appcolor.white,
            fontSize: Responsive.sp(0.04),
            fontWeight: FontWeight.w500,
          ),

          decoration: InputDecoration(
            hintText: hintText,

            hintStyle: TextStyle(
              color: Appcolor.muted,
              fontSize: Responsive.sp(0.04),
              fontWeight: FontWeight.w400,
            ),

            border: InputBorder.none,
            isCollapsed: true,
          ),
        ),
      ),
    );
  }
}