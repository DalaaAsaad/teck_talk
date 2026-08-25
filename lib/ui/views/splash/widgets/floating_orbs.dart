import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class FloatingOrbs extends StatelessWidget {
  const FloatingOrbs();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: Responsive.hp(0.12),
          left: Responsive.wp(0.10),
          child: _glowOrb(160, Appcolor.accent.withOpacity(0.10)),
        ),
        Positioned(
          bottom: Responsive.hp(0.16),
          right: Responsive.wp(0.08),
          child: _glowOrb(220, Appcolor.accent.withOpacity(0.07)),
        ),
        Positioned(
          top: Responsive.hp(0.45),
          right: Responsive.wp(0.20),
          child: _glowOrb(120, Appcolor.success.withOpacity(0.05)),
        ),
      ],
    );
  }
}

Widget _glowOrb(double diameter, Color color) {
  return Container(
    width: diameter,
    height: diameter,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(colors: [color, color.withOpacity(0)]),
    ),
  );
}
