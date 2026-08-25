import 'package:flutter/material.dart';
import 'package:tech_talk/controllers/signin_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class SignUpRow extends StatelessWidget {
  final SigninController controller;
  const SignUpRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?  ",
          style: TextStyle(
            color: Appcolor.muted,
            fontSize: Responsive.sp(0.04),
          ),
        ),
        GestureDetector(
          onTap: controller.goToSignup,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.wp(0.012),
              vertical: Responsive.hp(0.007),
            ),

            child: Text(
              'Sign up',
              style: TextStyle(
                color: Appcolor.accent,
                fontSize: Responsive.sp(0.035),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
