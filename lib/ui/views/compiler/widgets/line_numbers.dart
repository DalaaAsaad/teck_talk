import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class LineNumbers extends StatelessWidget {
  const LineNumbers({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final lines = '\n'.allMatches(controller.text).length + 1;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.hp(0.015),
        horizontal: Responsive.wp(0.025),
      ),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Appcolor.panelEdge,
            width: Responsive.wp(0.002),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          lines,
          (i) => Text(
            '${i + 1}',
            style: TextStyle(
              color: Appcolor.muted,
              fontSize: Responsive.sp(0.04),
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
