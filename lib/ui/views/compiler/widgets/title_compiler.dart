import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class TitleCompiler extends StatelessWidget {
  const TitleCompiler({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Online Compiler',
          style: TextStyle(
            color: Appcolor.white,
            fontSize: Responsive.sp(0.05),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Responsive.hp(0.005)),
        Text(
          'Write, run, and test your code',
          style: TextStyle(
            color: Appcolor.muted,
            fontSize: Responsive.sp(0.035),
          ),
        ),
      ],
    );
  }
}
