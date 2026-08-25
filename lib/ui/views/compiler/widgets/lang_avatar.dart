import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class LangAvatar extends StatelessWidget {
  const LangAvatar({
    super.key,
    required this.label,
    required this.selected,
    this.size,
  });

  final String label;
  final bool selected;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? Responsive.wp(0.08);

    return Container(
      width: avatarSize,
      height: avatarSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Appcolor.accent : Appcolor.panelEdge,
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        child: Padding(
          padding: EdgeInsets.all(Responsive.wp(0.01)),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Appcolor.muted,
              fontSize: Responsive.sp(0.028),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
