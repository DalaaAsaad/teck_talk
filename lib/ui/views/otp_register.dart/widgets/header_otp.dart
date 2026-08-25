import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class HeaderOtp extends StatelessWidget {
  final String email;
  const HeaderOtp({required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [Appcolor.white, Appcolor.accentGradientStart],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(b),
          child: Text(
            'Verify Your Email',
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
          'We\'ve sent a 6-digit verification code to :',
          style: TextStyle(
            color: Appcolor.muted,
            fontSize: Responsive.sp(0.05),
            height: 1.6,
          ),
        ),
        SizedBox(height: Responsive.hp(0.05)),
        // email pill
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.mail_outline_rounded,
                color: Appcolor.accent,
                size: Responsive.sp(0.09),
              ),
              SizedBox(width: Responsive.wp(0.02)),
              Text(
                email,
                style: TextStyle(
                  color: Appcolor.accent,
                  fontSize: Responsive.sp(0.05),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
