import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/intro/intro_controller.dart';

class GetStartedButton extends StatelessWidget {
  final IntroController controller;
  const GetStartedButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: controller.navigateToSignin,
        onTapDown: (_) => controller.isPressed.value = true,
        onTapUp: (_) => controller.isPressed.value = false,
        onTapCancel: () => controller.isPressed.value = false,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          scale: controller.isPressed.value ? 0.97 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            height: Responsive.hp(0.07),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: controller.isPressed.value
                  ? LinearGradient(
                      colors: [Appcolor.accent, Appcolor.accentLight],
                    )
                  : LinearGradient(
                      colors: [Appcolor.accentLight, Appcolor.accent],
                    ),
              boxShadow: [
                BoxShadow(
                  color: Appcolor.accent.withOpacity(
                    controller.isPressed.value ? 0.2 : 0.4,
                  ),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get Started',
                    style: TextStyle(
                      color: Appcolor.white,
                      fontSize: Responsive.sp(0.06),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(width: Responsive.wp(0.02)),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Appcolor.white,
                    size: Responsive.sp(0.06),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
