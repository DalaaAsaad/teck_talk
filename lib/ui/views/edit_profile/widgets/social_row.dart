import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class SocialRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final String hint;
  const SocialRow({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Appcolor.panelEdge),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.wp(0.1),
            height: Responsive.hp(0.05),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: iconColor, size: Responsive.sp(0.07)),
          ),
          SizedBox(width: Responsive.wp(0.05)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    color: Appcolor.label,
                    fontSize: Responsive.sp(0.03),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.3,
                  ),
                ),
                SizedBox(height: Responsive.hp(0.005)),
                TextField(
                  style: TextStyle(
                    color: Appcolor.white,
                    fontSize: Responsive.sp(0.03),
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: Appcolor.label.withOpacity(0.5),
                      fontSize: Responsive.sp(0.03),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.open_in_new_rounded,
            color: Appcolor.muted,
            size: Responsive.sp(0.06),
          ),
        ],
      ),
    );
  }
}
