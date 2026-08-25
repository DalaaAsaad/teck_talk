import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class EyeBtnSignUp extends StatelessWidget {
  final bool visible;
  final VoidCallback onTap;
  const EyeBtnSignUp({required this.visible, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, anim) =>
            ScaleTransition(scale: anim, child: child),
        child: Icon(
          visible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          key: ValueKey(visible),
          color: Appcolor.muted,
          size: Responsive.sp(0.07),
        ),
      ),
    );
  }
}
