import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/signup_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class SubmitButtonSignUp extends StatelessWidget {
  final SignupController controller;
  const SubmitButtonSignUp({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loading = controller.isLoading.value;
      return GestureDetector(
        onTap: loading ? null : controller.signup,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: Responsive.hp(0.07),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: loading
                  ? [
                      Appcolor.accent.withOpacity(0.45),
                      Appcolor.accent.withOpacity(0.3),
                    ]
                  : [
                      Appcolor.accentGradientStart,
                      Appcolor.accent,
                      Appcolor.accentGradientEnd,
                    ],
              stops: loading ? null : const [0.0, 0.45, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: loading
                ? []
                : [
                    BoxShadow(
                      color: Appcolor.accent.withOpacity(0.40),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: Center(
            child: loading
                ? SizedBox(
                    width: Responsive.wp(0.05),
                    height: Responsive.wp(0.1),
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(Appcolor.white),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          color: Appcolor.white,
                          fontSize: Responsive.sp(0.05),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Appcolor.white,
                        size: Responsive.sp(0.05),
                      ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
