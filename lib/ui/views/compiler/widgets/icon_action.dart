import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class IconAction extends StatelessWidget {
  const IconAction({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Responsive.wp(0.025)),
        decoration: BoxDecoration(
          color: Appcolor.panel,
          borderRadius: BorderRadius.circular(Responsive.wp(0.035)),
          border: Border.all(
            color: Appcolor.panelEdge,
            width: Responsive.wp(0.002),
          ),
        ),
        child: Icon(icon, size: Responsive.sp(0.045), color: Appcolor.muted),
      ),
    );
  }
}
