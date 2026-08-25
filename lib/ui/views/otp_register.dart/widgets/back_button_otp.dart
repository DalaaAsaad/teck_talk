import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class BackButtonOtp extends StatelessWidget {
  final VoidCallback onTap;
  const BackButtonOtp({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Responsive.wp(0.15),
        height: Responsive.hp(0.06),
        decoration: BoxDecoration(
          color: Appcolor.panel,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Appcolor.panelEdge),
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          color: Appcolor.accent,
          size: Responsive.sp(0.09),
        ),
      ),
    );
  }
}
