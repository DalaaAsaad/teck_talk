import 'package:flutter/material.dart';
import 'package:tech_talk/controllers/otp_controller.dart';
import 'package:tech_talk/ui/views/otp_register.dart/widgets/otp_cell.dart';

class OtpBoxes extends StatelessWidget {
  final OtpController controller;
  const OtpBoxes({required this.controller});

  @override
  Widget build(BuildContext context) {
    final boxSize = (MediaQuery.of(context).size.width - 48 - 5 * 10) / 6;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (i) {
        return Padding(
          padding: EdgeInsets.only(right: i < 5 ? 10 : 0),
          child: OtpCell(
            ctrl: controller.otpControllers[i],
            focusNode: controller.otpFocusNodes[i],
            onChanged: (v) => controller.handleOtpInput(i, v),
            size: boxSize,
          ),
        );
      }),
    );
  }
}