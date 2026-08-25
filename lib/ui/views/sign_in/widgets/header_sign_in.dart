import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class HeaderSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Responsive.hp(0.1)),
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [Appcolor.white, Appcolor.accentGradientStart],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(b),
          child: Text(
            'Welcome Back',
            style: TextStyle(
              color: Appcolor.white,
              fontSize: Responsive.sp(0.09),
              fontWeight: FontWeight.w800,
              height: 1.18,
              letterSpacing: -0.8,
            ),
          ),
        ),
        SizedBox(height: Responsive.hp(0.01)),
        Text(
          'Sign in to continue your journey with the TechTalk community.',
          style: TextStyle(
            color: Appcolor.muted,
            fontSize: Responsive.sp(0.04),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
