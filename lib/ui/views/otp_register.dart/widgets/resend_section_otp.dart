import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/otp_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class ResendSectionOtp extends StatelessWidget {
  final OtpController controller;
  const ResendSectionOtp({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Appcolor.panelEdge),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // timer
          Obx(
            () => Row(
              children: [
                Container(
                  width: Responsive.wp(0.092),
                  height: Responsive.hp(0.05),
                  decoration: BoxDecoration(
                    color: Appcolor.accentDim,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:  Icon(
                    Icons.timer_outlined,
                    color: Appcolor.accent,
                    size: Responsive.sp(0.05),
                  ),
                ),
                SizedBox(width: Responsive.wp(0.02)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resend in',
                      style: TextStyle(
                        color: Appcolor.muted,
                        fontSize: Responsive.sp(0.03),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '00:${controller.resendSeconds.value.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: Appcolor.white,
                        fontSize: Responsive.sp(0.05),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // resend button
          Obx(() {
            final canResend = controller.canResend.value;
            return GestureDetector(
              onTap: canResend ? controller.resendOtp : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.wp(0.035),
                  vertical: Responsive.hp(0.015),
                ),
                decoration: BoxDecoration(
                  color: canResend ? Appcolor.accentDim : Appcolor.panelEdge,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: canResend
                        ? Appcolor.accent.withOpacity(0.35)
                        : Colors.transparent,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.refresh_rounded,
                      color: canResend ? Appcolor.accent : Appcolor.label,
                      size: Responsive.sp(0.05),
                    ),
                    SizedBox(width: Responsive.wp(0.02)),
                    Text(
                      'Resend Code',
                      style: TextStyle(
                        color: canResend ? Appcolor.accent : Appcolor.label,
                        fontSize: Responsive.sp(0.04),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
