import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class InputPanel extends StatelessWidget {
  const InputPanel({
    super.key,
    required this.inputController,
    required this.height,
  });

  final TextEditingController inputController;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'If your program needs more than one input, put each value on its own line.',
          style: TextStyle(
            color: Appcolor.muted,
            fontSize: Responsive.sp(0.032),
            height: 1.4,
          ),
        ),
        SizedBox(height: Responsive.hp(0.01)),
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: Appcolor.bg,
            borderRadius: BorderRadius.circular(Responsive.wp(0.035)),
            border: Border.all(
              color: Appcolor.panelEdge,
              width: Responsive.wp(0.002),
            ),
          ),
          child: TextField(
            controller: inputController,
            maxLines: null,
            expands: true,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Appcolor.white,
              fontSize: Responsive.sp(0.038),
              fontFamily: 'monospace',
              height: 1.5,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(Responsive.wp(0.03)),
              hintText: 'e.g.\nAhmed\n25',
              hintStyle: TextStyle(
                color: Appcolor.muted,
                fontSize: Responsive.sp(0.035),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
