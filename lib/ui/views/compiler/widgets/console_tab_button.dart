import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class ConsoleTabButton extends StatelessWidget {
  const ConsoleTabButton({
    super.key,
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
    this.dotColor,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final color = active ? Appcolor.accent : Appcolor.muted;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Responsive.hp(0.012)),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? Appcolor.accent : Colors.transparent,
                width: Responsive.wp(0.005),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: Responsive.sp(0.04), color: color),
              SizedBox(width: Responsive.wp(0.015)),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: Responsive.sp(0.038),
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (dotColor != null) ...[
                SizedBox(width: Responsive.wp(0.015)),
                Container(
                  width: Responsive.wp(0.015),
                  height: Responsive.wp(0.015),
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
