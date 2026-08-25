import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class MetricChip extends StatelessWidget {
  const MetricChip({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.wp(0.03),
            vertical: Responsive.hp(0.012),
          ),
          decoration: BoxDecoration(
            color: isActive ? iconColor.withOpacity(0.12) : Appcolor.panel,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isActive
                  ? iconColor.withOpacity(0.5)
                  : Appcolor.panelEdge,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: Responsive.sp(0.045), color: iconColor),
              if (label.isNotEmpty) ...[
                SizedBox(width: Responsive.wp(0.014)),
                CustomText(
                  text: label,
                  styleType: TextStyleType.CUSTOM,
                  textColor: isActive ? iconColor : Appcolor.muted,
                  fontSize: Responsive.sp(0.032),
                  fontWeight: FontWeight.w600,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}