import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class SignInRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?  ',
          style: TextStyle(
            color: Appcolor.muted,
            fontSize: Responsive.sp(0.04),
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.signin),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.wp(0.012),
              vertical: Responsive.hp(0.007),
            ),
            child: Text(
              'Sign in',
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
