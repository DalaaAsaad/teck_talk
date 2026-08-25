import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class PagerButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;
  const PagerButton({
    super.key,
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override



  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: enabled ? onTap : null,
        child: Container(
          width: screenWidth(10),
          height: screenWidth(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: enabled
                ? Appcolor.white.withAlpha(100)
                : Appcolor.white.withAlpha(50),
            border: Border.all(color: Appcolor.white.withAlpha(50)),
          ),
          child: Icon(
            icon,
            color: enabled ? Appcolor.white : Appcolor.white.withAlpha(50),
          ),
        ),
      ),
    );
  }
}
